package core.async.fiber;

/**
 * Call of fiber
 */
typedef FiberCall = () -> Void;

/**
 * Execute some code on thread
 */
@:allow(core.async.fiber.SchedulerWorker)
class Fiber {
    /**
     * Some callback
     */
    private var call: FiberCall;

    /**
     * Spawn a new fiber
     * @param call 
     * @return Fiber
     */
    public static function spawn(call:FiberCall):Fiber {
        var fiber = new Fiber(call);
        Scheduler.instance.add(fiber);
        return fiber;
    }

    /**
     * Constructor
     * @param call 
     */
    private function new(call:FiberCall) {
        this.call = call;
    }    
}