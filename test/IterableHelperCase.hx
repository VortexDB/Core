package test;

import utest.Assert;
using core.utils.IterableHelper;

class OneClass {
	public function new() {}
}
class TwoClass extends OneClass {
	public function new() {
		super();
	}
}

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

	/**
	 * Test ofType
	 */
	public function testOfType() {
        var arr = [new OneClass(), new OneClass(), new TwoClass()];
		var res = arr.ofType(TwoClass);
        Assert.equals(res.length, 1);
    }
}