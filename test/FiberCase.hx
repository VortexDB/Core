package test;

import utest.Assert;
import core.async.fiber.Fiber;
import core.async.fiber.Channel;

/**
 * For testing fiber
 */
class FiberCase {
	/**
	 * Constructor
	 */
	public function new() {};

    /**
	 * Test nested fibers with channels
	 */
	public function testNestedWithChannels() {
        var channel = new Channel<String>();
		var channel2 = new Channel<String>();
		var channel3 = new Channel<String>();

		Fiber.spawn(() -> {
			Fiber.spawn(() -> {				
				Fiber.spawn(() -> {
					channel.send("GOOD");
				});
                var r = channel.read();
                channel2.send(r + " BATMAN");
			});
			var res = channel2.read();
			channel3.send(res);
		});

		Assert.equals(channel3.read(), "GOOD BATMAN");
    }
}
