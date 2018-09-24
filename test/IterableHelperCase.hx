package test;

import utest.Assert;
using core.utils.IterableHelper;

/**
 * For testing iterable helper
 */
class IterableHelperCase {
	/**
	 * Constructor
	 */
	public function new() {};

	/**
	 * Test groupby
	 */
	public function testGroupBy() {
        var a = ["Haxe", "Java", "PHP"];
        var group = a.groupdBy((e) -> {
            return e.length;
        });
        Assert.equals(group[4].toString(), "[Haxe,Java]");
    }
}