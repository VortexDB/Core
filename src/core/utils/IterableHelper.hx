package core.utils;

/**
 * Utility class for Iterable<T>
 */
class IterableHelper {
	/**
	 * Returns a Hash whose keys are each different value that the passed block
     * returned when run for each element in the collection, and which values are
     * an Array of the elements for which the block returned that value.
     * ```
     * ["Python", "Ruby", "PHP", "Java", "Haxe"].groupdBy((e) => {
     *      return e.length;
     * });
     *  Result: {4 => ["Ruby","Java","Haxe"], 6 => ["Python"], 3 => ["PHP"]}
     * ```
	 */
	@:generic
	public static function groupdBy<T, U>(a:Iterable<T>, b:T->U):Map<U, Array<T>> {
		var map = new Map<U, Array<T>>();
		for (e in a) {
			var v = b(e);
			if (map.exists(v)) {
				map[v].push(e);
			} else {
				map[v] = [e];
			}
		}
		return map;
	}

	/**
	 * Check iterable items type and filter them to stay only items of type T
	 * @param a 
	 * @return Array<T>
	 */
	public static function ofType<T, U>(a:Iterable<U>, c:Class<T>):Array<T> {
		var res = new Array<T>(); 
        for (item in a) {             
             if (Std.is(item, c)) {
                 res.push(cast item);
             }
        }
        return res;
	}
}
