package core.io.http.server.handler.websocket;

/**
 *  Web socket handler for http server
 */
class WebSocketHandler extends Handler {
	/**
	 *  Callbacks
	 */
	private var handler:IWSHandler;

	/**
	 *  Constructor
	 */
	public function new(handler:IWSHandler) {
		this.handler = handler;
	}

	/**
	 *  Process request
	 *  @param context - Http context
	 */
	public override function process(context:HttpContext):Void {
		if (context.request.headers.exists(HttpHeaderType.Upgrade)) {
			var ih = new InternalHandler(context);
			ih.onConnect = handler.onConnect;
			ih.onData = handler.onData;
			ih.onClose = handler.onClose;
			ih.onError = handler.onError;
			ih.start();
		} else {
			callNext(context);
		}
	}
}
