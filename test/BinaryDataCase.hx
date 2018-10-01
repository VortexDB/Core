package test;

import java.lang.Byte;
import haxe.io.Bytes;
import utest.Assert;
import core.io.BinaryData;

/**
 * For testing Binary data
 */
class BinaryDataCase {
	/**
	 * Constructor
	 */
	public function new() {};

    /**
	 * Test add byte
	 */
	public function testAddByte() {
        var binaryData = new BinaryData();
        binaryData.addByte(67);
        Assert.equals(binaryData.getByte(0), 67);
    }

    /**
	 * Test add bytes
	 */
	public function testAddBytes() {
        var binaryData = new BinaryData();
        binaryData.addByte(67);
        var bytes = Bytes.alloc(2);
        bytes.set(0, 33);
        bytes.set(1, 44);
        binaryData.addBytes(bytes);
        Assert.equals(binaryData.getByte(0), 67);
        Assert.equals(binaryData.getByte(1), 33);
        Assert.equals(binaryData.getByte(2), 44);
    }
}