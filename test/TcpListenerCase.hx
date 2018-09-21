package test;

import utest.Assert;
import core.io.TcpListener;

/**
 *  For testing TcpListener
 */
class TcpListenerCase {
    /**
	 * Constructor
	 */
	public function new() {};

    /**
	 *  Test total seconds
	 */
	public function testBindLocalhost() {
        var listener = new TcpListener({
            host: "localhost",
            port: 26301
        });
        Assert.equals(listener.host, "localhost");        
	}
}