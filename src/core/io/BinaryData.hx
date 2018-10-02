package core.io;

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
	public function addBytes(data:Bytes) {
		prepareSize(data.length);
		buffer.blit(length, data, 0, data.length);
		length += data.length;
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
	 * Slice buffer by position and count
	 * If pos + count more than length then return slice from position to the end of buffer
	 * @param idx
	 * @param count
	 * @return BinaryData
	 */
	public function slice(pos:Int, count:Int):BinaryData {
		if (pos >= length)
			throw new Exception("Out of bound");
		var len = pos + count <= length ? count : length - pos;
		var bytes = Bytes.alloc(len);
		bytes.blit(0, buffer, pos, len);
		return BinaryData.ofBytes(bytes);
	}

	/**
	 *  Get all bytes from binary data
	 */
	public function toBytes():Bytes {
		return buffer.sub(0, length);
	}
}
