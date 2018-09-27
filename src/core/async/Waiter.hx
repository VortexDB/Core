package core.async;

typedef __Waiter = {
    var call: () -> Void;
    var wasWaited:Bool;
}

abstract Waiter(__Waiter) from __Waiter to __Waiter {
    public function new(call:()->Void) {
        this = {
            call:call,
            wasWaited:false
        };
    }

    public function wait() {
        if (this.wasWaited)
            return;

        this.wasWaited = true;
        this.call();
    }
}