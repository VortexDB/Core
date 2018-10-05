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
        var future1 = Future.now(() -> {
			return 99;
		});

        var d = 0;    

        future1.onSuccess((e:Int) -> {
            d = e;
        });

        var future2 = Future.now(() -> {
			return 1;
		});

        future1.await(); // TEST HANG

        future2.await();
        Assert.equals(d, 99);
    }

	/**
	 * Test future await
	 */
	public function testWait() {
		var future1 = Future.now(() -> {
			return 33;
		});

		var future2 = Future.now(() -> {
			return "GOOD";
		});

		var future3 = Future.now(() -> {
			return new UserFut("Batman");
		});

		var res1 = future1.await();
		var res2 = future2.await();
        var res3 = future3.await();
		
		Assert.equals(res1, 33);
		Assert.equals(res2, "GOOD");
        Assert.equals(res3.name, "Batman");
	}

    /**
     * Test wait all futures
     */
    public function testWaitAll() {
        var future1 = Future.now(() -> {
			return 33;
		});

		var future2 = Future.now(() -> {
			return 44;
		});

		var future3 = Future.now(() -> {
			return 55;
		});

        var res = Future.waitAll([future1, future2, future3]);
        Assert.equals(res.length, 3);
    }

	/**
     * Test nested wait
     */
    public function testNestedWait() {
		var future1 = Future.now(() -> {			
			var future2 = Future.now(() -> {				
				return 44;
			});			
			var v = future2.await();
			return v;
		});
		
		var res = future1.await();
		Assert.equals(res, 44);
	}
}
