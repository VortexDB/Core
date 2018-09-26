package core.io.port;

/**
 * Settings for byte type of serial port
 */
typedef ByteTypeSettings = {
    /**
     * Data bits: 6,7,8
     */
    var dataBits:Int;

    /**
     * Parity: None, Even, Odd
     */
    var parity:Parity;

    /**
     * Stop bits: 2, 1.5, 1
     */
    var stopBits:Int;
}