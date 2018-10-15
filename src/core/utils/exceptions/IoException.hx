package core.utils.exceptions;

/**
 * Base io exception
 */
class IoException extends Exception {    
}

/**
 * End of file/data exception
 */
class EofException extends IoException {}

/**
 * Connection closed exception
 */
class ConnectionClosed extends IoException {}