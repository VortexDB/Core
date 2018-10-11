package core.io.socket;

import core.async.fiber.Fiber;
import java.NativeArray;
import haxe.io.Bytes;
import java.net.InetSocketAddress;
import java.net.InetAddress;
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
typedef OnAcceptCall = (TcpChannel) -> Void;

/**
 * Parameters for TcpListener constructor
 */
typedef TcpListenerParameters = {
	/**
	 * Host to listen
	 */
	@:optional var host:String;

	/**
	 * Port to listen
	 */
	var port:Int;
};

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
	 * Handle accept from server socket
	 * Can return null if not accepted
	 * @param key
	 */
	private function handleAccept(key:SelectionKey) {
		if (onAccept == null)
			return;

		var server = cast(key.channel(), ServerSocketChannel);
		var clientChannel = server.accept();
		clientChannel.configureBlocking(false);
		var channel = new TcpChannel(clientChannel);
		clientChannel.register(selector, SelectionKey.OP_READ, channel);
		Fiber.spawn(() -> {
			onAccept(channel);
		});
	}

	/**
	 * Handle read from socket channel
	 * @param key
	 */
	private function handleRead(key:SelectionKey) {
		var socket:SocketChannel = cast key.channel();
		var channel:TcpChannel = cast key.attachment();
		var read = socket.read(this.readBuffer);
		if (read < 1)
			return;
		channel.appendRead(readBuffer);
	}

	/**
	 * Constructor
	 */
	public function new(endpoint:TcpListenerParameters) {
		this.host = endpoint.host;
		this.port = endpoint.port;

		var addr = if (host != null) {
			var inetAddr = InetAddress.getByName(this.host);
			new InetSocketAddress(inetAddr, port);
		} else {
			new InetSocketAddress(port);
		}

		this.readBuffer = ByteBuffer.allocate(READ_BUFFER_SIZE);
		this.serverSocket = ServerSocketChannel.open();
		this.serverSocket.socket().bind(addr);
		this.serverSocket.configureBlocking(false);
		this.selector = Selector.open();
		this.serverSocket.register(selector, SelectionKey.OP_ACCEPT);
	}

	/**
	 * Open port on host and starts listen
	 */
	public function open():Void {
		while (this.serverSocket.isOpen()) {
			var num = selector.select();
			if (num == 0)
				continue;

			var iter = this.selector.selectedKeys().iterator();

			while (iter.hasNext()) {
				var key = iter.next();
				iter.remove();

				if (key.isAcceptable()) {
					this.handleAccept(key);
				} else if (key.isReadable()) {
					this.handleRead(key);
				}
			}
		}
	}
}
