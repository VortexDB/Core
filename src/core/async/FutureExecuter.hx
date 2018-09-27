package core.async;

import java.vm.Mutex;
import java.vm.Thread;

/**
 * Task for execution
 */
typedef ExecuterTask = {
    var call: () -> Void;
}

/**
 * Call to wait
 */
// typedef Waiter = () -> Void;

/**
 * Executes futures on thread
 * It's bad, it's slow. But it works
 * TODO: multi thread executing
 * TODO: cross-platform. Now it's java only
 */
class FutureExecuter {    
    /**
     * Instance of executer
     */
    public static final instance : FutureExecuter = new FutureExecuter();

    /**
     * Tasks to execute
     */
    private final tasks:Array<ExecuterTask>;

    /**
     * Thread that executes tasks
     */
    private final thread:Thread;

    /**
     * Private constructor
     */
    private function new() {
        tasks = new Array<ExecuterTask>();
        thread = Thread.create(work);
        thread.sendMessage(Thread.current());

    }

    /**
     * Main work of thread
     */
    private function work() {
        var main:Thread = Thread.readMessage(true);

        while (true) {            
            // Wait for task
            Thread.readMessage(true);

            var task = tasks.pop();
            task.call();
            main.sendMessage(true);
        }
    }

    /**
     * Execute on thread
     * @param call
     * @return -> Void)
     */
    public function execute(call:() -> Void):Waiter {
        var waiter = new Waiter(() -> {
            Thread.readMessage(true);
        });

        // Add new task
        tasks.insert(0, {
            call: call
        });
        
        // Start work
        thread.sendMessage(true);

        return waiter;
    }
}