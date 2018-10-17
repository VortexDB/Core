package core.io.socket;

import java.NativeArray;
import haxe.io.Bytes;

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
	 *  Socket address
	 */
	public final peer:Peer;

	/**
	 * On data callback
	 */
	public var onData:(TcpChannel, Bytes)->Void;

    /**
	 * Notify data from source
	 * @param buffer 
	 */
	private function notifyData(buffer:ByteBuffer, count:Int) {
		var arr = new NativeArray(count);
		buffer.get(arr);
		var bytes = Bytes.ofData(arr);
		if (onData != null)
			onData(this, bytes);
	}

	/**
	 * Constructor
	 */    
	private function new(nativeSocket:SocketChannel) {
		this.nativeSocket = nativeSocket;
        var address = cast(nativeSocket.getRemoteAddress(), InetSocketAddress);        
        peer = new Peer(address.getHostString(), address.getPort());
    }

	/**
	 * Close channel
	 */
	public function close() {
		nativeSocket.close();
		key.cancel();
	}
}
#end
