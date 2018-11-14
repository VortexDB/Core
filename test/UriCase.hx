package test;

import utest.Assert;
import core.utils.Uri;
/**
 *  For testing URI
 */
class UriCase {
    /**
	 * Constructor
	 */
	public function new() {};

    /**
	 * Test http url
	 */
	public function testHttpUrl() {
        var url:Uri = "https://john.doe@www.example.com:123/forum/questions/?tag=networking&order=newest#top";
        Assert.equals(url.scheme, "https");
        Assert.equals(url.authority, "john.doe@www.example.com:123");
        Assert.equals(url.path, "/forum/questions/");
        Assert.equals(url.query, "tag=networking&order=newest");
        Assert.equals(url.fragment, "top");
    }

    /**
     * Test ldap
     */
    public function testLdap() {
        var url:Uri = "ldap://[2001:db8::7]/c=GB?objectClass?one";
        Assert.equals(url.scheme, "ldap");
        Assert.equals(url.authority, "[2001:db8::7]");
        Assert.equals(url.path, "/c=GB");
        Assert.equals(url.query, "objectClass?one");
        Assert.equals(url.fragment, null);
    }

    /**
     * Test mailto
     */
    public function testMailto() {
        var url:Uri = "mailto:John.Doe@example.com";
        Assert.equals(url.scheme, "mailto");
        Assert.equals(url.authority, null);
        Assert.equals(url.path, "John.Doe@example.com");
        Assert.equals(url.query, null);
        Assert.equals(url.fragment, null);
    }

    /**
     * Test news
     */
    public function testNews() {
        var url:Uri = "news:comp.infosystems.www.servers.unix";
        Assert.equals(url.scheme, "news");
        Assert.equals(url.authority, null);
        Assert.equals(url.path, "comp.infosystems.www.servers.unix");
        Assert.equals(url.query, null);
        Assert.equals(url.fragment, null);
    }

    /**
     * Test tel
     */
    public function testTel() {
        var url:Uri = "tel:+1-816-555-1212";
        Assert.equals(url.scheme, "tel");
        Assert.equals(url.authority, null);
        Assert.equals(url.path, "+1-816-555-1212");
        Assert.equals(url.query, null);
        Assert.equals(url.fragment, null);
    }

    /**
     * Test telnet
     */
    public function testTelnet() {
        var url:Uri = "telnet://192.0.2.16:80/";
        Assert.equals(url.scheme, "telnet");
        Assert.equals(url.authority, "192.0.2.16:80");
        Assert.equals(url.path, "/");
        Assert.equals(url.query, null);
        Assert.equals(url.fragment, null);
    }

    /**
     * Test URN
     */
    public function testURN() {
        var url:Uri = "urn:oasis:names:specification:docbook:dtd:xml:4.1.2";
        Assert.equals(url.scheme, "urn");
        Assert.equals(url.authority, null);
        Assert.equals(url.path, "oasis:names:specification:docbook:dtd:xml:4.1.2");
        Assert.equals(url.query, null);
        Assert.equals(url.fragment, null);
    }
}