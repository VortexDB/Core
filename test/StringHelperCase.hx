package test;

import utest.Assert;
using core.utils.StringHelper;

/**
 *  For testing StringHelper
 */
class StringHelperCase {
	/**
	 * Constructor
	 */
	public function new() {};

	/**
	 * Test add to HashSet
	 */
	public function testHashCode() {
        var str = "Batman";
        var hash = str.hashCode();
        Assert.equals(hash, 129892948);
    }
}