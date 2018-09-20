// Generated by Haxe 4.0.0-preview.4+1e3e5e016
package haxe.root;

import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public class StringTools extends haxe.lang.HxObject
{
	static
	{
		//line 510 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
		haxe.root.StringTools.winMetaCharacters = new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{32, 40, 41, 37, 33, 94, 34, 60, 62, 38, 124, 10, 13, 44, 59});
	}
	
	public StringTools(haxe.lang.EmptyObject empty)
	{
	}
	
	
	public StringTools()
	{
		//line 33 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
		haxe.root.StringTools.__hx_ctor__StringTools(this);
	}
	
	
	protected static void __hx_ctor__StringTools(haxe.root.StringTools __hx_this)
	{
	}
	
	
	public static java.lang.String replace(java.lang.String s, java.lang.String sub, java.lang.String by)
	{
		//line 380 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
		if (( sub.length() == 0 )) 
		{
			//line 381 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			return haxe.lang.StringExt.split(s, sub).join(by);
		}
		else
		{
			//line 383 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			return s.replace(sub, by);
		}
		
	}
	
	
	public static haxe.root.Array<java.lang.Object> winMetaCharacters;
	
	public static java.lang.String quoteWinArg(java.lang.String argument, boolean escapeMetaCharacters)
	{
		//line 527 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
		if ( ! (new haxe.root.EReg("^[^ \t\\\\\"]+$", "").match(argument)) ) 
		{
			//line 532 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			haxe.root.StringBuf result = new haxe.root.StringBuf();
			//line 533 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			boolean needquote = ( ( ( haxe.lang.StringExt.indexOf(argument, " ", null) != -1 ) || ( haxe.lang.StringExt.indexOf(argument, "\t", null) != -1 ) ) || haxe.lang.Runtime.valEq(argument, "") );
			//line 535 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			if (needquote) 
			{
				//line 536 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
				result.add(haxe.lang.Runtime.toString("\""));
			}
			
			//line 538 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			haxe.root.StringBuf bs_buf = new haxe.root.StringBuf();
			//line 539 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			{
				//line 539 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
				int _g1 = 0;
				//line 539 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
				int _g = argument.length();
				//line 539 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
				while (( _g1 < _g ))
				{
					//line 539 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
					int i = _g1++;
					//line 540 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
					{
						//line 540 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
						java.lang.Object _g2 = haxe.lang.StringExt.charCodeAt(argument, i);
						//line 540 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
						if (haxe.lang.Runtime.eq(_g2, null)) 
						{
							//line 553 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
							if (( bs_buf.b.length() > 0 )) 
							{
								//line 554 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
								result.add(haxe.lang.Runtime.toString(bs_buf.toString()));
								//line 555 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
								bs_buf = new haxe.root.StringBuf();
							}
							
							//line 557 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
							result.addChar(((int) (haxe.lang.Runtime.toInt(_g2)) ));
						}
						else
						{
							//line 540 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
							switch (((int) (haxe.lang.Runtime.toInt((_g2))) ))
							{
								case 34:
								{
									//line 546 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
									java.lang.String bs = bs_buf.toString();
									//line 547 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
									result.add(haxe.lang.Runtime.toString(bs));
									//line 548 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
									result.add(haxe.lang.Runtime.toString(bs));
									//line 549 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
									bs_buf = new haxe.root.StringBuf();
									//line 550 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
									result.add(haxe.lang.Runtime.toString("\\\""));
									//line 544 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
									break;
								}
								
								
								case 92:
								{
									//line 543 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
									bs_buf.add(haxe.lang.Runtime.toString("\\"));
									//line 543 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
									break;
								}
								
								
								default:
								{
									//line 553 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
									if (( bs_buf.b.length() > 0 )) 
									{
										//line 554 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
										result.add(haxe.lang.Runtime.toString(bs_buf.toString()));
										//line 555 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
										bs_buf = new haxe.root.StringBuf();
									}
									
									//line 557 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
									result.addChar(((int) (haxe.lang.Runtime.toInt(_g2)) ));
									//line 551 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
									break;
								}
								
							}
							
						}
						
					}
					
				}
				
			}
			
			//line 562 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			result.add(haxe.lang.Runtime.toString(bs_buf.toString()));
			//line 564 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			if (needquote) 
			{
				//line 565 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
				result.add(haxe.lang.Runtime.toString(bs_buf.toString()));
				//line 566 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
				result.add(haxe.lang.Runtime.toString("\""));
			}
			
			//line 569 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			argument = result.toString();
		}
		
		//line 572 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
		if (escapeMetaCharacters) 
		{
			//line 573 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			haxe.root.StringBuf result1 = new haxe.root.StringBuf();
			//line 574 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			{
				//line 574 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
				int _g11 = 0;
				//line 574 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
				int _g3 = argument.length();
				//line 574 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
				while (( _g11 < _g3 ))
				{
					//line 574 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
					int i1 = _g11++;
					//line 575 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
					java.lang.Object c = haxe.lang.StringExt.charCodeAt(argument, i1);
					//line 576 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
					if (( haxe.root.StringTools.winMetaCharacters.indexOf(c, null) >= 0 )) 
					{
						//line 577 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
						result1.addChar(94);
					}
					
					//line 579 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
					result1.addChar(((int) (haxe.lang.Runtime.toInt(c)) ));
				}
				
			}
			
			//line 581 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			return result1.toString();
		}
		else
		{
			//line 583 "C:\\HaxeToolkit\\haxe\\std\\StringTools.hx"
			return argument;
		}
		
	}
	
	
}


