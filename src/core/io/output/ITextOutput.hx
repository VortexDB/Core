package core.io.output;

/**
 *  Can write text
 */
interface ITextOutput {
	/**
	 *  Write string to stream
	 *  @param data - some string
	 */
	public function writeString(data:String):Void;
}
