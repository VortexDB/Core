package core.time;

import haxe.Int64;

/**
 *  Represents a time interval.
 *  Initializes with the specified period.
 *
 *  Create TimeSpan
 *  ```
 *  var timestamp = new TimeStamp({
 *      days: 1
 *  });
 *  trace(timestamp.totalSeconds);  => 86400
 *  ```
 *
 *  Add one TimeSpan to another
 *  ```
 *  var timestamp1 = new TimeStamp({
 *      days: 3,
 *      hours: 1
 *  });
 *  var timestamp2 = new TimeStamp({
 *      hours: 4
 *  });
 *  var total = timestamp1 + timestamp2; => days: 3, hours: 5
 *  ```
 */
@:forward
abstract TimeSpan(__TimeSpan) {
	/**
	 * Constructor
	 * @param value
	 */
	public function new(value:TimeSpanParameters) {
		this = new __TimeSpan(value);
	}

	/**
	 * Compare type with __TimeSpan
	 * @param v - some type
	 * @return Bool
	 */
	public static inline function is(v:Dynamic):Bool {
		return Std.is(v, __TimeSpan);
	}

	/**
	 * Add one TimeSpan to another TimeSpan
	 * @param a
	 * @param b
	 * @return Int64
	 */
	@:op(A + B) public static inline function add(a:TimeSpan, b:TimeSpan):TimeSpan {
		return new TimeSpan({
			seconds: Int64.toInt(a.seconds) + Int64.toInt(b.seconds),
			nanoseconds: a.nanoseconds + b.nanoseconds
		});
	}
}

/**
 *  Parameters for constructor in TimeSpan
 */
typedef TimeSpanParameters = {
	@:optional var days:Int;
	@:optional var hours:Int;
	@:optional var minutes:Int;
	@:optional var seconds:Int;
	@:optional var nanoseconds:Int;
}

/**
 *  Internal realization
 */
@:keep
class __TimeSpan {
	/**
	 *  For calculating Float from Int64
	 */
	private inline static var MAX_32_PRECISION = 4294967296;

	/**
	 *  Seconds per minute
	 */
	private inline static var SECONDS_PER_MINUTE = 60;

	/**
	 *  Seconds per hour
	 */
	private inline static var SECONDS_PER_HOUR = 60 * SECONDS_PER_MINUTE;

	/**
	 *  Seconds per day
	 */
	private inline static var SECONDS_PER_DAY = 24 * SECONDS_PER_HOUR;

	/**
	 *  Nanoseconds count in one second
	 */
	public static inline var NANOSECONDS_PER_SECOND = 1000000000;

	/**
	 *  Total seconds of interval. Integer part
	 *  In range of 0...MAX_INT64
	 */
	public final seconds:Int64;

	/**
	 *  Fractional part in nanoseconds
	 *  in the range (0..999_999_999), less than one second
	 */
	public final nanoseconds:Int;

	/**
	 * Gets the value of the current TimeSpan structure expressed in whole and fractional days.
	 */
	public var totalDays(get, never):Float;

	private function get_totalDays():Float {
		return totalSeconds / SECONDS_PER_DAY;
	}

	/**
	 * Gets the value of the current TimeSpan structure expressed in whole and fractional hours.
	 */
	public var totalHours(get, never):Float;

	private function get_totalHours():Float {
		return totalSeconds / SECONDS_PER_HOUR;
	}

	/**
	 * Gets the value of the current TimeSpan structure expressed in whole and fractional seconds.
	 */
	public var totalSeconds(get, never):Float;

	private function get_totalSeconds():Float {
		return toFloat(seconds) + nanoseconds / NANOSECONDS_PER_SECOND;
	}

	/**
	 * Calc float from Int64
	 * @param i
	 * @return Float
	 */
	public static function toFloat(i:Int64):Float {
		return (Int64.getHigh(i) * MAX_32_PRECISION + Int64.getLow(i));
	}

	/**
	 * Compute seconds from day, hour, minute, seconds
	 * @param days
	 * @param hours
	 * @param minutes
	 * @param seconds
	 * @return Int64
	 */
	private static function computeSeconds(days:Int, hours:Int, minutes:Int, seconds:Int):Int64 {
		var hrssec = hours * SECONDS_PER_HOUR;
		var minsec = minutes * SECONDS_PER_MINUTE;
		var secs:Int64 = hrssec + minsec + seconds;
		var overflow = false;

		if (days > 0) {
			var sd:Int64 = SECONDS_PER_DAY * days;
			if (sd < days) {
				overflow = true;
			} else if (secs < 0) {
				var temp = secs;
				secs += sd;
				overflow = temp > secs;
			} else {
				secs += sd;
				overflow = secs < 0;
			}
		} else if (days < 0) {
			var sd:Int64 = SECONDS_PER_DAY * days;
			if (sd > days) {
				overflow = true;
			} else if (secs <= 0) {
				secs += sd;
				overflow = secs > 0;
			} else {
				var nanos = secs;
				secs += sd;
				overflow = secs > nanos;
			}
		}

		if (overflow) {
			throw "Time::Span too big or too small";
		}

		return secs;
	}

	/**
	 * Constructor
	 * @param interval
	 */
	public function new(interval:TimeSpanParameters) {
		nanoseconds = interval.nanoseconds;
		seconds = computeSeconds(interval.days, interval.hours, interval.minutes, interval.seconds);
	}

	/**
	 *  Convert to readable string
	 */
	public function toString():String {
		return 'Seconds: ${seconds} Nanoseconds: ${nanoseconds}';
	}
}
