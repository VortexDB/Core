package test;

import core.time.TimeSpan;
import utest.Assert;
import core.time.DateTime;

/**
 * For testing date time
 */
class DateTimeCase {
	/**
	 * Constructor
	 */
	public function new() {};

	/**
	 * Test add to HashSet
	 */
	public function testNow() {
		var datetime = DateTime.now();
		var haxeDate = Date.now();		
		var eq = datetime.year == haxeDate.getFullYear() && datetime.month == (haxeDate.getMonth() + 1) && datetime.day == haxeDate.getDate();

		Assert.equals(eq, true);
	}

	/**
	 * Test add timespan to datetime
	 */
	public function testAddTimeSpan() {
		var datetime = new DateTime(2018, 9, 23, 2, 10, 22);
		var timespan = new TimeSpan({
			days: 5,
			hours: 10,
			minutes: 11,
			seconds: 33
		});
		var res = datetime + timespan;
		Assert.equals(res.day, 28);
		Assert.equals(res.hour, 12);
		Assert.equals(res.minute, 21);
		Assert.equals(res.second, 55);
	}
}