package core.io.socket;

import haxe.io.Bytes;
import core.io.output.ISocketOutput;

#if java
import java.nio.channels.SocketChannel;
import java.nio.ByteBuffer;

/**
 *  Output for socket
 */
class SocketOutput implements ISocketOutput {
	/**
	 * Native socket
	 */
	private final nativeSocket:SocketChannel;

	/**
	 * Constructor
	 */
	@:allow(core.io.socket.TcpChannel)
	private function new(nativeSocket:SocketChannel) {
		this.nativeSocket = nativeSocket;
	}

	/**
	 *  Write one byte
	 *  @param data - byte
	 */
	public function writeByte(data:Int):Void {
		var bytes = ByteBuffer.allocate(1);
		bytes.put(data);
		nativeSocket.write(bytes);
	}

	/**
	 *  Write bytes to stream
	 *  @param data - byte array
	 *  @return Number of bytes written
	 */
	public function writeBytes(data:Bytes):Int {
		var bytes = ByteBuffer.wrap(data.getData());		
		return nativeSocket.write(bytes);
	}

	/**
	 *  Write string to stream
	 *  @param data - some string
	 */
	public function writeString(data:String) {
		var bytes = ByteBuffer.wrap(Bytes.ofString(data).getData());
		nativeSocket.write(bytes);
	}

	/**
	 *  Close stream
	 */
	public function close():Void {
		nativeSocket.close();
	}
}
#end