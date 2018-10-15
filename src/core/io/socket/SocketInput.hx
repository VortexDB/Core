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
	 * Bytes to read when reading line
	 */
	public static inline final READ_LINE_BYTES = 1024;	

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
	 * Scan buffer for new line
	 * @return Int
	 */
	private function getNewLineIdx():Int {
		for (i in 0...readBuffer.length) {
			var b = readBuffer.getByte(i);
			if (b == 0x0A) {
				return i;
			}			
		}
		return -1;
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
		if (readBuffer.isEmpty)
			channel.read();

		var res = readBuffer.splice(0, 1);
		return res.get(0);
	}

	/**
	 *  Read bytes
	 *  @param count - byte count to read
	 *  @return ByteArray
	 */
	public function readBytes(count:Int):Bytes {
		if (readBuffer.isEmpty)
			channel.read();
		var res = readBuffer.splice(0, count);
		return res;
	}

	/**
	 *  Read line from stream
	 *  @return String
	 */
	public function readLine():String {
		var idx = getNewLineIdx();
		while (idx < 0) {			
			channel.read();
			idx = getNewLineIdx();
		}
		
		var res = readBuffer.splice(0, idx).toString();
		return res;
	}

	/**
	 *  Close stream
	 */
	public function close():Void {
		this.nativeSocket.close();
	}
}
#end
