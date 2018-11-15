package core.io.http.server.handler;

import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;

using StringTools;
using DateTools;

import core.utils.exceptions.Exception;
import core.utils.MimeTypes;

/**
 *  Process static content
 */
class StaticHandler extends Handler {
	/**
	 * Files with modified time
	 */
	private var modifiedMap = new Map<String, String>();

	/**
	 *  Paths to process
	 */
	public var paths:Map<String, String>;

	/**
	 * Strip path
	 * @param src
	 * @return String
	 */
	private function stripPath(path:String):String {
		var parts = path.split("/");
		var parts = parts.filter((s : String) -> {
			return s != "/" && s != "" && s != "." && s != "..";
		});
		return Path.join(parts);
	}

	/**
	 * Add single path
	 * @param path - path in http request
	 * @param dir - relative directory on disk
	 */
	private function addPathInternal(path:String, dir:String) {
		path = stripPath(path);
		dir = stripPath(dir);
		paths.set(path, dir);
	}

	/**
	 * Add path with recurse
	 * @param basePath
	 * @param baseDir
	 * @param path
	 */
	private function addPathRecurseInternal(basePath:String, baseDir:String, dir:String) {
		for (file in FileSystem.readDirectory(dir)) {
			var dirPath = Path.join([dir, file]);
			if (FileSystem.exists(dirPath) && FileSystem.isDirectory(dirPath)) {
				var fixPath = dirPath.replace(baseDir, basePath);
				addPathInternal(fixPath, dirPath);
				addPathRecurseInternal(basePath, baseDir, dirPath);
			}
		}
	}

	/**
	 *  Constructor
	 */
	public function new() {
		paths = new Map<String, String>();
	}

	/**
	 * Add path that can be processed
	 * @param path - path in http request
	 * @param dir - relative directory on disk
	 * @param recursive - add recursive directories
	 */
	public function addPath(path:String, dir:String, recursive:Bool = true) {
		if (!FileSystem.exists(dir))
			throw new Exception('Directory ${dir} not exists');

		addPathInternal(path, dir);

		if (recursive) {
			addPathRecurseInternal(path, dir, dir);
		}

		trace(paths);
	}

	/**
	 *  Process request
	 *  @param context - Http context
	 */
	public override function process(context:HttpContext):Void {
		var path:String = context.request.url.path;
		trace(path);
		var parts = path.split("/");
		var fileName = parts.pop();
		var parts = parts.filter((s) -> {
			return s != "" && s != "." && s != "..";
		});

		var newPath = parts.join("/");
		trace(newPath);
		var dir = paths.get(newPath);
		if (dir != null) {
			var dir = paths.get(newPath);
			var fl = './${dir}/${fileName}';
			trace(fl);
			if (FileSystem.exists(fl)) {
				var mime = MimeTypes.getMimeType(fileName);
				var fileStat = FileSystem.stat(fl);

				var storedModified = modifiedMap.get(fl);
				var modified = fileStat.mtime.format("%a, %d %b %Y %H:%M:%S GMT");
				if (modified == storedModified) {
					context.response.status = HttpStatus.NotModified;
				} else {
					context.response.headers[HttpHeaderType.ContentType] = mime;
					context.response.headers[HttpHeaderType.Date] = fileStat.ctime.format("%a, %d %b %Y %H:%M:%S GMT");
					context.response.headers[HttpHeaderType.LastModified] = modified;
					// TODO: async file?
					var data = File.getBytes(fl);
					context.response.writeBytes(data);
					modifiedMap[fl] = modified;
				}

				context.response.close();
			} else {
				// TODO: exception
				throw HttpStatus.NotFound;
			}
		} else {
			callNext(context);
		}
	}
}
