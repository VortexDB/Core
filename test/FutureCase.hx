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
    public function testOnSuccess() {
        Future.now(() -> {
			return 99;
		}).onSuccess((e) -> {
			Assert.equals(e, 99);
		});
    }
}
