package core.io;

import java.NativeArray;
import haxe.io.Bytes;

/**
 * Alias to native port
 */
typedef NativePort = com.fazecast.jSerialComm.SerialPort;

/**
 * On data callback
 */
typedef OnSerialPortDataCall = (SerialPort, Bytes) -> Void;

/**
 * Data listener
 */
class InternalSerialPortDataListener implements com.fazecast.jSerialComm.SerialPortDataListener {
    /**
     * Referrence to serial port
     */
    private final owner:SerialPort;

	/**
	 * Constructor
	 */
	public function new(owner:SerialPort) {
        this.owner = owner;
    }

	/**
	 * Listen for data available
	 * @return Int
	 */
	public function getListeningEvents():Int {
		return NativePort.LISTENING_EVENT_DATA_AVAILABLE;
	}

	/**
	 * Process event
	 * @param event 
	 */
	public function serialEvent(event:com.fazecast.jSerialComm.SerialPortEvent):Void {
        // Ignore everything except Data available
        if (event.getEventType() != NativePort.LISTENING_EVENT_DATA_AVAILABLE)
            return;

        var bytesAvail = owner.port.bytesAvailable();
        var array = new NativeArray<java.types.Int8>(bytesAvail);
        owner.port.readBytes(array, array.length);
        var res = Bytes.ofData(array);
        if (owner.onData != null)
            owner.onData(owner, res);
    }
}

/**
 * For communication by serial port
 *
 * ```
 * var port = new SerialPort("COM3");
 * port.onData = (e:Bytes) -> {
 *      processData(e);
 * };
 * port.open();
 * ```
 */
@:allow(core.io.InternalSerialPortDataListener)
class SerialPort {
	/**
	 * Native serial port
	 */    
	private final port:NativePort;

	/**
	 * Name of serial port
	 * COM2, COM10, /dev/tty0
	 */
	public final name:String;

	/**
	 * On data callback
	 */
	public var onData:OnSerialPortDataCall;

	/**
	 * Return serial port list names
	 * @return Array<String>
	 */
	public static function getPorts():Array<String> {
		var res = new Array<String>();
		for (item in NativePort.getCommPorts())
			res.push(item.getSystemPortName());
		return res;
	}

	/**
	 * Constructor
	 * @param name
	 */
	public function new(name:String) {
		this.name = name;
		port = NativePort.getCommPort(name);
	}

    /**
     * Write data to port
     * @param data 
     */
    public function write(data:Bytes) {
        var bytes = data.getData();
        port.writeBytes(bytes, 0, bytes.length);
    }

	/**
	 * Open serial port
	 */
	public function open() {
		if (port.isOpen())
			return;

		port.openPort();
		port.addDataListener(new InternalSerialPortDataListener(this));
	}

    /**
     * Close port
     */
    public function close() {
        port.closePort();
    }
}
