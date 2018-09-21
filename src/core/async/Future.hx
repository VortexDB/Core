package core.async;

import haxe.macro.Expr.Catch;
import haxe.Timer;

/**
 * Callback on success execution of Future
 */
typedef OnSuccessCall<T> = (result:T) -> Void;

/**
 * Callback on error
 */
typedef OnErrorCall = (e:Dynamic) -> Void;

/**
 * Async task with promise of result or error
 * TODO: remove haxe timers, use platform depended classes
 */
class Future<T> {
	/**
	 * Some result on success execution
	 */
	private var result:T;

	/**
	 * Callback on success
	 */
	private var onSuccessCall:OnSuccessCall<T>;

	/**
	 * Callback on success
	 */
	private var onErrorCall:OnErrorCall;

	/**
	 * Constructor
	 * @param call 
	 * @return -> T)
	 */
	public function new(call:() -> T) {
		Timer.delay(function() {
			try {
				result = call();
				if (onSuccessCall != null)
					onSuccessCall(result);
			} catch (e:Dynamic) {
				if (onError != null)
					onErrorCall(e);
			}
		}, 0);
	}

	/**
	 * Sets callback on success
	 * @param call
	 * @return -> Void)
	 */
	public function onSuccess(call:OnSuccessCall<T>) {}

	/**
	 * Callback on error
	 * @param call
	 * @return -> Void)
	 */
	public function onError(call:OnErrorCall) {}
}
