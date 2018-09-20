// Generated by Haxe 4.0.0-preview.4+1e3e5e016
package sys.io;

import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public class Process extends haxe.lang.HxObject
{
	public Process(haxe.lang.EmptyObject empty)
	{
	}
	
	
	public Process()
	{
		//line 31 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
		sys.io.Process.__hx_ctor_sys_io_Process(this);
	}
	
	
	protected static void __hx_ctor_sys_io_Process(sys.io.Process __hx_this)
	{
	}
	
	
	public static java.lang.ProcessBuilder createProcessBuilder(java.lang.String cmd, haxe.root.Array<java.lang.String> args)
	{
		//line 40 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
		java.lang.String sysName = haxe.root.Sys.systemName();
		//line 41 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
		java.lang.String[] pargs = null;
		//line 42 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
		if (( args == null )) 
		{
			//line 43 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
			java.lang.String cmdStr = cmd;
			//line 44 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
			{
				//line 44 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
				java.lang.String __temp_svar1 = (sysName);
				//line 44 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
				boolean __temp_executeDef2 = true;
				//line 44 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
				switch (__temp_svar1.hashCode())
				{
					case -1280820637:
					{
						//line 44 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
						if (__temp_svar1.equals("Windows")) 
						{
							//line 44 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
							__temp_executeDef2 = false;
							//line 46 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
							pargs = new java.lang.String[3];
							//line 47 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
							java.lang.String _g = haxe.root.Sys.getEnv("COMSPEC");
							//line 48 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
							cmd = ( (( _g == null )) ? ("cmd.exe") : (_g) );
							//line 47 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
							pargs[0] = cmd;
							//line 51 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
							pargs[1] = "/C";
							//line 52 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
							pargs[2] = ( ( "\"" + cmdStr ) + "\"" );
						}
						
						//line 44 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
						break;
					}
					
					
				}
				
				//line 53 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
				if (__temp_executeDef2) 
				{
					//line 54 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
					pargs = new java.lang.String[3];
					//line 55 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
					cmd = "/bin/sh";
					//line 55 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
					pargs[0] = "/bin/sh";
					//line 56 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
					pargs[1] = "-c";
					//line 57 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
					pargs[2] = cmdStr;
				}
				
			}
			
		}
		else
		{
			//line 60 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
			pargs = new java.lang.String[( args.length + 1 )];
			//line 61 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
			{
				//line 61 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
				java.lang.String __temp_svar3 = (sysName);
				//line 61 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
				boolean __temp_executeDef4 = true;
				//line 61 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
				switch (__temp_svar3.hashCode())
				{
					case -1280820637:
					{
						//line 61 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
						if (__temp_svar3.equals("Windows")) 
						{
							//line 61 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
							__temp_executeDef4 = false;
							//line 63 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
							pargs[0] = haxe.root.StringTools.quoteWinArg(cmd, false);
							//line 64 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
							{
								//line 64 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
								int _g1 = 0;
								//line 64 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
								int _g2 = args.length;
								//line 64 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
								while (( _g1 < _g2 ))
								{
									//line 64 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
									int i = _g1++;
									//line 66 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
									pargs[( i + 1 )] = haxe.root.StringTools.quoteWinArg(args.__get(i), false);
								}
								
							}
							
						}
						
						//line 61 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
						break;
					}
					
					
				}
				
				//line 68 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
				if (__temp_executeDef4) 
				{
					//line 69 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
					pargs[0] = cmd;
					//line 70 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
					{
						//line 70 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
						int _g11 = 0;
						//line 70 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
						int _g3 = args.length;
						//line 70 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
						while (( _g11 < _g3 ))
						{
							//line 70 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
							int i1 = _g11++;
							//line 72 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
							pargs[( i1 + 1 )] = args.__get(i1);
						}
						
					}
					
				}
				
			}
			
		}
		
		//line 77 "C:\\HaxeToolkit\\haxe\\std\\java\\_std\\sys\\io\\Process.hx"
		return new java.lang.ProcessBuilder(((java.lang.String[]) (pargs) ));
	}
	
	
}


