package core.io.http.server;

import haxe.Log;
import core.utils.exceptions.Exception;
import core.io.socket.TcpListener;
import core.io.socket.TcpChannel;
import core.io.http.server.handler.Handler;

/**
 *  Embedded http server for tarantool
 */
class HttpServer {
	/**
	 *  Server socket
	 */
	var socket:TcpListener;

	/**
	 *  First handler
	 */
	var firstHandler:Handler;

	/**
	 *  Last handler
	 */
	var lastHandler:Handler;

	/**
	 *  Process client requests
	 *  @param peer - client peer
	 *  @param channel - read write channel
	 */
	function processClient(channel:TcpChannel) {
		var request = new HttpRequest(channel);
		request.read().onSuccess((e) -> {
			var response = new HttpResponse(channel);
			var context = new HttpContext(request, response);
			firstHandler.process(context);
			processClient(channel);
		}).onError((e) -> {
			Log.trace(e);
			channel.close();
		});
	}

	/**
	 *  Constructor
	 */
	public function new() {}

	/**
	 *  Add http request handler
	 *  @param handler - request handler
	 */
	public function addHandler(handler:Handler):Void {
		if (firstHandler == null) {
			firstHandler = handler;
			lastHandler = handler;
		}

		lastHandler.Next = handler;
		lastHandler = handler;
	}

	/**
	 *  Bind server to host and port
	 *  @param host - Example: * - for all possible ip, localhost, 192.168.0.196, mysite.ru
	 *  @param port - Example: 80, 8080
	 */
	public function bind(endpoint:TcpListenerParameters):Void {
		if (firstHandler == null)
			throw new Exception("No handlers");
		this.socket = new TcpListener(endpoint);
		this.socket.onAccept = (c) -> {
			processClient(c);
		};

		this.socket.bind();
	}
}
