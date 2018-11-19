package core.io.websocket;

import core.io.output.ISocketOutput;
import core.io.socket.Peer;
import core.async.stream.StreamController;
import core.async.stream.Stream;
import core.io.socket.TcpChannel;
import haxe.io.Bytes;
import haxe.crypto.BaseCode;
import haxe.crypto.Base64;
import haxe.crypto.Sha1;
import core.io.websocket.FrameType;

/**
 *  State of work
**/
enum WorkState {
	/**
	 *  Handshake with client
	**/
	Handshake;

	/**
	 *  Get frame type
	**/
	TypeFrame;

	/**
	 *  Get length
	**/
	Length;

	/**
	 *  Get data
	**/
	Data;

	/**
	 *  Connection closed
	 */
	Close;
}

/**
 * Abstract event of websocket channel
 */
class WSChannelEvent {
	/**
	 * Client peer
	 */
	public final peer:Peer;

	/**
	 * Constructor
	 */
	public function new(peer:Peer) {
		this.peer = peer;
	}
}

/**
 * Websocket error event
 */
class WSErrorEvent extends WSChannelEvent {
	/**
	 * Error
	 */
	public final error:Dynamic;

	/**
	 * Constructor
	 */
	public function new(peer:Peer, error:Dynamic) {
		super(peer);
		this.error = error;
	}
}

/**
 * On connect event
 */
class WSConnectEvent extends WSChannelEvent {
	/**
	 * Socket output
	 */
	public final output:ISocketOutput;

	/**
	 * Constructor
	 */
	public function new(peer:Peer, output:ISocketOutput) {
		super(peer);
		this.output = output;
	}
}

/**
 * On close vent
 */
class WSCloseEvent extends WSChannelEvent {
}

/**
 * Websocket processor over TcpChannel for using in HttpServer or TcpServer
**/
class WebsocketProcessor {
	/**
	 *  Message mask size
	**/
	static inline var MASK_SIZE = 4;

	/**
	 *  One byte max body size
	**/
	static inline var ONE_BYTE_MAX_BODY_SIZE = 125;

	/**
	 *  Two byte body size
	**/
	static inline var TWO_BYTE_BODY_SIZE = 126;

	/**
	 *  Eight byte body size
	**/
	static inline var EIGHT_BYTE_BODY_SIZE = 127;

	/**
	 *  Sec-WebSocket-Key header name
	**/
	static inline var SecWebSocketKey = "Sec-WebSocket-Key";

	/**
	 *  Web socket GUID
	**/
	static inline var WS_GUID = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";

	/**
	 *  Channel for data IO
	**/
	var channel:TcpChannel;

	/**
	 *  State of handler
	**/
	var state:WorkState;

	/**
	 *  Handshake headers
	**/
	var headers:Map<String, String>;

	/**
	 *  Frame type
	**/
	var frameType:Int;

	/**
	 *  Packet length
	**/
	var packLen:Int;

	/**
	 * Controller for event
	 */
	private final onEventController:StreamController<WSChannelEvent>;

	/**
	 * Events stream
	 */
	public final onEvent:Stream<WSChannelEvent>;

	/**
	 *  Decode hex string to Bytes
	**/
	private function decode(str:String) {
		// TODO: remove Bytes
		var base = haxe.io.Bytes.ofString("0123456789abcdef");
		return new BaseCode(base).decodeBytes(haxe.io.Bytes.ofString(str.toLowerCase()));
	}

	/**
	 *  Send error through OnError
	**/
	private function pushError(error:Dynamic) {
		onEventController.add(new WSErrorEvent(channel.peer, error));
	}

	/**
	 *  Process handshake from client
	**/
	private function processHandshake():Void {
		var key = headers[SecWebSocketKey] + WS_GUID;
		var sha = Sha1.encode(key);
		var shaKey = Base64.encode(decode(sha));
		var stringBuffer = new StringBuf();
		stringBuffer.add("HTTP/1.1 101 Switching Protocols\r\n");
		stringBuffer.add("Upgrade: websocket\r\n");
		stringBuffer.add("Connection: Upgrade\r\n");
		stringBuffer.add('Sec-WebSocket-Accept: ${shaKey}\r\n');
		stringBuffer.add("\r\n");
		channel.output.writeString(stringBuffer.toString());
		state = WorkState.TypeFrame;
		onEventController.add(new WSConnectEvent(channel.peer, channel.output));
	}

	/**
	 *  Process frame type, opcode, mask, len part
	**/
	private function processFrame():Void {
		var binaryData = channel.input.readBytes(2);
		var frame = binaryData.get(0);

		frameType = frame & 0x0F;

		var len = binaryData.get(1);
		packLen = 0;
		if ((len & 0x80) < 1)
			// TODO: exception
			throw "Only masked message allowed";
		packLen += len ^ 0x80;

		if (packLen > ONE_BYTE_MAX_BODY_SIZE) {
			state = WorkState.Length;
		} else {
			state = WorkState.Data;
		}
	}

	/**
	 *  Process length
	**/
	private function processLength():Void {
		if (packLen == TWO_BYTE_BODY_SIZE) {
			var binaryData = channel.input.readBytes(2);
			packLen += binaryData.get(0);
		} else if (packLen == EIGHT_BYTE_BODY_SIZE) {
			// var binaryData = BinaryData.FromBytes (_socket.input.read (8));
		} else {
			// TODO: exception
			throw "Wrong length type";
		}

		state = WorkState.Data;
	}

	/**
	 *  Process data
	**/
	private function processData():Void {
		var binaryData = channel.input.readBytes(packLen + MASK_SIZE);

		switch (frameType) {
			case FrameType.Close:
				{
					onEventController.add(new WSCloseEvent(channel.peer));
					state = WorkState.Close;
					disconnect();
				}
			case FrameType.Text | FrameType.Binary:
				{
					var mask = binaryData.slice(0, MASK_SIZE);
					var data = binaryData.slice(MASK_SIZE, binaryData.length - MASK_SIZE);
					var res = BinaryData.alloc(data.length);

					for (i in 0...data.length) {
						var j = i % 4;
						var b = data.get(i);
						var d = b ^ mask.get(j);
						res.setByte(i, d);
					}

					// On data
					onData(channel.peer, res, this);
					state = WorkState.TypeFrame;
				}
			default:
				// TODO: exception
				throw "Unknown frame";
		}
	}

	/**
	 *  Disconnect connection
	**/
	private function disconnect() {
		try {
			channel.close();
		} catch (e:Dynamic) {
			trace(e);
		}
	}

	/**
	 * Process data from client channel
	 * @param data
	 */
	private function processChannelData(data:Bytes) {
		switch (state) {
			case WorkState.Handshake:
				processHandshake();
			case WorkState.TypeFrame:
				processFrame();
			case WorkState.Length:
				processLength();
			case WorkState.Data:
				processData();
			case WorkState.Close:
				// TODO: notify about close
				trace("Websocket closed");
		}
	}

	/**
	 *  Constructor
	 */
	public function new(channel:TcpChannel, headers:Map<String, String>) {
		this.channel = channel;
		this.headers = headers;
		state = WorkState.Handshake;

		onEventController = new StreamController<WSChannelEvent>();
		onEvent = onEventController.stream;
	}

	/**
	 *  Start to process data from client
	**/
	public function start():Void {
		channel.onData.listen(processChannelData);
	}

	/**
	 *  Write one byte
	 *  @param data - byte
	 */
	public function writeByte(data:Int):Void {
		return channel.output.writeByte(data);
	}

	/**
	 *  Write bytes to stream
	 *  @param data - byte array
	 *  @return Number of bytes written
	 */
	public function writeBytes(data:BinaryData):Int {
		var frame = BinaryData.alloc(2 + data.length);
		frame.setByte(0, 0x80 + FrameType.Binary); // FIN, BINARY
		frame.setByte(1, data.length);
		ByteArray.copy(frame, data, 2, 0, data.length);
		return channel.output.writeBytes(frame.toBytes());
	}

	/**
	 *  Write string
	**/
	public function writeString(data:String):Void {
		var dat = BinaryData.ofString(data);
		writeBytes(dat);
	}

	/**
	 *  Close socket
	**/
	public function close():Void {
		channel.close();
	}
}
