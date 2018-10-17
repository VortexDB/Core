package core.async.future;

/**
 * Task with promise of result or error
 */
class Future<T> {
	/**
	 * On Error call
	 */
	private var onErrorCall:(Dynamic) -> Void;

	/**
	 * On success call
	 */
	private var onSuccessCall:(T) -> Void;

	/**
	 * Result of execution
	 */
	public var result:T;

	/**
	 * Catched error
	 */
	public var error:Dynamic;

	/**
	 * Create new future and execute it now
	 */
	public static function now<T>(call:() -> T):Future<T> {
		return new Future<T>(call);
	}

	/**
	 * Execute future
	 */
	private function execute(call:() -> T) {
		try {
			result = call();
			if (onSuccessCall != null)
				onSuccessCall(result);
		} catch (e:Dynamic) {
			error = e;
			if (onErrorCall != null) {
				onErrorCall(e);
			}
		}
	}

	/**
	 * Constructor
	 * @param call
	 * @return -> T, ?delay:Int)
	 */
	private function new(call:() -> T, ?delay:Int) {
		if (delay == null) {
			execute(call);
		}
	}

	/**
	 * Set on success call
	 * @param call
	 * @return -> Void)
	 */
	public function onSuccess(call:(T) -> Void):Future<T> {
		onSuccessCall = call;
		if (result != null)
			onSuccessCall(result);

		return this;
	}

	/**
	 * Set on error call
	 * @param call
	 * @return -> Void)
	 */
	public function onError(call:(Dynamic) -> Void) {
		onErrorCall = call;

		if (error != null)
			onErrorCall(error);
	}
}
