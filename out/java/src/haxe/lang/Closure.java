// Generated by Haxe 4.0.0-preview.4+1e3e5e016
package haxe.lang;

import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public class Closure extends haxe.lang.VarArgsBase
{
	public Closure(java.lang.Object obj, java.lang.String field)
	{
		//line 71 "C:\\HaxeToolkit\\haxe\\std\\java\\internal\\Function.hx"
		super(-1, -1);
		//line 72 "C:\\HaxeToolkit\\haxe\\std\\java\\internal\\Function.hx"
		this.obj = obj;
		//line 73 "C:\\HaxeToolkit\\haxe\\std\\java\\internal\\Function.hx"
		this.field = field;
	}
	
	
	public java.lang.Object obj;
	
	public java.lang.String field;
	
	@Override public java.lang.Object __hx_invokeDynamic(java.lang.Object[] dynArgs)
	{
		//line 78 "C:\\HaxeToolkit\\haxe\\std\\java\\internal\\Function.hx"
		return haxe.lang.Runtime.callField(this.obj, this.field, dynArgs);
	}
	
	
	@Override public boolean equals(java.lang.Object obj)
	{
		//line 83 "C:\\HaxeToolkit\\haxe\\std\\java\\internal\\Function.hx"
		if (( obj == null )) 
		{
			//line 84 "C:\\HaxeToolkit\\haxe\\std\\java\\internal\\Function.hx"
			return false;
		}
		
		//line 86 "C:\\HaxeToolkit\\haxe\\std\\java\\internal\\Function.hx"
		haxe.lang.Closure c = ((haxe.lang.Closure) (obj) );
		//line 87 "C:\\HaxeToolkit\\haxe\\std\\java\\internal\\Function.hx"
		if (haxe.lang.Runtime.eq(c.obj, this.obj)) 
		{
			//line 87 "C:\\HaxeToolkit\\haxe\\std\\java\\internal\\Function.hx"
			return haxe.lang.Runtime.valEq(c.field, this.field);
		}
		else
		{
			//line 87 "C:\\HaxeToolkit\\haxe\\std\\java\\internal\\Function.hx"
			return false;
		}
		
	}
	
	
	@Override public int hashCode()
	{
		//line 92 "C:\\HaxeToolkit\\haxe\\std\\java\\internal\\Function.hx"
		return ( ((int) (this.obj.hashCode()) ) ^ ((int) (this.field.hashCode()) ) );
	}
	
	
}

