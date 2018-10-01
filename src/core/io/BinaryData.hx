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
	 *  Create new Binary Data with prealloced length
	 */
	public function new(?length:Int) {
		size = 0;
		this.length = length == null ? 0 : length;
		var incSize = length > INCREMENT_SIZE ? length : INCREMENT_SIZE;		
		resize(incSize);
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
	 *  Add UInt16 to the end of buffer
	 *  @param data - UInt16 data
	 */
	public function addUInt16(data:Int) {
		prepareSize(2);
		addByte((data & 0xFF000) >> 8);
		addByte((data & 0xFF));
	}

	/**
	 *  Add UInt32 to the end of buffer
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
	 *  Get all bytes from binary data
	 */
	public function toBytes():Bytes {
		return buffer.sub(0, length);
	}
}
