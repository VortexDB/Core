package core.io.socket;

/**
 *  Client peer
 */
class Peer {
	/**
	 *  Peer host
	 */
	public var host(default, null):String;

	/**
	 *  Peer port
	 */
	public var port(default, null):Int;

	/**
	 *  Constructor
	 */
	public function new(host:String, port:Int) {
		this.host = host;
		this.port = port;
	}
}