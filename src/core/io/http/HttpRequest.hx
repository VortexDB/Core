package core.io.http;

import core.io.socket.TcpChannel;
import core.utils.Uri;

using StringTools;

/**
 *  Request from client
 */
class HttpRequest {
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
	 *  Request body
	 */
	public var body:LimitedReader;

	/**
		Read all headers
	**/
	private function readHeaders(channel:TcpChannel):Void {
		var text = channel.input.readLine();
		if (text == null)
			throw "Connection closed"; // TODO: create internal error class to catch them
		var line = text.trim();
		var parts = line.split(" ");
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
	private function readBody(channel:AbstractTcpSocket):Void {
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
	 *  Constructor
	 *  @param channel -
	 */
	public function new(channel:AbstractTcpSocket) {
		readHeaders(channel);
		readBody(channel);
	}
}
