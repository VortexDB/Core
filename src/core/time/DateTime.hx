package core.time;

import haxe.Int64;
import java.time.LocalDateTime;
import java.time.Duration;
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
	 * Nanoseconds count in one milisecond
	 */
	public static inline var NANOSECONDS_PER_MSECOND = 1000000;

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
	 * Return month (1-12)
	 */
	public var month(get, never):Int;

	private function get_month():Int {
		return this.getMonthValue();
	}

	/**
	 * Return hour (0-23)
	 */
	public var hour(get, never):Int;

	private function get_hour():Int {
		return this.getHour();
	}

	/**
	 * Return minute (0-59)
	 */
	public var minute(get, never):Int;

	private function get_minute():Int {
		return this.getMinute();
	}

	/**
	 * Return second (0-59)
	 */
	public var second(get, never):Int;

	private function get_second():Int {
		return this.getSecond();
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
	@:op(A + B) public static inline function addTimespan(a:DateTime, b:TimeSpan):DateTime {
		var local:LocalDateTime = cast a;
		var nlocal = local.plusSeconds(b.totalSeconds);
		nlocal = nlocal.plusNanos(b.nanoseconds);
		return nlocal;
	}

	/**
	 * DateTime - DateTime = TimeSpan
	 * TODO: remake. It's slow
	 * @param a
	 * @param b
	 * @return Int64
	 */
	@:op(A - B) public static inline function between(a:DateTime, b:DateTime):TimeSpan {
		var duration = Duration.between(b, a);
		// TODO: seconds Int64
		var timespan = new TimeSpan({
			seconds: Int64.toInt(duration.getSeconds()),
			nanoseconds: duration.getNano()
		});

		return timespan;
	}

	/**
	 * Constructor
	 */
	public function new(year:Int, month:Int, day:Int, hour:Int = 0, minute:Int = 0, second:Int = 0) {
		this = LocalDateTime.of(year, month, day, hour, minute, second);
	}
}
