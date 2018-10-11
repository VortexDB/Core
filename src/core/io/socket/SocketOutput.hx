package core.io.socket;

import haxe.io.Bytes;
import core.io.output.ISocketOutput;

#if java
import java.nio.channels.SocketChannel;

/**
 *  Output for socket
 */
class SocketOutput implements ISocketOutput {
	/**
	 * Constructor
	 */
	@:allow(core.io.socket.TcpChannel)
	private function new(nativeSocket:SocketChannel) {
	}

	/**
	 *  Write one byte
	 *  @param data - byte
	 */
	public function writeByte(data:Int):Void {
		throw "Not implemented";
	}

	/**
	 *  Write bytes to stream
	 *  @param data - byte array
	 *  @return Number of bytes written
	 */
	public function writeBytes(data:Bytes):Int {
		throw "Not implemented";
	}

	/**
	 *  Write string to stream
	 *  @param data - some string
	 */
	public function writeString(data:String) {
		throw "Not implemented";
	}

	/**
	 *  Close stream
	 */
	public function close():Void {
		throw "Not implemented";
	}
}
#end