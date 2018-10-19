package core.async.stream;

import core.async.future.Future;
import core.time.TimeSpan;

/**
 * State of stream
 */
enum StreamState {
	Init;
	Work;
	Closed;
}

@:allow(core.async.stream.StreamController)
class Stream<T> {
	/**
	 * State of stream
	 */
	public var state:StreamState;

	/**
	 * On data call
	 */
	private var onData:(T) -> Void;

	/**
	 * On done call
	 */
	private var onDone:() -> Void;

	/**
	 * Add value to stream
	 * @param value
	 */
	private function add(value:T) {
		if (onData != null)
			onData(value);
	}

	/**
	 * Close stream
	 */
	private function close() {
		state = StreamState.Closed;
		if (onDone != null) {
			state = StreamState.Closed;
			onDone();
		}
	}

	/**
	 * Listen for data
	 * @param call
	 */
	public function listen(onData:(T) -> Void, ?onError:(Dynamic) -> Void, ?onDone:() -> Void) {
		switch (state) {
			case StreamState.Work:
				throw "Stream already listened";
			case StreamState.Closed:
				throw "Stream is closed";
			default:
		}

		this.onData = onData;
		this.onDone = onDone;
		state = StreamState.Work;
	}

	/**
	 * Create new stream with checking timeout between data receive
	 * @param mseconds
	 * @return Stream<T>
	 */
	public function timeout(time:TimeSpan):Stream<T> {
		var res = new StreamController<T>();
		// TODO: timer

		listen((e) -> {
			res.add(e);
		}, (ex) -> {}, () -> {
			res.close();
		});

		return res.stream;
	}

	/**
	 * Create new from element
	 * @param block
	 * @return -> V)
	 */
	public function map<V>(block:(T) -> V):Stream<V> {
		var res = new StreamController<V>();
		listen((e) -> {
			var val = block(e);
			res.add(val);
		}, (ex) -> {}, () -> {
			res.close();
		});
		return res.stream;
	}

	/**
	 * Return future to array
	 * @return Future<Array<T>>
	 */
	public function toArray():Future<Array<T>> {
		var completer = new CompletionFuture<Array<T>>();
		var res = new Array<T>();
		listen((e) -> {
			res.push(e);
		}, (ex) -> {
			completer.throwError(ex);
		}, () -> {
			completer.complete(res);
		});

		return completer;
	}

	/**
	 * Constructor
	 */
	private function new() {
		state = StreamState.Init;
	}
}
