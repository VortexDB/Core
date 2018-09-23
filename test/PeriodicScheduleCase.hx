package test;

import utest.Assert;
import core.time.TimeSpan;
import core.time.schedule.PeriodicSchedule;

/**
 *  For testing PeriodicSchedule
 */
class PeriodicScheduleCase {
	/**
	 * Constructor
	 */
	public function new() {};

	/**
	 * Test next start
	 */
	public function testNextStart() {
        var schedule = new PeriodicSchedule(
            new TimeSpan({
                minutes: 10
            })
        );

        var nextStart = schedule.nextStart();
        var seconds = nextStart.totalSeconds;
        // DONT know how to do right
        var res = seconds > 0 && seconds < 600;
        Assert.equals(res, true);
    }
}