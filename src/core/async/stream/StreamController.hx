package core.async.stream;

/**
 * Stream controller
 */
class StreamController<T> {
	/**
	 * Stream for data
	 */
	public final stream:Stream<T>;

	/**
	 * Constructor
	 */
	public function new() {
		stream = new Stream<T>();
	}

	/**
	 * Add value to stream
	 * @param value 
	 */
	public function add(value:T):Void {
        stream.add(value);
    }

	/**
	 * Add exception
	 * @param e 
	 */
	public function addError(e:Dynamic) {
		stream.addError(e);
	}

	/**
	 * Close stream
	 */
	public function close():Void {
		stream.close();
	}
}