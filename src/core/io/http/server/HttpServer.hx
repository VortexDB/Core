package core.io.http.server;

import java.vm.Thread;
import haxe.CallStack;
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
	 * Process unexpected error
	 * @param channel
	 * @param exception
	 */
	private function processUnhandledError(channel:TcpChannel, exception:Dynamic) {
		trace('Unexpected error: ${exception}');
		//trace(CallStack.toString(CallStack.callStack()));
		channel.close();
	}

	/**
	 *  Process client requests
	 *  @param peer - client peer
	 *  @param channel - read write channel
	 */
	private function processClient(channel:TcpChannel) {
		var request = new HttpRequest(channel);
		request.onData.listen((req)
			-> {
				var response = new HttpResponse(channel);
				var context = new HttpContext(req, response);
				try {
					firstHandler.process(context);
				} catch (ex:Dynamic) {
					processUnhandledError(channel, ex);
				}
			},
			(ex)
			-> {
				processUnhandledError(channel, ex);
			});
	}

	/**
	 *  Constructor
	 */
	public function new() {} /**
	 *  Add http request handler
	 *  @param handler - request handler
	 */

	public function addHandler(handler:Handler):Void {
		if (firstHandler == null) {
			firstHandler = handler;
			lastHandler = handler;
		} else {
			lastHandler.next = handler;
			lastHandler = handler;
		}
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
