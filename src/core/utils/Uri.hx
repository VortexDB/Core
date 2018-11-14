package core.utils;

/**
 * Uniform Resource Identifier based on string
 * https://tools.ietf.org/html/rfc3986#appendix-B
 */
@:forward
abstract Uri(UrlFields) {
	/**
	 * Scheme position
	 */
	static inline var SCHEME = 2;

    /**
	 * Authority position
	 */
	static inline var AUTHORITY = 4;

    /**
	 * Scheme position
	 */
	static inline var PATH = 5;

    /**
	 * Query position
	 */
	static inline var QUERY = 7;

    /**
	 * Fragment position
	 */
	static inline var FRAGMENT = 9;

	/**
	 * Create uri from string
	 * @param value
	 * @return Uri
	 */
	@:from public static inline function fromString(value:String):Uri {
		return new Uri(parseUri(value));
	}

	/**
	 * Parse uri
	 * @return Uri
	 */
	private static function parseUri(value:String):UrlFields {
		var uriReg = ~/^(([^:\/?#]+):)?(\/\/([^\/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?/;
		uriReg.match(value);		

		return {
			scheme: uriReg.matched(SCHEME),
            authority: uriReg.matched(AUTHORITY),
            path: uriReg.matched(PATH),
            query: uriReg.matched(QUERY),
            fragment: uriReg.matched(FRAGMENT)
		};
	}

	/**
	 * Constructor
	 * @param value
	 */
	public function new(value:UrlFields) {
		this = value;
	}
}

/**
 * Url data parts
 */
typedef UrlFields = {
	/**
	 * Example: https, ldap, mailto, news, tel, telnet
	 */
	@:optional var scheme(default, null):String;

	/**
	 * Example: //john.doe@www.example.com:123
	 */
	@:optional var authority(default, null):String;

	/**
	 * Example: /forum/questions/
	 */
	@:optional var path(default, null):String;

	/**
	 * Example: ?tag=networking&order=newest
	 */
	@:optional var query(default, null):String;

	/**
	 * Example: #top
	 */
	@:optional var fragment(default, null):String;
}
