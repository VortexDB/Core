package test;

import utest.Assert;
import core.time.TimeSpan;

/**
 *  For testing TimeSpan
 */
class TimeSpanCase {
	/**
	 * Constructor
	 */
	public function new() {};

	/**
	 *  Test total milliseconds
	 */
	public function testTotalMilliSeconds() {
		var timespan = new TimeSpan({
			minutes: 33,
			seconds: 42
		});
		Assert.equals((33 * 60 + 42) * 1000, timespan.totalMilliseconds);
	}

	/**
	 *  Test total seconds
	 */
	public function testTotalSeconds() {
		var timespan = new TimeSpan({
			days: 1,
			hours: 3,
			minutes: 33,
			seconds: 42
		});
		Assert.equals(1 * 86400 + 3 * 3600 + 33 * 60 + 42, timespan.totalSeconds);
	}

	/**
	 *  Test total seconds
	 */
	public function testTotalHours() {
		var timespan = new TimeSpan({
			days: 1,
			hours: 3
		});
		Assert.equals(1 * 24 + 3, timespan.totalHours);
	}

	/**
	 *  Test total seconds
	 */
	public function testTotalDays() {
		var timespan = new TimeSpan({
			days: 4,
			hours: 48
		});
		Assert.equals(6, timespan.totalDays);
	}

	/**
	 *  Make empty
	 */
	public function testMakeEmpty() {
		var timespan = new TimeSpan({});
		Assert.equals(0, timespan.totalSeconds);
	}

	/**
	 *  Test TimeSpan + TimeSpan
	 */
	public function testAddSpan() {
		var timespan1 = new TimeSpan({
			days: 3
		});
		var timespan2 = new TimeSpan({
			hours: 5
		});
		var totalSpan = timespan1 + timespan2;
		var equalsSpan = new TimeSpan({
			days: 3,
			hours: 5
		});

		Assert.equals(totalSpan.totalSeconds, equalsSpan.totalSeconds);
	}

	/**
	 *  Test is TimeSpan function
	 */
	public function testIsTimeSpan() {
		var timespan1 = new TimeSpan({
			days: 3
		});
		Assert.equals(TimeSpan.is(timespan1), true);
	}
}
