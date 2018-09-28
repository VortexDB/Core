package core.io;

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
	function resize(newsize:Int) {
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
	function insertSize(pos:Int, len:Int) {
		var ln = length + len;
		if (ln > size)
			resize(ln + INCREMENT_SIZE);
		var sz = length - pos;
        var right = buffer.sub(pos, sz);
        buffer.blit(pos + len, right, 0, right.length);
		length += len;
	}

	/**
	 *  Append byte
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
	 *  Constructor
	 */
	public function new() {
		size = 0;
		length = 0;
		resize(INCREMENT_SIZE);
	}

	/**
	 *  Add UInt32
	 *  @param data - UInt32 data
	 */
	public function addUInt32(data:Int) {
		prepareSize(4);
		addByte((data & 0xFF000000) >> 24);
		addByte((data & 0xFF0000) >> 16);
		addByte((data & 0xFF000) >> 8);
		addByte((data & 0xFF));
	}

	/**
	 *  Get all bytes from binary data
	 */
	public function toBytes():Bytes {
		return buffer.sub(0, length);
	}
}
