package core.collections;

/**
 * Interface for hash object
 */
typedef HashKey = {
    /**
     * Calc hash
     * @return Int
     */
    function hashCode(): Int;

    /**
     * Equals two objects
     * @param other 
     * @return Bool
     */
    function equals(other:Dynamic):Bool;
}

/**
 * Array of hashable objects
 * TODO: cross platform. Works for java right now
 * It's not optimized now, just working
 */
@:generic
class HashSet<T:HashKey> {
    /**
     * Java hashset for storing hashes
     */
    private final internalHashSet : java.util.HashSet<Int>;

    /**
     * Items
     */
    private final items : Array<T>;

    /**
     * Return item count of set
     */
    public var length(get, never) : Int;
    private function get_length() : Int {
        return items.length;
    }

    /**
     * Constructor
     */
    public function new() { 
        internalHashSet = new java.util.HashSet<Int>();
        items = new Array<T>();
    }

    /**
     * Add value to hash set
     * @param value
     */
    public function add(value : T):Bool {
        if (internalHashSet.add(value.hashCode())) {
            items.push(value);
            return true;
        }

        return false;
    }

    /**
     * Check if set contains item
     * @param value
     */
    public function contains(value : T):Bool {
        return internalHashSet.contains(value.hashCode());
    }

    /**
     * Clear all items
     */
    public function clear() {
        internalHashSet.clear();
        items.resize(0);
    }
}