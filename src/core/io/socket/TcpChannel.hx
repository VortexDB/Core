package core.io.socket;

/**
 *  Channel of TCP socket
 */
class TcpChannel {

    /**
     *  For reading data
     */
    public var input (default, null) : SocketInput;

    /**
     *  For writing data
     */
    public var output (default, null) : SocketOutput;

    /**
     *  Socket address
     */
    public var peer (default, null) : Peer;
    
}