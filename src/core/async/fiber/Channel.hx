package core.async.fiber;

import java.vm.Thread;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Channel for communitcation between fibers
 * Not buffered
 * TODO: cross-platform
 */
class Channel<T> {
	/**
	 * Mutex?
	 */
	private var lock:ReentrantLock;

	/**
	 * For waiting event
	 */
	private var dataCond:Condition;

	/**
	 * Result of fiber
	 */
	private var result:T;

	public function new() {
		lock = new ReentrantLock();
		dataCond = lock.newCondition();
	}

	/**
	 * Send data
	 * @param v 
	 */
	public function send(v:T) {
		lock.lock();
		result = v;
		dataCond.signal();
		lock.unlock();
	}

	/**
	 * Read data
	 * @return T
	 */
	public function read():T {        
		lock.lock();
        Scheduler.instance.notifyLock(Thread.current());
        if (result == null) {
		    dataCond.await();
        }
		var res = result;
		result = null;
		
        lock.unlock();		
		return res;
	}
}
