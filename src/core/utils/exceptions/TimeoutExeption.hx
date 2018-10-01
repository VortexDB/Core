package core.utils.exceptions;

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
