package core.io.port;

import java.NativeArray;
import haxe.io.Bytes;
import core.async.stream.Stream;
import core.async.stream.StreamController;


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
        owner.dataController.add(res);
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
@:allow(core.io.port.InternalSerialPortDataListener)
class SerialPort {
	/**
	 * Default port speed
	 */
	public static inline var DEFAULT_SPEED = 9600;

	/**
	 * Default byte type
	 */
	public static final DEFAULT_BYTETYPE:ByteTypeSettings = {
		dataBits: 8,
		parity: Parity.None,
		stopBits: 1
	};

    /**
     * Timeout on read bytes in milliseconds
     */
    public static inline var READ_TIMEOUT = 1000;

    /**
     * Timeout on read bytes in milliseconds
     */
    public static inline var WRITE_TIMEOUT = 300;

	/**
	 * Native serial port
	 */    
	private final port:NativePort;

	/**
	 * Controller for data stream
	 */
	private final dataController:StreamController<Bytes>;

	/**
	 * Name of serial port
	 * COM2, COM10, /dev/tty0
	 */
	public final name:String;

	/**
	 * Speed on port
	 * 9600, 115200, etc
	 */
	public final speed:Int;

	/**
	 * Byte type
	 * 8N1, 8O1, 8E2
	 */
	public final byteType:ByteTypeSettings;	

	/**
	 * Stream for data
	 */
	public final onData:Stream<Bytes>;

	/**
	 * Return serial port list names
	 * @return Array<String>
	 */
	public static function getPorts():Array<String> {
        // TODO: make better convert native array to array
		var res = new Array<String>();
		for (item in NativePort.getCommPorts())
			res.push(item.getSystemPortName());
		return res;
	}

	/**
	 * Constructor
	 * @param name
	 */
	public function new(name:String, ?speed:Int, ?byteType:ByteTypeSettings) {
		this.name = name;
		this.speed = speed != null ? speed : DEFAULT_SPEED;
		this.byteType = byteType != null ? byteType : DEFAULT_BYTETYPE;
		this.dataController = new StreamController<Bytes>();
		this.onData = this.dataController.stream;

		port = NativePort.getCommPort(name);
	}

    /**
     * Write data to port
     * @param data 
     */
    public function write(data:Bytes) {
        var bytes = data.getData();
        var stream = port.getOutputStream();
        stream.write(bytes);
        stream.flush();
    }

	/**
	 * Open serial port
	 */
	public function open() {
		if (port.isOpen())
			return;

		port.setBaudRate(speed);
        port.addDataListener(new InternalSerialPortDataListener(this));
		port.openPort(0);
	}

    /**
     * Close port
     */
    public function close() {
        port.removeDataListener();
        port.closePort();
		dataController.close();
    }
}
