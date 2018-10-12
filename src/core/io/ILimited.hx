package core.io;

/**
 *  Stream limited and has current position
 */
interface ILimited {
	/**
	 *  Size
	 */
	public var length(default, null):Int;

	/**
	 *  Current pos
	 */
	public var position(default, null):Int;
}
