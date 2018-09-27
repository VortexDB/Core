package test;

import utest.Assert;
import core.async.Future;

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
        var future1 = new Future(() -> {
			return 99;
		});

        var d = 0;    

        future1.onSuccess((e:Int) -> {
            d = e;
        });

        var future2 = new Future(() -> {
			return 1;
		});

        future1.wait(); // TEST HANG

        future2.wait();
        Assert.equals(d, 99);
    }

	/**
	 * Test future await
	 */
	public function testWait() {
		var future1 = new Future(() -> {
			return 33;
		});

		var future2 = new Future(() -> {
			return "GOOD";
		});

		var future3 = new Future(() -> {
			return new UserFut("Batman");
		});

		var res1 = future1.wait();
		var res2 = future2.wait();
        var res3 = future3.wait();
		
		Assert.equals(res1, 33);
		Assert.equals(res2, "GOOD");
        Assert.equals(res3.name, "Batman");
	}

    /**
     * Test wait all futures
     */
    public function testWaitAll() {
        var future1 = new Future(() -> {
			return 33;
		});

		var future2 = new Future(() -> {
			return 44;
		});

		var future3 = new Future(() -> {
			return 55;
		});

        var res = Future.waitAll([future1, future2, future3]);
        Assert.equals(res.length, 3);
    }
}
