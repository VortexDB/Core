package core.io.port;

/**
 * Settings for byte type of serial port
 */
abstract ByteTypeSettings(ByteTypeSettingsImpl) from ByteTypeSettingsImpl to ByteTypeSettingsImpl {
	/**
	 * Constructor
	 * @param dataBits
	 * @param parity
	 * @param stopBits
	 */
	public function new(dataBits:Int, parity:Parity, stopBits:Int) {
		this = {
			dataBits: dataBits,
			parity: parity,
			stopBits: stopBits
		};
	}

	/**
	 * Convert string to ByteTypeSettings
	 * @param value
	 * @return ByteTypeSettings
	 */
	@:from public static inline function fromString(value:String):ByteTypeSettings {
		// TODO parse string
		return new ByteTypeSettings(9600, Parity.None, 1);
	}
}

/**
 * Settings for byte type of serial port data
 */
typedef ByteTypeSettingsImpl = {
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
