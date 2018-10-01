package core.utils.exceptions;

/**
 * Base class of exception
 */
class Exception {
	/**
	 * Exception message
	 */
	public final message:String;

	/**
	 * Constructor
	 * @param message
	 */
	public function new(message:String) {
		this.message = message;
	}
}
