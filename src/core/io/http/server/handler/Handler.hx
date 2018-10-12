package core.io.http.server.handler;

/**
 *  Handler for request
 */
class Handler {
	/**
	 *  Next handler
	 */
	public var Next:Handler;

	/**
	 *  Process request, for override
	 *  @param context -
	 *  @return Bool
	 */
	public function process(context:HttpContext):Void {}

	/**
	 *  Call next handler
	 */
	public function callNext(context:HttpContext) {
		if (Next != null) {
			Next.process(context);
		} else {
			// Not found
		}
	}
}
