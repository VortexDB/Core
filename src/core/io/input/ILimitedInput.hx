package core.io.input;

import haxe.io.Bytes;

/**
 *  Has size limit
 */
interface ILimitedInput extends IByteInput extends ILimited {
	/**
	 *  Read all data from current position to end
	 */
	public function readToEnd():Bytes;
}
