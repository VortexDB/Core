package core.io.socket;

import core.async.fiber.Channel;
import haxe.io.Bytes;
import core.io.input.ISocketInput;

#if java

import java.nio.channels.SocketChannel;
import java.nio.ByteBuffer;

/**
 * For getting data from socket
 */
@:allow(core.io.socket.TcpChannel)
class SocketInput implements ISocketInput {
	/**
	 * Buffer for reading bytes
	 */
	private final readBuffer:BinaryData;

	/**
	 * Channel to signal about data
	 */
	private final channel:Channel<Bool>;

	/**
	 * Native socket
	 */
	private final nativeSocket:SocketChannel;

	/**
	 * Append buffer to read buffer
	 * @param buffer 
	 */
	private function appendRead(buffer:ByteBuffer, count:Int) {
		readBuffer.addBytesData(buffer.array(), count);
		channel.send(true);
	}

	/**
	 * Constructor
	 */	
	private function new(nativeSocket:SocketChannel) {
		this.nativeSocket = nativeSocket;
		this.readBuffer = new BinaryData();
		this.channel = new Channel<Bool>();
	}

	/**
	 *  Read one byte
	 *  @return Int
	 */
	public function readByte():Int {		
		return 0;
	}

	/**
	 *  Read bytes
	 *  @param count - byte count to read
	 *  @return ByteArray
	 */
	public function readBytes(count:Int):Bytes {
		channel.read();
		var res = readBuffer.splice(0, count);
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
