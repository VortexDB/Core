package core.io.socket;

#if java
import java.nio.channels.SocketChannel;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;

/**
 *  Channel of TCP socket
 */
@:allow(core.io.socket.TcpListener)
class TcpChannel {
	/**
	 *  For reading data
	 */
	public final input:SocketInput;

	/**
	 *  For writing data
	 */
	public final output:SocketOutput;

	/**
	 *  Socket address
	 */
	public final peer:Peer;

    /**
	 * Append buffer to read buffer
	 * @param buffer 
	 */
	private function appendRead(buffer:ByteBuffer, count:Int) {
		input.appendRead(buffer, count);
	}

	/**
	 * Constructor
	 */    
	private function new(nativeSocket:SocketChannel) {
        input = new SocketInput(nativeSocket);
        output = new SocketOutput(nativeSocket);
        var address = cast(nativeSocket.getRemoteAddress(), InetSocketAddress);        
        peer = new Peer(address.getHostString(), address.getPort());
    }
}
#end
