package core.io;

import java.NativeArray;
import haxe.io.Bytes;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SocketChannel;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.Selector;
import java.nio.channels.SelectionKey;

/**
 * Referrence https://gist.github.com/Botffy/3860641
 */

/**
 * On client accept callback
 */
typedef OnAcceptCall = () -> Void;

/**
 * On client data callback
 */
typedef OnDataCall = (Bytes) -> Void;

/**
 * Listens for connections from TCP network clients.
 */
class TcpListener {
	/**
	 * Read buffer size
	 */
	public static inline var READ_BUFFER_SIZE = 1024;

	/**
	 * Server socket
	 */
	private final serverSocket:ServerSocketChannel;

	/**
	 * Selector for sockets
	 */
	private final selector:Selector;

	/**
	 * Data buffer for read data from client
	 */
	private final readBuffer:ByteBuffer;

	/**
	 * Host to listen
	 */
	public final host:String;

	/**
	 * Port to listen
	 */
	public final port:Int;

	/**
	 * On client accept callback
	 */
	public var onAccept:OnAcceptCall;

	/**
	 * On client data callback
	 */
	public var onData:OnDataCall;

	/**
	 * Handle accept from server socket
	 * @param key
	 */
	private function handleAccept(key:SelectionKey) {
		var server = cast(key.channel(), ServerSocketChannel);
		var clientChannel = server.accept();
		clientChannel.configureBlocking(false);
		clientChannel.register(selector, SelectionKey.OP_READ, null);
		if (onAccept != null)
			onAccept();
	}

	/**
	 * Handle read from client socket
	 * @param key
	 */
	private function handleRead(key:SelectionKey) {
		var clientChannel = cast(key.channel(), SocketChannel);
		readBuffer.clear();
		var read = 0;
		while ((read = clientChannel.read(readBuffer)) > 0) {			
			// TODO: Later rework
			// Copy data to bytes. Slow
			var byteArr = new NativeArray(read);
			readBuffer.get(byteArr, 0, read);
			var resp = Bytes.ofData(byteArr);
			if (onData != null)
				onData(resp);
		}
	}
}

/**
 * Constructor
 */
public function new(host:String, port:Int) {
	this.host = host;
	this.port = port;

	this.readBuffer = ByteBuffer.allocate(READ_BUFFER_SIZE);
	this.serverSocket = ServerSocketChannel.open();
	this.serverSocket.socket().bind(new InetSocketAddress(port));
	this.serverSocket.configureBlocking(false);
	this.selector = Selector.open();
	this.serverSocket.register(selector, SelectionKey.OP_ACCEPT);
}

/**
 * Open port on host and starts listen
 */
public function open():Void {
	while (this.serverSocket.isOpen()) {
		selector.select();
		var iter = this.selector.selectedKeys().iterator();
		while (iter.hasNext()) {
			var key = iter.next();
			iter.remove();

			if (key.isAcceptable())
				this.handleAccept(key);
			if (key.isReadable())
				this.handleRead(key);
		}
	}
}
}
