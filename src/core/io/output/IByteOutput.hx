package core.io.output;

import haxe.io.Bytes;

/**
 *  Can write bytes
 */
interface IByteOutput {
	/**
	 *  Write byte to stream
	 *  @param data - byte
	 */
	public function writeByte(data:Int):Void;

	/**
	 *  Write bytes to stream
	 *  @param data - byte array
	 *  @return Number of bytes written
	 */
	public function writeBytes(data:Bytes):Int;
}
