// Generated by Haxe 4.0.0-preview.4+1e3e5e016
package utest.ui.common;

import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public class PackageResult_classNames_60__Fun extends haxe.lang.Function
{
	public PackageResult_classNames_60__Fun(utest.ui.common.PackageResult me)
	{
		//line 60 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
		super(2, 1);
		//line 60 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
		this.me = me;
	}
	
	
	@Override public double __hx_invoke2_f(double __fn_float1, java.lang.Object __fn_dyn1, double __fn_float2, java.lang.Object __fn_dyn2)
	{
		//line 60 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
		java.lang.String b = ( (( __fn_dyn2 == haxe.lang.Runtime.undefined )) ? (haxe.lang.Runtime.toString(__fn_float2)) : (haxe.lang.Runtime.toString(__fn_dyn2)) );
		//line 60 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
		java.lang.String a = ( (( __fn_dyn1 == haxe.lang.Runtime.undefined )) ? (haxe.lang.Runtime.toString(__fn_float1)) : (haxe.lang.Runtime.toString(__fn_dyn1)) );
		//line 61 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
		utest.ui.common.ResultStats as = this.me.getClass(a).stats;
		//line 62 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
		utest.ui.common.ResultStats bs = this.me.getClass(b).stats;
		//line 63 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
		if (as.hasErrors) 
		{
			//line 64 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
			if ( ! (bs.hasErrors) ) 
			{
				//line 64 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
				return ((double) (-1) );
			}
			else
			{
				//line 64 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
				if (( as.errors == bs.errors )) 
				{
					//line 64 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
					return ((double) (((int) (haxe.root.Reflect.compare(haxe.lang.Runtime.toString(a), haxe.lang.Runtime.toString(b))) )) );
				}
				else
				{
					//line 64 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
					return ((double) (((int) (haxe.root.Reflect.compare(((java.lang.Object) (as.errors) ), ((java.lang.Object) (bs.errors) ))) )) );
				}
				
			}
			
		}
		else
		{
			//line 65 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
			if (bs.hasErrors) 
			{
				//line 66 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
				return ((double) (1) );
			}
			else
			{
				//line 67 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
				if (as.hasFailures) 
				{
					//line 68 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
					if ( ! (bs.hasFailures) ) 
					{
						//line 68 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
						return ((double) (-1) );
					}
					else
					{
						//line 68 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
						if (( as.failures == bs.failures )) 
						{
							//line 68 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
							return ((double) (((int) (haxe.root.Reflect.compare(haxe.lang.Runtime.toString(a), haxe.lang.Runtime.toString(b))) )) );
						}
						else
						{
							//line 68 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
							return ((double) (((int) (haxe.root.Reflect.compare(((java.lang.Object) (as.failures) ), ((java.lang.Object) (bs.failures) ))) )) );
						}
						
					}
					
				}
				else
				{
					//line 69 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
					if (bs.hasFailures) 
					{
						//line 70 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
						return ((double) (1) );
					}
					else
					{
						//line 71 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
						if (as.hasWarnings) 
						{
							//line 72 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
							if ( ! (bs.hasWarnings) ) 
							{
								//line 72 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
								return ((double) (-1) );
							}
							else
							{
								//line 72 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
								if (( as.warnings == bs.warnings )) 
								{
									//line 72 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
									return ((double) (((int) (haxe.root.Reflect.compare(haxe.lang.Runtime.toString(a), haxe.lang.Runtime.toString(b))) )) );
								}
								else
								{
									//line 72 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
									return ((double) (((int) (haxe.root.Reflect.compare(((java.lang.Object) (as.warnings) ), ((java.lang.Object) (bs.warnings) ))) )) );
								}
								
							}
							
						}
						else
						{
							//line 73 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
							if (bs.hasWarnings) 
							{
								//line 74 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
								return ((double) (1) );
							}
							else
							{
								//line 76 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\common\\PackageResult.hx"
								return ((double) (((int) (haxe.root.Reflect.compare(haxe.lang.Runtime.toString(a), haxe.lang.Runtime.toString(b))) )) );
							}
							
						}
						
					}
					
				}
				
			}
			
		}
		
	}
	
	
	public utest.ui.common.PackageResult me;
	
}


