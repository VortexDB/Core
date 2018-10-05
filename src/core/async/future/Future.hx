package core.async.future;

import core.async.fiber.Channel;
import core.async.fiber.Fiber;

/**
 * Execute some code and return a promise of result
 */
class Future<T> {
	/**
	 * Fiber that executes code
	 */
	private final fiber:Fiber;

	/**
	 * Channel to transfer data
	 */
	private final channel:Channel<T>;

	/**
	 * On error call
	 */
	private var onErrorCall:(Dynamic) -> Void;

	/**
	 * On success call
	 */
	private var onSuccessCall:(T) -> Void;

	/**
	 * Result of future work
	 */
	private var result:T;

	/**
	 * Error that was catched
	 */
	private var error:Dynamic;

	/**
	 * Create future and execute it immidiatly
	 * @return Future<T>
	 */
	public static function now<T>(call:() -> T):Future<T> {
		return new Future(call);
	}

	/**
	 * Await all futures and return array of results
	 * @param futures 
	 * @return Array<T>
	 */
	public static function waitAll<T>(futures:Array<Future<T>>):Array<T> {
		var res = new Array<T>();
		for (future in futures) {
			res.push(future.await());
		}

		return res;
	}

	/**
	 * Constructor
	 */
	private function new(call:() -> T) {
		this.channel = new Channel<T>();
		this.fiber = Fiber.spawn(() -> {
			try {
				result = call();
				if (onSuccessCall != null)
					onSuccessCall(result);
			} catch (e:Dynamic) {
				error = e;
				if (onErrorCall != null)
					onErrorCall(e);
			}
            channel.send(result);
		});
	}

	/**
	 * Wait for result
	 */
	public function await():T {
		if (result != null)
			return result;
		var res = channel.read();
		if (error != null)
			throw error;
		return res;
	}

	/**
	 * Call on success
	 * @param call
	 * @return -> Void)
	 */
	public function onSuccess(call:(T) -> Void):Future<T> {
		onSuccessCall = call;
		return this;
	}

	/**
	 * Call on error
	 * @param call
	 * @return -> Void)
	 */
	public function onError(call:(Dynamic) -> Void):Future<T> {
		onErrorCall = call;
		return this;
	}
}
