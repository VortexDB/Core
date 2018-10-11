package core.io.output;

/**
 *  Writeable for socket type objects
 */
interface ISocketOutput extends IByteOutput 
                        extends ITextOutput
                        extends ICloseable
{
}