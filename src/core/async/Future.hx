package core.async;

import core.async.Waiter;

/**
 * Async task with promise of result or error
 * It's bad, it's slow. But it works
 */
class Future<T> {
	/**
	 * Some result on success execution
	 */
	private var result:T;

	/**
	 * For wait on complete
	 */
	private final awaiter:Waiter;

	/**
	 * Callback on success
	 */
	private var onSuccessImp:(T) -> Void;

    /**
     * Is future complete
     */
    public var isComplete:Bool;

	/**
	 * Wait all futures
	 * @param futures
	 * @return Iterable<T>
	 */
	public static function waitAll<T>(futures:Iterable<Future<T>>):Array<T> {
		var res = new Array<T>();
		for (fut in futures) {
			res.push(fut.wait());
		}
		return res;
	}

	/**
	 * Constructor
	 */
	public function new(call:() -> T) {
        isComplete = false;

		awaiter = FutureExecuter.instance.execute(() -> {
			result = call();
            isComplete = true;
			if (onSuccessImp != null) {				
				onSuccessImp(result);
			}
		});
	}

	/**
	 * Wait for execution or throw Exception
	 * Throws TimeoutException on timeout
	 * @return T
	 */
	public function wait(?timeout:Int):T {
        // if (isComplete)
        //     return result;

		awaiter.wait();
		return result;
	}

	/**
	 * Set on success callback
	 */
	public function onSuccess(call:(T) -> Void) {        
		onSuccessImp = call;
        awaiter.wait();
	}
}
