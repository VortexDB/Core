package core.io.http.server.handler;

/**
 *  Process http request
 */
class HttpHandler extends Handler {
	/**
	 *  On request callback
	 */
	private var onRequest:(HttpContext)->Void;

	/**
	 *  Constructor
	 *  @param call - callback on request
	 */
	public function new(call:(HttpContext)->Void) {
		onRequest = call;
	}

	/**
	 *  Process request
	 *  @param context - Http context
	 */
	public override function process(context:HttpContext):Void {
		if (onRequest != null) {
			onRequest(context);
			context.response.close();
		}
	}
}
