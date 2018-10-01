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

    public function testAddInt16() {
        var binaryData = new BinaryData();
        binaryData.addInt16(0xFF11);
        Assert.equals(binaryData.getByte(0), 0xFF);
        Assert.equals(binaryData.getByte(1), 0x11);
    }

    public function testAddInt32() {
        var binaryData = new BinaryData();
        binaryData.addInt32(0xFF112233);
        Assert.equals(binaryData.getByte(0), 0xFF);
        Assert.equals(binaryData.getByte(1), 0x11);
        Assert.equals(binaryData.getByte(2), 0x22);
        Assert.equals(binaryData.getByte(3), 0x33);
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