package core.io.http.server.handler.websocket;

import core.async.stream.StreamController;
import core.async.stream.Stream;
import core.io.websocket.WebsocketProcessor;

/**
 *  Web socket handler for http server
 */
class WebSocketHandler extends Handler {
	/**
	 * Controller for onEvent
	 */
	private final onEventController:StreamController<WSChannelEvent>;

	/**
	 * Stream with events
	 */
	public final onEvent:Stream<WSChannelEvent>;

	/**
	 *  Constructor
	 */
	public function new() {
		onEventController = new StreamController<WSChannelEvent>();
		onEvent = onEventController.stream;
	}

	/**
	 *  Process request
	 *  @param context - Http context
	 */
	public override function process(context:HttpContext):Void {
		if (context.request.headers.exists(HttpHeaderType.Upgrade)) {
			var wsprocessor = new WebsocketProcessor(context.response.channel, context.request.headers);
			wsprocessor.onEvent.listen((event) -> {
				onEventController.add(event);
			});
			wsprocessor.start();
		} else {
			callNext(context);
		}
	}
}
