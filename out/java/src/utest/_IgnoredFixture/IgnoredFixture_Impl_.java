// Generated by Haxe 4.0.0-preview.4+1e3e5e016
package utest._IgnoredFixture;

import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public final class IgnoredFixture_Impl_
{
	public static java.lang.String NotIgnored()
	{
		//line 5 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\IgnoredFixture.hx"
		java.lang.String this1 = null;
		//line 5 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\IgnoredFixture.hx"
		return haxe.lang.Runtime.toString(this1);
	}
	
	
	public static java.lang.String Ignored(java.lang.String reason)
	{
		//line 9 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\IgnoredFixture.hx"
		java.lang.String this1 = ( (( reason != null )) ? (reason) : ("") );
		//line 9 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\IgnoredFixture.hx"
		return haxe.lang.Runtime.toString(this1);
	}
	
	
	
	
	
	
	public static java.lang.String _new(java.lang.String reason)
	{
		//line 15 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\IgnoredFixture.hx"
		return haxe.lang.Runtime.toString(reason);
	}
	
	
	public static boolean get_isIgnored(java.lang.String this1)
	{
		//line 20 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\IgnoredFixture.hx"
		return ( this1 != null );
	}
	
	
	public static java.lang.String get_ignoreReason(java.lang.String this1)
	{
		//line 24 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\IgnoredFixture.hx"
		return this1;
	}
	
	
}


