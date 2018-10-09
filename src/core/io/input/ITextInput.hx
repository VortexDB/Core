package core.io.input;

/**
 *  Can read text
 */
interface ITextInput {
	/**
	 *  Read line from stream
	 *  @return String
	 */
	public function readLine():String;
}
