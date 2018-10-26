package test;

import utest.Assert;
import core.async.future.Future;

class UserFut {
    public final name:String;
    public function new(name:String) {
        this.name = name;
    }
}

/**
 * For testing Future
 */
class FutureCase {
	/**
	 * Constructor
	 */
	public function new() {};

    /**
     * Test future on success
     */
    public function testFuture() {
        Future.sync(() -> {
			return 99;
		}).onSuccess((e) -> {
			Assert.equals(e, 99);
		}).onComplete((s) -> {
            Assert.equals(s.result, 99);
        });
    }

    /**
     * Test future on success
     */
    public function testOnErrorComplete() {
        Future.sync(() -> {
			throw "Error";
		}).onError((e) -> {
			Assert.equals(e, "Error");
		}).onComplete((s) -> {
            Assert.equals(s.error, "Error");
        });
    }
}
