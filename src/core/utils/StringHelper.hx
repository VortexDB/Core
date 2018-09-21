package core.utils;

import haxe.io.Bytes;
import haxe.crypto.Adler32;

/**
 * Utility class for calculation hashes
 */
class StringHelper {
	/**
	 * Calculate hash for string
	 * @param value
	 * @return Int
	 */
	public static function hashCode(value:String):Int {
		if (value == null)
			return 0;

		var bytes = Bytes.ofString(value);
		return Adler32.make(bytes);
	}
}
