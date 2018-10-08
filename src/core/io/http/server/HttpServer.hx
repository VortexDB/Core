package core.io.http.server;

/**
 *  Embedded http server for tarantool
 */
class HttpServer {
	/**
	 *  Server socket
	 */
	var socket:AbstractTcpSocket;

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
	function processClient(channel:AbstractTcpSocket) {
		try {
			while (true) {
				var request = new HttpRequest(channel);
				var response = new HttpResponse(channel);
				var context = new HttpContext(request, response);
				firstHandler.process(context);
			}
		} catch (e:SocketError) {
			// TODO: process error
			// trace (e);
		} catch (e:Dynamic) {
			trace(e);
			channel.output.close();
		}
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
	public function bind(host:String, port:Int):Void {
		if (firstHandler == null)
			throw "No handlers";
		var sock = new TcpSocket();
		this.socket = sock;

		sock.bind(host, port, function(c:TcpSocket) {
			processClient(c);
		});
	}
}
