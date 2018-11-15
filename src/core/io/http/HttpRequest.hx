package core.io.http;

import core.async.stream.Stream;
import core.async.stream.StreamController;
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
	 * On data controller
	 */
	private final onDataController:StreamController<HttpRequest>;

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
	 * On request stream
	 */
	public final onData:Stream<HttpRequest>;

	/**
	 * Return next line from buffer
	 */
	private function nextLine():String {
		var line = buffer.getLine(linePos);
		if (line == null)
			return null;

		linePos = line.endPos + 1;
		return line.text.trim();
	}

	/**
		Read all headers
	**/
	private function readHeaders():Bool {
		var line = nextLine();
		if (line == null || line == "")
			return false;

		var parts:Array<String> = line.split(" ");
		if (parts.length != 3) {
			trace("BAD REQUEST 1");
			// TODO: exception
			throw HttpStatus.BadRequest;
		}

		method = parts[0].toUpperCase();
		url = parts[1];

		headers = new Map<String, String>();

		line = nextLine();
		if (line == null)
			return false;

		while (line.length > 0) {
			var head = line.split(": ");
			if (head.length < 2) {
				// TODO: exception
				trace("BAD REQUEST 2");
				throw HttpStatus.BadRequest;
			}
			headers[head[0]] = head[1];
			line = nextLine();
			if (line == null)
				return false;
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
	private function onBytesData(data:Bytes) {
		try {
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
					buffer.clear();
					state = Headers;
					onDataController.add(this);
				}
			}
		} catch (ex:Dynamic) {
			onDataController.addError(ex);
		}
	}

	/**
	 *  Constructor
	 *  @param channel -
	 */
	public function new(channel:TcpChannel) {
		linePos = 0;
		this.buffer = new BinaryData();
		this.channel = channel;
		this.onDataController = new StreamController<HttpRequest>();
		this.onData = this.onDataController.stream;
		channel.onData.listen(onBytesData);
	}
}
