package core.time;

/**
 * Datetime based on Float
 */
abstract DateTime(Float) {
	/**
	 * Get now local time
	 * @return DateTime
	 */
	static public inline function now():DateTime {
		return new DateTime(0);
	}

	/**
	 * Return unix stamp representation of DateTime
	 */
	public var unixStamp(get, never):Float;

	public function get_unixStamp():Float {
		return 0;
	}

	/**
	 * Constructor
	 * @param value
	 */
	public function new(value:Float) {
		this = value;
	}
}
