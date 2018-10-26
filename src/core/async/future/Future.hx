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
	 * On complete call
	 */
	private var onCompleteCall:(Future<T>) -> Void;

	/**
	 * Block that be executed in future
	 */
	private var call:() -> T;

	/**
	 * Result of execution
	 */
	public var result:T;

	/**
	 * Catched error
	 */
	public var error:Dynamic;

	/**
	 * Create new future and execute it now sync
	 */
	public static function sync<T>(call:() -> T):Future<T> {
		return new SyncFuture<T>(call);
	}

	/**
	 * Constructor
	 * @param call
	 * @return -> T)
	 */
	public function new(call:() -> T) {
		this.call = call;
	}

	/**
	 * Set on success call
	 * @param call
	 * @return -> Void)
	 */
	public function onSuccess(call:(T) -> Void):Future<T> {
		// TODO: catch error
		onSuccessCall = call;
		if (result != null) {
			try {
				onSuccessCall(result);
			} catch (e:Dynamic) {
				error = e;
				if (onErrorCall != null)
					onErrorCall(e);
			}

			try {
				if (onCompleteCall != null)
					onCompleteCall(this);
			} catch (ex:Dynamic) {
				// Ignore
			}
		}

		return this;
	}

	/**
	 * Set on error call
	 * @param call
	 * @return -> Void)
	 */
	public function onError(call:(Dynamic) -> Void):Future<T> {
		onErrorCall = call;

		if (error != null) {
			onErrorCall(error);
			if (onCompleteCall != null)
				onCompleteCall(this);
		}

		return this;
	}

	/**
	 * On complete future call(success or not)
	 * @param call
	 * @return -> Void)
	 */
	public function onComplete(call:(Future<T>) -> Void) {
		onCompleteCall = call;
		if (result != null || error != null) {
			onCompleteCall(this);
		}
	}
}

/**
 * Task with promise of result or error
 */
@:allow(core.async.future.Future)
class SyncFuture<T> extends Future<T> {
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
	private function new(call:() -> T) {
		super(call);
		execute(call);
	}
}

/**
 * Future that completed manual
 */
class CompletionFuture<T> extends Future<T> {
	/**
	 * Constructor
	 * @param call
	 * @return -> T)
	 */
	public function new() {
		super(null);
	}

	/**
	 * Complete future with result
	 * @param result
	 */
	public function complete(result:T) {
		this.result = result;

		if (onSuccessCall != null)
			onSuccessCall(result);
	}

	/**
	 * Complete with error
	 * @param result
	 */
	public function throwError(error:Dynamic) {
		this.error = error;
		if (onErrorCall != null)
			onErrorCall(error);
	}
}
