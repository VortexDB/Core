package test;

import utest.Assert;
using core.utils.StringHelper;
import core.collections.HashSet;

/**
 * Some user
 */
class User {
	/**
	 * User name
	 */
	public final name:String;

	/**
	 * Constructor
	 * @param name 
	 */
	public function new(name:String) {
		this.name = name;
	}

	/**
	 * Calc hash code
	 */
	public function hashCode() {
		return name.hashCode();
	}

	/**
	 * Compare users
	 * @param other 
	 */
	public function equals(other:Dynamic) {
        if (Std.is(other, User)) {
            return name == cast(other, User).name;
        }		
        return false;
	}
}

/**
 *  For testing HashSet
 */
class HashSetCase {
	/**
	 * Constructor
	 */
	public function new() {};

	/**
	 * Test add to HashSet
	 */
	public function testAdd() {
		var hashSet = new HashSet<User>();
        var user = new User("Batman");
        var add = hashSet.add(user);
        Assert.equals(add, true);
        add = hashSet.add(user);
        Assert.equals(add, false);
	}

    /**
	 * Test contains
	 */
	public function testContains() {
        var hashSet = new HashSet<User>();
        var user = new User("Batman");
        hashSet.add(user);
        var res = hashSet.contains(user);
        Assert.equals(res, true);
    }

    /**
	 * Test clear
	 */
	public function testClear() {
        var hashSet = new HashSet<User>();
        var user1 = new User("Batman");
        var user2 = new User("Superman");
        hashSet.add(user1);
        hashSet.add(user2);
        Assert.equals(hashSet.length, 2);
        hashSet.clear();
        Assert.equals(hashSet.length, 0);
    }

    /**
	 * Test iterator
	 */
	public function testIterator() {
        var hashSet = new HashSet<User>();
        var user1 = new User("Batman");
        var user2 = new User("Superman");
        hashSet.add(user1);
        hashSet.add(user2);
        var res = "";
        for (user in hashSet) {
            res += user.name;
        }

        Assert.equals(res, "Batman" + "Superman");
    }
}
