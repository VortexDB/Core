package core.io.socket;

#if java
import java.nio.channels.SocketChannel;
import java.net.InetSocketAddress;

/**
 *  Channel of TCP socket
 */
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
	 * Constructor
	 */
    @:allow(core.io.socket.TcpListener)
	private function new(nativeSocket:SocketChannel) {
        input = new SocketInput(nativeSocket);
        output = new SocketOutput(nativeSocket);
        var address = cast(nativeSocket.getRemoteAddress(), InetSocketAddress);        
        peer = new Peer(address.getHostString(), address.getPort());
    }
}
#end
