package core.async;

import core.utils.exceptions.Exception;
import java.util.concurrent.FutureTask;
import java.util.concurrent.Executors;
import java.util.concurrent.Callable;

/**
 * For future task
 */
class FutureCallable<T> implements Callable<T> {
	/**
	 * Function on call
	 */
	private final fn:() -> T;

	/**
	 * Call on success
	 */
	public var onSuccess:(T) -> Void;

	/**
	 * Constructor
	 * @param fn
	 * @return -> T)
	 */
	public function new(fn:() -> T) {
		this.fn = fn;
	}

	/**
	 * Implementation of callable
	 * @return T
	 */
	public function call():T {
		var res = fn();
		if (onSuccess != null)
			onSuccess(res);
		return res;
	}
}

/**
 * Async task with promise of result or error
 * TODO: crossplatform. Now it' only for java
 * TODO: abstract of FutureTask for java, cause some methods are protected
 */
class Future<T> {
	/**
	 * Executor of futures
	 */
	private static var executor = Executors.newCachedThreadPool();

	/**
	 * Native java task
	 */
	private var nativeTask:FutureTask<T>;

	/**
	 * Callbalble
	 */
	private var callable:FutureCallable<T>;

	/**
	 * Some result on success execution
	 */
	private var result:T;

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
		callable = new FutureCallable<T>(call);
		nativeTask = new FutureTask<T>(callable);
		executor.execute(nativeTask);
	}

	/**
	 * Wait for execution or throw Exception
	 * Throws TimeoutException on timeout
	 * @return T
	 */
	public function wait(?timeout:Int):T {
		result = nativeTask.get(2000, java.util.concurrent.TimeUnit.MILLISECONDS);
		return result;
	}

	/**
	 * Completes future with result
	 * @param value
	 */
	public function complete(value:T) {
		//nativeTask.set(value);
	}

	/**
	 * Completes future with error
	 * @param e
	 */
	public function error(e:Exception) {
		//nativeTask.setException(e);
	}

	/**
	 * Set on success callback
	 */
	public function onSuccess(call:(T) -> Void) {
		callable.onSuccess = call;
	}
}
