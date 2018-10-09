package core.io.input;

import haxe.io.Bytes;

/**
 *  Can read bytes
 */
interface IByteInput {
	/**
	 *  Read one byte
	 *  @return Int
	 */
	public function readByte():Int;

	/**
	 *  Read bytes
	 *  @param count - byte count to read
	 *  @return ByteArray
	 */
	public function readBytes(count:Int):Bytes;
}
