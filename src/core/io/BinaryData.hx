package core.io;

import haxe.io.BytesData;
import core.utils.exceptions.Exception;
import haxe.io.Bytes;

/**
 * For working with bytes in memory
 * TODO: Big/Little Endian
 */
class BinaryData {
	/**
	 *  Size for buffer incement
	 */
	public static inline var INCREMENT_SIZE:Int = 10000;

	/**
	 * Bytes data
	 */
	var buffer:Bytes;

	/**
	 *  Total size of allocated memory
	 */
	var size:Int;

	/**
	 *  Length of buffer
	 */
	public var length(default, null):Int;

	/**
	 * Is binary data empty
	 */
	public var isEmpty(get, null):Bool;

	private function get_isEmpty():Bool {
		return length < 1;
	}

	/**
	 *  Resize buffer
	 *  @param newsize - new binary data size
	 */
	private function resize(newsize:Int) {
		if (buffer == null) {
			buffer = Bytes.alloc(newsize);
			return;
		}

		var nbuffer = Bytes.alloc(newsize);
		nbuffer.blit(0, buffer, 0, buffer.length);
		buffer = nbuffer;
		size = newsize;
	}

	/**
	 *  Add size of buffer by INCREMENT_SIZE
	 */
	private function incSize(?incement:Int) {
		var inc = incement != null ? incement : INCREMENT_SIZE;
		resize(size + inc);
	}

	/**
	 *  Prepare byte array size
	 */
	private inline function prepareSize(needSize:Int) {
		if (length + needSize >= size) {
			incSize(needSize >= INCREMENT_SIZE ? needSize : INCREMENT_SIZE);
		}
	}

	/**
	 *  Insert hole in buffer for data
	 *  @param pos - position
	 *  @param len - length
	 */
	private function insertSize(pos:Int, len:Int) {
		var ln = length + len;
		if (ln > size)
			resize(ln + INCREMENT_SIZE);
		var sz = length - pos;
		var right = buffer.sub(pos, sz);
		buffer.blit(pos + len, right, 0, right.length);
		length += len;
	}

	/**
	 * Return BinaryData from existed Bytes buffer
	 */
	public static function ofBytes(data:Bytes):BinaryData {
		var binary = new BinaryData();
		binary.buffer = data;
		binary.length = data.length;
		binary.size = data.length;
		return binary;
	}

	/**
	 * Return BinaryData from string
	 */
	public static function ofString(data:String):BinaryData {
		return BinaryData.ofBytes(Bytes.ofString(data));
	}

	/**
	 * Creates BinaryData from array of byte
	 * @param data
	 * @return BinaryData
	 */
	public static function ofArray(data:Array<Int>):BinaryData {
		var res = new BinaryData();
		for (b in data) {
			res.addByte(b);
		}
		return res;
	}

	/**
	 * Alloc binary data
	 * @param length 
	 * @return BinaryData
	 */
	public static function alloc(length:Int):BinaryData {
		var res = new BinaryData();
		res.resize(length);
		res.length = length;
		return res;
	}

	/**
	 *  Create new Binary Data with prealloced length
	 */
	public function new() {
		size = 0;
		length = 0;
	}

	/**
	 * Clear buffer and trim it to INCREMENT_SIZE if needed
	 */
	public function clear() {
		if (length > INCREMENT_SIZE) {
			buffer = null;
			resize(INCREMENT_SIZE);
		}
		length = 0;
	}

	/**
	 *  Append byte to the end of buffer
	 *  @param data - byte
	 */
	public function addByte(data:Int) {
		if (length >= size)
			incSize();
		setByte(length, data);
		length += 1;
	}

	/**
	 *  Set byte at position
	 *  @param data - byte
	 */
	public inline function setByte(pos:Int, data:Int) {
		buffer.set(pos, data);
	}

	/**
	 *  Insert byte
	 *  @param data - byte
	 */
	public function insertByte(pos:Int, data:Int) {
		insertSize(pos, 1);
		setByte(pos, data);
	}

	/**
	 * Get byte by position
	 * @param pos
	 * @return Int
	 */
	public function getByte(pos:Int):Int {
		return buffer.get(pos);
	}

	/**
	 *  Add Int16 to the end of buffer
	 *  @param data - Int16 data
	 */
	public function addInt16(data:Int) {
		prepareSize(2);
		addByte((data & 0xFF00) >> 8);
		addByte((data & 0xFF));
	}

	/**
	 * Read Int16 by position
	 * @param pos
	 * @return Int
	 */
	public function getInt16(pos:Int):Int {
		return (buffer.get(pos) << 8) + buffer.get(pos + 1);
	}

	/**
	 * Get string line from position.
	 * Returns line and end position of line
	 * @param pos
	 * @return String
	 */
	public function getLine(pos:Int):Null<{text:String, endPos:Int}> {
		var endPos = -1;
		for (i in pos...buffer.length) {
			var b = buffer.get(i);
			if (b == 0x0A) {
				if (i == pos) {
					pos += 1;
				} else {
					endPos = i;
					break;
				}
			}
		}

		if (endPos <= 0)
			return null;

		var len = endPos - pos;
		var str = buffer.getString(pos, len);
		return {text: str, endPos: endPos};
	}

	/**
	 *  Add Int32 to the end of buffer
	 *  @param data - Int32 data
	 */
	public function addInt32(data:Int) {
		prepareSize(4);
		addByte((data & 0xFF000000) >> 24);
		addByte((data & 0xFF0000) >> 16);
		addByte((data & 0xFF00) >> 8);
		addByte((data & 0xFF));
	}

	/**
	 * Add bytes to buffer
	 * @param data
	 */
	public function addBytes(data:Bytes, ?count:Int) {
		var cnt = count == null ? data.length : count;
		prepareSize(cnt);
		buffer.blit(length, data, 0, cnt);
		length += cnt;
	}

	/**
	 * Add bytes data(NativeArray) to buffer
	 * @param data
	 */
	public function addBytesData(data:BytesData, ?count:Int) {
		var bytes = Bytes.ofData(data);
		addBytes(bytes, count);
	}

	/**
	 * Add BinaryData to buffer
	 * @param data
	 */
	public function addBinaryData(data:BinaryData) {
		var bytes = data.toBytes();
		addBytes(bytes);
	}

	/**
	 * Add string to buffer
	 * @param data
	 */
	public function addString(data:String) {
		addBytes(Bytes.ofString(data));
	}

	/**
	 * Slice buffer by position and count
	 * If pos + count more than length then return slice from position to the end of buffer
	 * @param idx
	 * @param count
	 * @return BinaryData
	 */
	public function slice(pos:Int, count:Int):Bytes {
		if (pos >= length)
			throw new Exception("Out of bound");
		var len = pos + count <= length ? count : length - pos;
		var bytes = Bytes.alloc(len);
		bytes.blit(0, buffer, pos, len);
		return bytes;
	}

	/**
	 * Cut data from buffer
	 * @param pos
	 * @param count
	 * @return BinaryData
	 */
	public function splice(pos:Int, count:Int):Bytes {
		if (pos >= length)
			throw new Exception("Out of bound");

		var res = slice(pos, count);
		var cpPos = pos + res.length;
		if (cpPos >= length) {
			length = length - res.length;
		} else {
			var part = slice(cpPos, length);
			buffer.blit(pos, part, 0, part.length);
			length = pos + part.length;
		}

		return res;
	}

	/**
	 *  Get all bytes from binary data
	 */
	public function toBytes():Bytes {
		return buffer.sub(0, length);
	}

	/**
	 * Convert to HEX
	 * @return String
	 */
	public function toHex():String {
		return toBytes().toHex();
	}
}
