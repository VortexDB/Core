package core.time;

import haxe.Int64;
import java.time.LocalDateTime;
import java.time.ZoneId;

/**
 * DateTime
 * TODO: cross-platform, works now only on java
 */
abstract DateTime(LocalDateTime) from LocalDateTime to LocalDateTime {
	/**
	 * Seconds per week
	 */
	public static inline var SECONDS_PER_WEEK = 604800;

	/**
	 * Seconds per year
	 */
	public static inline var SECONDS_PER_YEAR = 31536000;

	/**
	 * Seconds per leap year
	 */
	public static inline var SECONDS_PER_LEAP_YEAR = 31622400;

	/**
	 * Seconds per minute
	 */
	public static inline var SECONDS_PER_MINUTE = 60;

	/**
	 * Seconds per hour
	 */
	public static inline var SECONDS_PER_HOUR = 60 * SECONDS_PER_MINUTE;

	/**
	 * Nanoseconds count in one second
	 */
	public static inline var NANOSECONDS_PER_SECOND = 1000000000;

	/**
	 * Milliseconds count in one second
	 */
	public static inline var MILLISECONDS_PER_SECOND = 1000;

	/**
	 * Seconds per day
	 */
	public static inline var SECONDS_PER_DAY = 24 * SECONDS_PER_HOUR;

	/**
	 * Return time as unix stamp in seconds
	 */
	public var unixStamp(get, never):Int64;

	private function get_unixStamp():Int64 {
		var zoneId = ZoneId.systemDefault();
		return this.atZone(zoneId).toEpochSecond();
	}

	/**
	 * Return year
	 */
	public var year(get, never):Int;

	private function get_year():Int {
		return this.getYear();
	}

	/**
	 * Return month
	 */
	public var month(get, never):Int;

	private function get_month():Int {
		return this.getMonthValue();
	}

	/**
	 * Return day of the month
	 */
	public var day(get, never):Int;

	private function get_day():Int {
		return this.getDayOfMonth();
	}

	/**
	 * Checks type equality
	 * @param v
	 */
	public static function is(v:Dynamic) {
		return Std.is(v, LocalDateTime);
	}

	/**
	 * Return now date time
	 * @return DateTime
	 */
	public static function now():DateTime {
		return cast LocalDateTime.now();
	}

	/**
	 * Add one TimeSpan to another TimeSpan
	 * @param a
	 * @param b
	 * @return Int64
	 */
	@:op(A + B) public static inline function add(a:DateTime, b:TimeSpan):DateTime {
		var local:LocalDateTime = cast a;
		var nlocal = local.plusSeconds(b.totalSeconds);
		nlocal = nlocal.plusNanos(b.nanoseconds);
		return nlocal;
	}
}
