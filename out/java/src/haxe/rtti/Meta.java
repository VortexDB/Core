// Generated by Haxe 4.0.0-preview.4+1e3e5e016
package haxe.rtti;

import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public class Meta extends haxe.lang.HxObject
{
	public Meta(haxe.lang.EmptyObject empty)
	{
	}
	
	
	public Meta()
	{
		//line 35 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
		haxe.rtti.Meta.__hx_ctor_haxe_rtti_Meta(this);
	}
	
	
	protected static void __hx_ctor_haxe_rtti_Meta(haxe.rtti.Meta __hx_this)
	{
	}
	
	
	public static boolean isInterface(java.lang.Object t)
	{
		//line 48 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
		return ((java.lang.Class) (t) ).isInterface();
	}
	
	
	public static java.lang.Object getMeta(java.lang.Object t)
	{
		//line 62 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
		java.lang.Object ret = haxe.lang.Runtime.getField(t, "__meta__", false);
		//line 63 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
		if (( ( ret == null ) && ( t instanceof java.lang.Class ) )) 
		{
			//line 65 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
			if (haxe.rtti.Meta.isInterface(t)) 
			{
				//line 67 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
				java.lang.String name = haxe.root.Type.getClassName(((java.lang.Class) (t) ));
				//line 67 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
				java.lang.Class cls = haxe.root.Type.resolveClass(( name + "_HxMeta" ));
				//line 69 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
				if (( ((java.lang.Object) (cls) ) != ((java.lang.Object) (null) ) )) 
				{
					//line 70 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
					return haxe.lang.Runtime.getField(cls, "__meta__", false);
				}
				
			}
			
		}
		
		//line 73 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
		return ret;
	}
	
	
	public static java.lang.Object getFields(java.lang.Object t)
	{
		//line 94 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
		java.lang.Object meta = haxe.rtti.Meta.getMeta(t);
		//line 95 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
		if (( ( meta == null ) || ( haxe.lang.Runtime.getField(meta, "fields", true) == null ) )) 
		{
			//line 95 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
			return new haxe.lang.DynamicObject(new java.lang.String[]{}, new java.lang.Object[]{}, new java.lang.String[]{}, new double[]{});
		}
		else
		{
			//line 95 "C:\\HaxeToolkit\\haxe\\std\\haxe\\rtti\\Meta.hx"
			return haxe.lang.Runtime.getField(meta, "fields", true);
		}
		
	}
	
	
}

