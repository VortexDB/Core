// Generated by Haxe 4.0.0-preview.4+1e3e5e016
package utest.ui.text;

import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public class PrintReport extends utest.ui.text.PlainTextReport
{
	public PrintReport(haxe.lang.EmptyObject empty)
	{
		//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
		super(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public PrintReport(utest.Runner runner)
	{
		//line 40 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
		super(haxe.lang.EmptyObject.EMPTY);
		//line 40 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
		utest.ui.text.PrintReport.__hx_ctor_utest_ui_text_PrintReport(this, runner);
	}
	
	
	protected static void __hx_ctor_utest_ui_text_PrintReport(utest.ui.text.PrintReport __hx_this, utest.Runner runner)
	{
		//line 40 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
		utest.ui.text.PlainTextReport.__hx_ctor_utest_ui_text_PlainTextReport(__hx_this, runner, ((haxe.lang.Function) (new haxe.lang.Closure(__hx_this, "_handler")) ));
		//line 41 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
		__hx_this.newline = "\n";
		//line 42 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
		__hx_this.indent = "  ";
	}
	
	
	public void _handler(utest.ui.text.PlainTextReport report)
	{
		//line 46 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
		this._trace(report.getResults());
	}
	
	
	public void _trace(java.lang.String s)
	{
		//line 50 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
		s = haxe.root.StringTools.replace(s, "  ", this.indent);
		//line 51 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
		s = haxe.root.StringTools.replace(s, "\n", this.newline);
		//line 52 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
		haxe.Log.trace.__hx_invoke2_o(0.0, s, 0.0, new haxe.lang.DynamicObject(new java.lang.String[]{"className", "fileName", "methodName"}, new java.lang.Object[]{"utest.ui.text.PrintReport", "utest/ui/text/PrintReport.hx", "_trace"}, new java.lang.String[]{"lineNumber"}, new double[]{((double) (((double) (52) )) )}));
	}
	
	
	@Override public java.lang.Object __hx_getField(java.lang.String field, boolean throwErrors, boolean isCheck, boolean handleProperties)
	{
		//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
		{
			//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
			boolean __temp_executeDef1 = true;
			//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
			switch (field.hashCode())
			{
				case -1464576954:
				{
					//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
					if (field.equals("_trace")) 
					{
						//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
						__temp_executeDef1 = false;
						//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
						return ((haxe.lang.Function) (new haxe.lang.Closure(this, "_trace")) );
					}
					
					//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
					break;
				}
				
				
				case -1243939317:
				{
					//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
					if (field.equals("_handler")) 
					{
						//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
						__temp_executeDef1 = false;
						//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
						return ((haxe.lang.Function) (new haxe.lang.Closure(this, "_handler")) );
					}
					
					//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
					break;
				}
				
				
			}
			
			//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
			if (__temp_executeDef1) 
			{
				//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
				return super.__hx_getField(field, throwErrors, isCheck, handleProperties);
			}
			else
			{
				//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
				throw null;
			}
			
		}
		
	}
	
	
	@Override public java.lang.Object __hx_invokeField(java.lang.String field, java.lang.Object[] dynargs)
	{
		//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
		{
			//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
			boolean __temp_executeDef1 = true;
			//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
			switch (field.hashCode())
			{
				case -1464576954:
				{
					//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
					if (field.equals("_trace")) 
					{
						//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
						__temp_executeDef1 = false;
						//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
						this._trace(haxe.lang.Runtime.toString(dynargs[0]));
					}
					
					//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
					break;
				}
				
				
				case -1243939317:
				{
					//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
					if (field.equals("_handler")) 
					{
						//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
						__temp_executeDef1 = false;
						//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
						this._handler(((utest.ui.text.PlainTextReport) (dynargs[0]) ));
					}
					
					//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
					break;
				}
				
				
			}
			
			//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
			if (__temp_executeDef1) 
			{
				//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
				return super.__hx_invokeField(field, dynargs);
			}
			
		}
		
		//line 13 "C:\\Users\\VEgorov\\haxelib\\utest\\1,8,4\\src\\utest\\ui\\text\\PrintReport.hx"
		return null;
	}
	
	
}

