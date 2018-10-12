package core.io.http;

import haxe.io.Bytes;
import core.io.output.ISocketOutput;
import core.io.socket.TcpChannel;

/**
 *  Response to client
**/
class HttpResponse implements ISocketOutput {
	/**
	 *  Buffer for response
	**/
	var buffer:BinaryData;

	/**
	 *  Raw channel for write/read data
	 */
	public var channel(default, null):TcpChannel;

	/**
	 *  Response headers
	**/
	public var headers(default, null):Map<String, String>;

	/**
	 *  Response status
	 */
	public var status:HttpStatus = HttpStatus.Ok;

	/**
	 *  Write headers to channel
	 */
	private function writeHeaders() {
		headers[HttpHeaderType.ContentLength] = Std.string(buffer.length);
		headers[HttpHeaderType.Server] = "immortal";

		for (k in headers.keys()) {
			var v = headers.get(k);
			channel.output.writeString('${k}: ${v}\n');
		}

		channel.output.writeString("\n");
	}

	/**
	 *  Constructor
	 *  @param channel -
	 */
	public function new(channel:TcpChannel) {
		this.channel = channel;
		headers = new Map<String, String>();
		reset();
	}

	/**
	 *  Reset response
	 */
	public function reset() {
		buffer = new BinaryData();
	}

	/**
	 *  Write byte to stream
	 *  @param data - byte
	 */
	public function writeByte(data:Int):Void {
		buffer.addByte(data);
	}

	/**
	 *  Write bytes to stream
	 *  @param data - byte array
	 *  @return Number of bytes written
	 */
	public function writeBytes(data:Bytes):Int {
		buffer.addBytes(data);
		return data.length;
	}

	/**
	 *  Write string to stream
	 *  @param data - some string
	 */
	public function writeString(data:String) {
		buffer.addString(data);
	}

	/**
	 *  Write http response
	 */
	public function close():Void {
		var descr = status.getDescription();
		channel.output.writeString('HTTP/1.1 ${status} ${descr}\n');
		writeHeaders();
		channel.output.writeBytes(buffer.toBytes());
	}
}
