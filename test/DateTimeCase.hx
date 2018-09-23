package test;

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
}