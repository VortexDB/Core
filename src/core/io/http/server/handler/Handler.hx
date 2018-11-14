package core.io.http.server.handler;

/**
 *  Handler for request
 */
class Handler {
	/**
	 *  Next handler
	 */
	public var next:Handler;

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
		if (next != null) {
			next.process(context);
		} else {
			throw HttpStatus.NotFound;
		}
	}
}
