package core.io.http.websocket;

/**
 *  Web socket frame types
 */
@:enum
@:native("t.FrameType")
abstract FrameType(Int) from Int to Int {
	var Continue = 0x00;
	var Text = 0x01;
	var Binary = 0x02;
	var Close = 0x08;
	var Ping = 0x09;
	var Pong = 0x0A;
}
