package core.async;

/**
 * Internal waiter struct
 */
typedef __Waiter = {
    /**
     * Call to wait
     */
    var call: () -> Void;

    /**
     * Was waited to not hang
     */
    var wasWaited:Bool;
}

/**
 * Abstract on __Waiter
 */
abstract Waiter(__Waiter) from __Waiter to __Waiter {
    /**
     * Constructor
     * @param call 
     * @return ->Void)
     */
    public function new(call:()->Void) {
        this = {
            call:call,
            wasWaited:false
        };
    }

    /**
     * Start wait o return if was waited
     */
    public function wait() {
        if (this.wasWaited)
            return;

        this.wasWaited = true;
        this.call();
    }
}