package core.async.fiber;

import haxe.CallStack;
import java.vm.Thread;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Worker of schedule. Launches fibers
 */
class SchedulerWorker {
    /**
     * Mutex?
     */
    private var lock:ReentrantLock;

	/**
	 * To block and wait signal
	 */
	private var dataCond:Condition;

    /**
     * Current fiber
     */
    private var currentFiber:Fiber;

    /**
     * Fibers to launch
     */
    public var fibers:List<Fiber>;

    /**
     * Worker thread
     */
    public var backThread:Thread;

    /**
     * Is worker is blocked
     */
    public var isBlocked:Bool;

    /**
     * Main thread work that launches fibers
     */
    private function work() {
        var frontThread:Thread = cast Thread.readMessage(true);
        frontThread.sendMessage(true);
        while(true) {
            lock.lock();
            dataCond.await();
            lock.unlock();
            
            // TODO: need lock for pop?
            while(!fibers.isEmpty()) {
                currentFiber = fibers.pop();
                // TODO: handle exceptions? how?
                try {
                    currentFiber.call();
                } catch(e:Dynamic) {
                    var callStack = CallStack.toString(CallStack.callStack());
                    trace('Unhandled exception in fiber: ${e}');
                    trace(callStack);
                }
                currentFiber = null;
                isBlocked = false;
            }
        }
    }

    /**
     * Constructor
     */
    public function new() {
        lock = new ReentrantLock();
		dataCond = lock.newCondition();
        this.fibers = new List<Fiber>();
        this.backThread = Thread.create(work);
        this.backThread.sendMessage(Thread.current());
        Thread.readMessage(true);
    }

    /**
     * Signal to thread start work
     */
    public function start() {
        lock.lock();
        dataCond.signal();
        lock.unlock();
    }

    /**
     * Add new fiber to list
     * @param fiber 
     */
    public function add(fiber:Fiber) {
        this.fibers.add(fiber);
    }
}