package core.io.http;

/**
 *  Http status for response
 */
 @:enum
abstract HttpStatus(Int) {
    /**
     *  Normal response
     */
    var Ok = 200;

    /**
     * File not modified
     */
    var NotModified = 304;

    /**
     *  Server internal error
     */
    var Internal = 500;

    /**
     *  Bad request
     */
     var BadRequest = 400;

    /**
     *  Resource not found
     */
    var NotFound = 404;

    /**
     *  Get string description of error
     *  @return String
     */
    public function getDescription () : String {
        switch (this) {
            case Ok: return "OK";
            case Internal: return "Internal error";
            case BadRequest: return "Bad request";
            case NotFound: return "Not found";
        }

        return "Unknown";
    }
}