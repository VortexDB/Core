package core.utils;

/**
 * Exception on timeout
 */
class TimeoutException extends Exception {
	/**
	 * Constructor
	 * @param message
	 */
	public function new(message:String) {
		super(message);
	}
}
