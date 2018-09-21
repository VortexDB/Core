package core.io;

/**
 * On client accept callback
 */
typedef OnAcceptCall = (Void) -> Void;

/**
 * Listens for connections from TCP network clients.
 */
class TcpListener {
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
    public var onAccept : OnAcceptCall;

	/**
	 * Constructor
	 */
	public function new(host:String, port:Int) {
		this.host = host;
		this.port = port;
	}

    /**
     * Open port on host and starts listen
     */
    public function open() : Void {

    }
}
