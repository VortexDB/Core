package core.time;

/**
 * Datetime based on Float
 */
abstract DateTime(Float) from Float to Float {
    /**
     * Constructor
     * @param value 
     */
    public function new(value : Float) {
        this = value;
    }
}