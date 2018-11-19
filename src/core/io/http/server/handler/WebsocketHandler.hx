package core.io.http.server.handler.websocket;

import core.io.websocket.WebsocketProcessor;

/**
 *  Web socket handler for http server
 */
class WebSocketHandler extends Handler {
	/**
	 *  Constructor
	 */
	public function new() {
	}

	/**
	 *  Process request
	 *  @param context - Http context
	 */
	public override function process(context:HttpContext):Void {
		if (context.request.headers.exists(HttpHeaderType.Upgrade)) {
			var ih = new WebsocketProcessor(context.response.channel, context.request.headers);
			ih.start();
		} else {
			callNext(context);
		}
	}
}
