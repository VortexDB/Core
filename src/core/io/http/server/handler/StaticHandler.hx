package core.io.http.server.handler;

/**
 *  Process static content
 */
class StaticHandler extends Handler {
	/**
	 *  Paths to process
	 */
	public var paths:Map<String, String>;

	/**
	 *  Constructor
	 */
	public function new() {
		paths = new Map<String, String>();
	}

	/**
	 *  Add path that can be processed
	 *  @param path - relative path from working dir
	 */
	public function addPath(path:String) {
		if (!Path.exists(path))
			throw new Exception('Directory ${path} not exists');
		var parts = path.split("/");
		var parts = parts.filter(function(s:String) {
			return s != "" && s != "." && s != "..";
		});
		var newPath = parts.join("/");
		paths.set(newPath, newPath);
	}

	/**
	 *  Process request
	 *  @param context - Http context
	 */
	public override function process(context:HttpContext):Void {
		var path:String = context.request.url.path;
		var parts = path.split("/");
		var fileName = parts.pop();
		var parts = parts.filter(function(s:String) {
			return s != "" && s != "." && s != "..";
		});
		var first = parts[0];
		var newPath = parts.join("/");

		if (paths.exists(first)) {
			var fl = './${newPath}/${fileName}';
			if (Path.exists(fl)) {
				var mime = MimeTypes.getMimeType(fileName);
				context.response.headers[HttpHeaderType.ContentType] = mime;

				var file = new File(fl);
				var data = file.readAllBytes(fl);
				context.response.writeBytes(data);
				context.response.close();
			} else {
				throw HttpStatus.NotFound;
			}
		} else {
			callNext(context);
		}
	}
}
