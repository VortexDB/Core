package core.io.socket;

import haxe.io.Bytes;
import core.io.input.ISocketInput;

/**
 * For getting data from socket
 */
class SocketInput implements ISocketInput {
	/**
	 *  Read one byte
	 *  @return Int
	 */
	public function readByte():Int {
		throw "Not implemented";
	}

	/**
	 *  Read bytes
	 *  @param count - byte count to read
	 *  @return ByteArray
	 */
	public function readBytes(count:Int):Bytes {
		throw "Not implemented";
	}

	/**
	 *  Read line from stream
	 *  @return String
	 */
	public function readLine():String {
		throw "Not implemented";
	}

	/**
	 *  Close stream
	 */
	public inline function close():Void {
		throw "Not implemented";
	}
}
