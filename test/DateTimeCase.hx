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
		// TODO: write test
        var datetime = DateTime.now();
		trace(datetime.unixStamp);
        trace(datetime);        
                    
        Assert.equals(datetime, datetime);
    }
}