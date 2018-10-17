package core.io.http;

import core.async.future.Future;
import haxe.io.Bytes;
import core.utils.exceptions.IoException.ConnectionClosed;
import core.io.socket.TcpChannel;
import core.utils.Uri;
import core.io.input.LimitedReader;

using StringTools;

/**
 *  Request from client
 */
class HttpRequest {
	/**
	 * Channel for client
	 */
	private final channel:TcpChannel;

	/**
	 *  Version
	 */
	public var version:HttpVersion;

	/**
	 *  Method
	 */
	public var method:HttpMethod;

	/**
	 *  Request resource
	 */
	public var url:Uri;

	/**
	 *  Request headers
	 */
	public var headers(default, null):Map<String, String>;

	/**
	 *  Buffer for incoming data
	 */
	public var buffer:BinaryData;

	/**
		Read all headers
	**/
	private function readHeaders(channel:TcpChannel):Void {
		var text = channel.input.readLine();
		if (text == null || text == "")
			throw new ConnectionClosed();
		var line = text.trim();		
		var parts:Array<String> = line.split(" ");
		if (parts.length != 3)
			throw HttpStatus.BadRequest;

		method = parts[0].toUpperCase();
		url = parts[1];

		headers = new Map<String, String>();

		line = channel.input.readLine().trim();
		while (line.length > 0) {
			var head = line.split(": ");
			if (head.length < 2)
				throw HttpStatus.BadRequest;
			headers[head[0]] = head[1];
			line = channel.input.readLine().trim();
		}
	}

	/**
	 *  Read body
	 *  @param channel -
	 */
	private function readBody(channel:TcpChannel):Void {
		body = null;
		if (method == HttpMethod.Get)
			return;

		if (headers.exists("Content-Length")) {
			var len = Std.parseInt(headers["Content-Length"]);
			if (len < 1)
				return;
			body = new LimitedReader(channel.input, len);
		} else if (headers["Transfer-Encoding"] == "chunked") {}
	}

	/**
	 * Process on data from channel
	 * @param data 
	 */
	private function onData(channel:TcpChannel, data:Bytes) {

	}

	/**
	 *  Constructor
	 *  @param channel -
	 */
	public function new(channel:TcpChannel) {
		this.channel = channel;
		channel.onData = onData;
	}

	/**
	 * Read from request
	 * @return Future<Bool>
	 */
	public function read():Future<Bool> {
		future = Future.now(() -> {
			return true;
		});

		return future;
	}
}
