package core.utils.exceptions;

/**
 * Base class of exception
 */
#if java
class Exception extends  java.lang.Throwable {
#else
class Exception
#end
	/**
	 * Exception message
	 */
	public final message:String;

	/**
	 * Constructor
	 * @param message
	 */
	public function new(message:String) {		
		#if java
		super(message);
		#end
		this.message = message;
	}
}
