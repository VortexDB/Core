package core.io;

import java.net.InetSocketAddress;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.Selector;
import java.nio.channels.SelectionKey;

/**
 * On client accept callback
 */
typedef OnAcceptCall = (Void) -> Void;

/**
 * Listens for connections from TCP network clients.
 */
class TcpListener {
	/**
	 * Server socket
	 */
	private final serverSocket:ServerSocketChannel;

	/**
	 * Selector for sockets
	 */
	private final selector:Selector;

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
	 * @param key
	 */
	private function handleAccept(key:SelectionKey) {}

	/**
	 * Handle read from client socket
	 * @param key
	 */
	private function handleRead(key:SelectionKey) {}

	/**
	 * Constructor
	 */
	public function new(host:String, port:Int) {
		this.host = host;
		this.port = port;
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
