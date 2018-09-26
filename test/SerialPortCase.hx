package test;

import utest.Assert;
import core.io.port.SerialPort;

/**
 * For testing SerialPort
 * TODO: tests for read/write
 */
class SerialPortCase {
    /**
	 * Constructor
	 */
	public function new() {};

	/**
	 * Test add to HashSet
	 */
	public function testListPorts() {
        try {
            SerialPort.getPorts();
            Assert.pass("Success get ports");
        } catch (e:Dynamic) {
            Assert.fail("Fail on iterate ports");
        }
    }
}