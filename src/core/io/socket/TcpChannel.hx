package core.io.socket;

import java.NativeArray;
import haxe.io.Bytes;
import core.async.stream.Stream;
import core.async.stream.StreamController;

#if java
import java.nio.channels.SocketChannel;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;

/**
 *  Channel of TCP socket
 */
@:allow(core.io.socket.TcpListener)
class TcpChannel {
	/**
	 * Native socket
	 */
	private var nativeSocket:SocketChannel;

	/**
	 * Key of selector
	 */
	private var key:SelectionKey;
	
	/**
	 * For on data stream
	 */
	private final onDataController:StreamController<Bytes>;

	/**
	 *  Socket address
	 */
	public final peer:Peer;

	/**
	 * Data stream
	 */
	public final onData:Stream<Bytes>;	

	/**
	 * For output data
	 */
	public var output:SocketOutput;

    /**
	 * Notify data from source
	 * @param buffer 
	 */
	private function notifyData(buffer:ByteBuffer, count:Int) {
		var bytes = @:privateAccess new Bytes(count, buffer.array());
		onDataController.add(bytes);
	}

	/**
	 * Constructor
	 */    
	private function new(nativeSocket:SocketChannel) {
		this.nativeSocket = nativeSocket;
		this.output = new SocketOutput(this.nativeSocket);
		this.onDataController = new StreamController<Bytes>();
		this.onData = this.onDataController.stream;
        var address = cast(nativeSocket.getRemoteAddress(), InetSocketAddress);        
        peer = new Peer(address.getHostString(), address.getPort());		
    }

	/**
	 * Close channel
	 */
	public function close() {
		nativeSocket.close();
		key.cancel();
		onDataController.close();
	}
}
#end
