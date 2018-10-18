package core.io.http;

import core.async.future.Future;
import haxe.io.Bytes;
import core.utils.exceptions.IoException.ConnectionClosed;
import core.io.socket.TcpChannel;
import core.utils.Uri;
import core.io.input.LimitedReader;

using StringTools;

/**
 * Read state
 */
enum RequestReadState {
	Headers;
	Body;
}

/**
 *  Request from client
 */
class HttpRequest {
	/**
	 * Channel for client
	 */
	private final channel:TcpChannel;

	/**
	 * For completion
	 */
	private var completion:CompletionFuture<HttpRequest>;

	/**
	 * State of reading
	 */
	private var state:RequestReadState = RequestReadState.Headers;

	/**
	 * Position in buffer for line search
	 */
	private var linePos:Int;

	/**
	 *  Buffer for incoming data
	 */
	private var buffer:BinaryData;

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
	 * Body of request
	 */
	public var body(default, null):Bytes;	

	/**
	 * Return next line from buffer
	 */
	private function nextLine():String {
		var line = buffer.getLine(0);
		if (line == null)
			return null;

		linePos = line.endPos + 1;
		return line.text;
	}

	/**
		Read all headers
	**/
	private function readHeaders():Bool {
		var text = nextLine().trim();
		if (text == null || text == "")
			return false;

		var line = text.trim();
		var parts:Array<String> = line.split(" ");
		if (parts.length != 3)
			// TODO: exception
			throw HttpStatus.BadRequest;

		method = parts[0].toUpperCase();
		url = parts[1];

		headers = new Map<String, String>();

		line = nextLine().trim();
		while (line.length > 0) {
			var head = line.split(": ");
			if (head.length < 2)
				// TODO: exception
				throw HttpStatus.BadRequest;
			headers[head[0]] = head[1];
			line = nextLine().trim();
		}

		return true;
	}

	/**
	 *  Read body
	 *  @param channel -
	 */
	private function readBody():Bool {
		body = null;
		if (method == HttpMethod.Get)
			return true;

		if (headers.exists("Content-Length")) {
			var len = Std.parseInt(headers["Content-Length"]);
			if (len < 1)
				return true;
			// TODO: wait for all data
			body = buffer.slice(linePos, len);
			return true;
		} else if (headers["Transfer-Encoding"] == "chunked") {
			return true;
		}

		return true;
	}

	/**
	 * Process on data from channel
	 * @param data
	 */
	private function onData(channel:TcpChannel, data:Bytes) {
		buffer.addBytes(data);

		if (state == Headers) {
			if (readHeaders()) {
				state = Body;
			} else {
				return;
			}
		}

		if (state == Body) {
			if (readBody()) {
				completion.complete(this);
			}
		}

		// read header
		// read body
		// notify
	}

	/**
	 *  Constructor
	 *  @param channel -
	 */
	public function new(channel:TcpChannel) {
		linePos = 0;
		this.channel = channel;
		channel.onData = onData;
	}

	/**
	 * Read from request
	 * @return Future<Bool>
	 */
	public function read():Future<HttpRequest> {
		completion = new CompletionFuture<HttpRequest>();
		return completion;
	}
}
