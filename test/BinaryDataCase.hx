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
        var binary = new BinaryData();
        binary.addByte(67);
        Assert.equals(binary.getByte(0), 67);
    }

    /**
     * Test add Int16
     */
    public function testAddInt16() {
        var binary = new BinaryData();
        binary.addInt16(0xFF11);
        Assert.equals(binary.getByte(0), 0xFF);
        Assert.equals(binary.getByte(1), 0x11);
    }

    /**
     * Test add Int16
     */
    public function testGetInt16() {
        var binary = new BinaryData();
        binary.addInt16(0xFF11);
        var res = binary.getInt16(0);
        Assert.equals(res, 0xFF11);
    }

    /**
     * Test add Int32
     */
    public function testAddInt32() {
        var binary = new BinaryData();
        binary.addInt32(0xFF112233);
        Assert.equals(binary.getByte(0), 0xFF);
        Assert.equals(binary.getByte(1), 0x11);
        Assert.equals(binary.getByte(2), 0x22);
        Assert.equals(binary.getByte(3), 0x33);
    }

    /**
	 * Test add bytes
	 */
	public function testAddBytes() {
        var binary = new BinaryData();
        binary.addByte(67);
        var bytes = Bytes.alloc(2);
        bytes.set(0, 33);
        bytes.set(1, 44);
        binary.addBytes(bytes);
        Assert.equals(binary.getByte(0), 67);
        Assert.equals(binary.getByte(1), 33);
        Assert.equals(binary.getByte(2), 44);
    }

    /**
	 * Test ofBytes
	 */
	public function testOfBytes() {
        var bytes = Bytes.alloc(2);
        bytes.set(0, 33);
        bytes.set(1, 44);
        var binary = BinaryData.ofBytes(bytes);
        Assert.equals(binary.getByte(0), 33);
        Assert.equals(binary.getByte(1), 44);
        Assert.equals(binary.length, 2);
    }

    /**
	 * Test slice
	 */
	public function testSlice() {
        var binary = new BinaryData();
        binary.addByte(33);
        binary.addByte(44);
        binary.addByte(55);
        binary.addByte(66);
        binary.addByte(77);
        binary.addByte(88);

        var sliced1 = BinaryData.ofBytes(binary.slice(2, 2));
        Assert.equals(sliced1.getByte(0), 55);
        Assert.equals(sliced1.getByte(1), 66);
        Assert.equals(sliced1.length, 2);

        var sliced2 = BinaryData.ofBytes(binary.slice(3, 20));
        Assert.equals(sliced2.getByte(0), 66);
        Assert.equals(sliced2.getByte(1), 77);
        Assert.equals(sliced2.getByte(2), 88);
        Assert.equals(sliced2.length, 3);

        // On the edge
        var sliced3 = BinaryData.ofBytes(binary.slice(3, 3));
        Assert.equals(sliced3.getByte(0), 66);
        Assert.equals(sliced3.getByte(1), 77);
        Assert.equals(sliced3.getByte(2), 88);
        Assert.equals(sliced3.length, 3);
    }
}