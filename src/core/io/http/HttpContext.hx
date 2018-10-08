package core.io.http;

/**
 *  Context for request and response
 */
@:final
class HttpContext {
    /**
     *  Request
     */
    public var request (default, null) : HttpRequest;

    /**
     *  Response
     */
    public var response (default, null) : HttpResponse;

    /**
     *  Constructor
     *  @param request - http request
     *  @param response - http response
     */
    public function new (request : HttpRequest, response : HttpResponse) {
        this.request = request;
        this.response = response;
    }
}