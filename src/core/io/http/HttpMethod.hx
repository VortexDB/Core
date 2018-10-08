package core.io.http;

/**
 *  Http method type
 */
@:enum
abstract HttpMethod(String) from String to String {
    /**
     *  The GET method means retrieve whatever information (in the form of an entity) is identified by the Request-URI. 
     *  If the Request-URI refers to a data-producing process, it is the produced data which shall be returned as the entity 
     *  in the response and not the source text of the process, unless that text happens to be the output of the process.
     */
    var Get = "GET";

    /**
     *  The HEAD method is identical to GET except that the server MUST NOT return a message-body in the response. 
     *  The metainformation contained in the HTTP headers in response to a HEAD request SHOULD be identical to the information sent in response to a GET request. 
     *  This method can be used for obtaining metainformation about the entity implied by the request without transferring the entity-body itself. 
     *  This method is often used for testing hypertext links for validity, accessibility, and recent modification.
     */
    var Head = "HEAD";

    /**
     *  The POST method is used to request that the origin server accept the entity enclosed in the request as a new subordinate of the resource identified by the Request-URI in the Request-Line. 
     *  POST is designed to allow a uniform method to cover the following functions:
     */
    var Post = "POST";

    /**
     *  The PUT method requests that the enclosed entity be stored under the supplied Request-URI. 
     *  If the Request-URI refers to an already existing resource, the enclosed entity SHOULD be considered as a modified version of the one residing on the origin server. 
     */
    var Put = "PUT";

    /**
     *  The DELETE method requests that the origin server delete the resource identified by the Request-URI. This method MAY be overridden by human intervention (or other means) on the origin server. 
     *  The client cannot be guaranteed that the operation has been carried out, even if the status code returned from the origin server indicates that the action has been completed successfully.
     */
    var Delete = "DELETE";

    /**
     *  The TRACE method is used to invoke a remote, application-layer loop- back of the request message. 
     *  The final recipient of the request SHOULD reflect the message received back to the client as the entity-body of a 200 (OK) response.
     */
    var Trace = "TRACE";

    /**
     *  This specification reserves the method name CONNECT for use with a proxy that can dynamically switch to being a tunnel (e.g. SSL tunneling [44]).
     */
    var Connect = "CONNECT";
}