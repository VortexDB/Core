package core.io.input;

import haxe.io.Bytes;

/**
 *  Reader with size limit
 */
class LimitedReader implements ILimitedInput {
	/**
	 *  Data input
	 */
	var input:IByteInput;

	/**
	 *  Size
	 */
	public var length(default, null):Int;

	/**
	 *  Current pos
	 */
	public var position(default, null):Int;

	/**
	 *  Constructor
	 *  @param input - data input
	 */
	public function new(input:IByteInput, length:Int) {
		this.input = input;
		this.length = length;
		position = 0;
	}

	/**
	 *  Read one byte
	 *  @return Int
	 */
	public function readByte():Int {
		if (position + 1 >= length)
			throw IoError.Eof;
		var data = input.readByte();
		position += 1;
		return data;
	}

	/**
	 *  Read bytes
	 *  @param count - byte count to read
	 *  @return ByteArray
	 */
	public function readBytes(count:Int):ByteArray {
		var cnt = position + count;
		if (cnt > length) {
			cnt = cnt - length;
		}

		if (cnt < 1)
			throw IoError.Eof;
		var data = input.readBytes(cnt);
		position += data.length;
		return data;
	}

	/**
	 *  Read all data from current position to end
	 */
	public function readToEnd():Bytes {
		var cnt = length - position;
		if (cnt < 1)
			throw IoError.Eof;
		// TODO: check all is read
		return readBytes(cnt);
	}
}
