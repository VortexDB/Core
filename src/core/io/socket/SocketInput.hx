package core.io.socket;

import haxe.io.Bytes;
import core.io.input.ISocketInput;

#if java

import java.nio.channels.SocketChannel;
import java.nio.ByteBuffer;

/**
 * For getting data from socket
 */
class SocketInput implements ISocketInput {
	/**
	 * Buffer read size
	 */
	public static inline final READ_SIZE = 1024;

	/**
	 * Buffer for reading one byte
	 */
	private final oneByteBuffer:ByteBuffer;

	/**
	 * Buffer for reading bytes
	 */
	private final readBuffer:ByteBuffer;

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
		this.oneByteBuffer = ByteBuffer.allocate(1);
		this.readBuffer = ByteBuffer.allocate(READ_SIZE);
	}

	/**
	 *  Read one byte
	 *  @return Int
	 */
	public function readByte():Int {
		nativeSocket.read(oneByteBuffer);		
		return oneByteBuffer.getInt(0);
	}

	/**
	 *  Read bytes
	 * TODO: too many copy
	 *  @param count - byte count to read
	 *  @return ByteArray
	 */
	public function readBytes(count:Int):Bytes {
		var read = nativeSocket.read(readBuffer);		
		var totalBytes = Bytes.ofData(readBuffer.array());
		var res = Bytes.alloc(read);
		res.blit(0, totalBytes, 0, read);
		return res;
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
		this.nativeSocket.close();
	}
}
#end
