// Generated by Haxe 4.0.0-preview.4+1e3e5e016
package haxe.root;

import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public class Reflect extends haxe.lang.HxObject
{
	public Reflect(haxe.lang.EmptyObject empty)
	{
	}
	
	
	public Reflect()
	{
		//line 28 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		haxe.root.Reflect.__hx_ctor__Reflect(this);
	}
	
	
	protected static void __hx_ctor__Reflect(haxe.root.Reflect __hx_this)
	{
	}
	
	
	public static boolean hasField(java.lang.Object o, java.lang.String field)
	{
		//line 32 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		if (( o instanceof haxe.lang.IHxObject )) 
		{
			//line 33 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			return ( ! (haxe.lang.Runtime.eq(((haxe.lang.IHxObject) (o) ).__hx_getField(field, false, true, false), haxe.lang.Runtime.undefined)) );
		}
		
		//line 35 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		return haxe.lang.Runtime.slowHasField(o, field);
	}
	
	
	public static java.lang.Object field(java.lang.Object o, java.lang.String field)
	{
		//line 41 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		if (( o instanceof haxe.lang.IHxObject )) 
		{
			//line 42 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			return ((haxe.lang.IHxObject) (o) ).__hx_getField(field, false, false, false);
		}
		
		//line 44 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		return haxe.lang.Runtime.slowGetField(o, field, false);
	}
	
	
	public static void setField(java.lang.Object o, java.lang.String field, java.lang.Object value)
	{
		//line 50 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		if (( o instanceof haxe.lang.IHxObject )) 
		{
			//line 51 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			((haxe.lang.IHxObject) (o) ).__hx_setField(field, value, false);
		}
		else
		{
			//line 53 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			haxe.lang.Runtime.slowSetField(o, field, value);
		}
		
	}
	
	
	public static java.lang.Object getProperty(java.lang.Object o, java.lang.String field)
	{
		//line 59 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		if (( o instanceof haxe.lang.IHxObject )) 
		{
			//line 60 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			return ((haxe.lang.IHxObject) (o) ).__hx_getField(field, false, false, true);
		}
		
		//line 62 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		if (haxe.lang.Runtime.slowHasField(o, ( "get_" + field ))) 
		{
			//line 63 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			return haxe.lang.Runtime.slowCallField(o, ( "get_" + field ), null);
		}
		
		//line 65 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		return haxe.lang.Runtime.slowGetField(o, field, false);
	}
	
	
	public static java.lang.Object callMethod(java.lang.Object o, java.lang.Object func, haxe.root.Array args)
	{
		//line 81 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		java.lang.Object[] ret = new java.lang.Object[args.length];
		//line 81 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		{
			//line 81 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			int _g1 = 0;
			//line 81 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			int _g = args.length;
			//line 81 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			while (( _g1 < _g ))
			{
				//line 81 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
				int i = _g1++;
				//line 81 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
				ret[i] = args.__get(i);
			}
			
		}
		
		//line 81 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		java.lang.Object[] args1 = ret;
		//line 82 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		return ((haxe.lang.Function) (func) ).__hx_invokeDynamic(args1);
	}
	
	
	public static haxe.root.Array<java.lang.String> fields(java.lang.Object o)
	{
		//line 88 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		if (( o instanceof haxe.lang.IHxObject )) 
		{
			//line 89 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			haxe.root.Array<java.lang.String> ret = new haxe.root.Array<java.lang.String>(new java.lang.String[]{});
			//line 90 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			((haxe.lang.IHxObject) (o) ).__hx_getFields(ret);
			//line 91 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			return ret;
		}
		else
		{
			//line 92 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			if (( o instanceof java.lang.Class )) 
			{
				//line 93 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
				return haxe.root.Type.getClassFields(((java.lang.Class) (o) ));
			}
			else
			{
				//line 95 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
				return new haxe.root.Array<java.lang.String>(new java.lang.String[]{});
			}
			
		}
		
	}
	
	
	public static boolean isFunction(java.lang.Object f)
	{
		//line 101 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		return ( f instanceof haxe.lang.Function );
	}
	
	
	public static <T> int compare(T a, T b)
	{
		//line 106 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		return haxe.lang.Runtime.compare(a, b);
	}
	
	
	public static boolean compareMethods(java.lang.Object f1, java.lang.Object f2)
	{
		//line 112 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		if (haxe.lang.Runtime.eq(f1, f2)) 
		{
			//line 113 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			return true;
		}
		
		//line 115 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		if (( ( f1 instanceof haxe.lang.Closure ) && ( f2 instanceof haxe.lang.Closure ) )) 
		{
			//line 116 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			haxe.lang.Closure f1c = ((haxe.lang.Closure) (f1) );
			//line 117 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			haxe.lang.Closure f2c = ((haxe.lang.Closure) (f2) );
			//line 118 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			if (haxe.lang.Runtime.refEq(f1c.obj, f2c.obj)) 
			{
				//line 118 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
				return haxe.lang.Runtime.valEq(f1c.field, f2c.field);
			}
			else
			{
				//line 118 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
				return false;
			}
			
		}
		
		//line 120 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		return false;
	}
	
	
	public static boolean isObject(java.lang.Object v)
	{
		//line 125 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
		if (( ! (( v == null )) )) 
		{
			//line 125 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			return  ! ((( ( ( ( ( v instanceof haxe.lang.Enum ) || ( v instanceof haxe.lang.Function ) ) || ( v instanceof java.lang.Enum ) ) || ( v instanceof java.lang.Number ) ) || ( v instanceof java.lang.Boolean ) ))) ;
		}
		else
		{
			//line 125 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\Reflect.hx"
			return false;
		}
		
	}
	
	
}

