package core.io.http.server.handler;

/**
 *  Handle errors
 */
class ErrorHandler extends Handler {
	/**
	 *  Callback to process error
	 */
	private var onError:HttpContext->HttpStatus->Void;

	/**
	 *  Process error
	 */
	private function processError(c:HttpContext, err:HttpStatus) {
		c.response.reset();
		c.response.status = err;

		if (onError != null) {
			try {
				onError(c, err);
			} catch (e:Dynamic) {
				c.response.reset();
				c.response.status = HttpStatus.Internal;
			}
		}

		c.response.close();
	}

	/**
	 *  Constructor
	 */
	public function new(call:HttpContext->HttpStatus->Void) {
		onError = call;
	}

	/**
	 *  Process request
	 *  @param context - Http context
	 */
	public override function process(context:HttpContext):Void {
		try {
			callNext(context);
		} catch (e:HttpStatus) {
			processError(context, e);
		} catch (e:Dynamic) {
			// TODO: log error somewhere
			processError(context, HttpStatus.Internal);
		}
	}
}
