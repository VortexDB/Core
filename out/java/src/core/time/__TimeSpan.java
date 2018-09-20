// Generated by Haxe 4.0.0-preview.4+1e3e5e016
package core.time;

import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public class __TimeSpan extends haxe.lang.HxObject
{
	static
	{
		//line 72 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		core.time.__TimeSpan.MAX_32_PRECISION = 4294967296.0;
		//line 77 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		core.time.__TimeSpan.SECONDS_PER_MINUTE = 60;
		//line 82 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		core.time.__TimeSpan.SECONDS_PER_HOUR = 3600;
		//line 87 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		core.time.__TimeSpan.SECONDS_PER_DAY = 86400;
		//line 92 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		core.time.__TimeSpan.NANOSECONDS_PER_SECOND = 1000000000;
	}
	
	public __TimeSpan(haxe.lang.EmptyObject empty)
	{
	}
	
	
	public __TimeSpan(java.lang.Object interval)
	{
		//line 193 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		core.time.__TimeSpan.__hx_ctor_core_time___TimeSpan(this, interval);
	}
	
	
	protected static void __hx_ctor_core_time___TimeSpan(core.time.__TimeSpan __hx_this, java.lang.Object interval)
	{
		//line 194 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		__hx_this.nanoseconds = ((int) (haxe.lang.Runtime.toInt(haxe.lang.Runtime.getField(interval, "nanoseconds", true))) );
		//line 195 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		__hx_this.seconds = core.time.__TimeSpan.computeSeconds(((int) (haxe.lang.Runtime.toInt(haxe.lang.Runtime.getField(interval, "days", true))) ), ((int) (haxe.lang.Runtime.toInt(haxe.lang.Runtime.getField(interval, "hours", true))) ), ((int) (haxe.lang.Runtime.toInt(haxe.lang.Runtime.getField(interval, "minutes", true))) ), ((int) (haxe.lang.Runtime.toInt(haxe.lang.Runtime.getField(interval, "seconds", true))) ));
	}
	
	
	public static double MAX_32_PRECISION;
	
	public static int SECONDS_PER_MINUTE;
	
	public static int SECONDS_PER_HOUR;
	
	public static int SECONDS_PER_DAY;
	
	public static int NANOSECONDS_PER_SECOND;
	
	public static double toFloat(long i)
	{
		//line 139 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		return ((double) (( ((int) (((long) (i) )) ) + ((double) (( (((int) (((long) (( ((long) (i) ) >> 32 )) )) )) * 4294967296.0 )) ) )) );
	}
	
	
	public static long computeSeconds(int days, int hours, int minutes, int seconds)
	{
		//line 151 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		int hrssec = ( hours * 3600 );
		//line 152 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		int minsec = ( minutes * 60 );
		//line 153 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		long secs = ((long) (( ( hrssec + minsec ) + seconds )) );
		//line 154 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		boolean overflow = false;
		//line 156 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		if (( days > 0 )) 
		{
			//line 157 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			long sd = ((long) (( 86400 * days )) );
			//line 158 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			if (haxe.lang.Runtime.toBool(((java.lang.Boolean) (( ((long) (sd) ) < ((long) (days) ) )) ))) 
			{
				//line 159 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				overflow = true;
			}
			else
			{
				//line 160 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				if (haxe.lang.Runtime.toBool(((java.lang.Boolean) (( ((long) (secs) ) < ((long) (0) ) )) ))) 
				{
					//line 161 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					long temp = secs;
					//line 162 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					secs = ((long) (( ((long) (secs) ) + ((long) (sd) ) )) );
					//line 163 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					overflow = haxe.lang.Runtime.toBool(((java.lang.Boolean) (( ((long) (temp) ) > ((long) (secs) ) )) ));
				}
				else
				{
					//line 165 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					secs = ((long) (( ((long) (secs) ) + ((long) (sd) ) )) );
					//line 166 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					overflow = haxe.lang.Runtime.toBool(((java.lang.Boolean) (( ((long) (secs) ) < ((long) (0) ) )) ));
				}
				
			}
			
		}
		else
		{
			//line 168 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			if (( days < 0 )) 
			{
				//line 169 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				long sd1 = ((long) (( 86400 * days )) );
				//line 170 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				if (haxe.lang.Runtime.toBool(((java.lang.Boolean) (( ((long) (sd1) ) > ((long) (days) ) )) ))) 
				{
					//line 171 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					overflow = true;
				}
				else
				{
					//line 172 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (haxe.lang.Runtime.toBool(((java.lang.Boolean) (( ((long) (secs) ) <= ((long) (0) ) )) ))) 
					{
						//line 173 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						secs = ((long) (( ((long) (secs) ) + ((long) (sd1) ) )) );
						//line 174 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						overflow = haxe.lang.Runtime.toBool(((java.lang.Boolean) (( ((long) (secs) ) > ((long) (0) ) )) ));
					}
					else
					{
						//line 176 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						long nanos = secs;
						//line 177 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						secs = ((long) (( ((long) (secs) ) + ((long) (sd1) ) )) );
						//line 178 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						overflow = haxe.lang.Runtime.toBool(((java.lang.Boolean) (( ((long) (secs) ) > ((long) (nanos) ) )) ));
					}
					
				}
				
			}
			
		}
		
		//line 182 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		if (overflow) 
		{
			//line 183 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			throw haxe.lang.HaxeException.wrap("Time::Span too big or too small");
		}
		
		//line 186 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		return secs;
	}
	
	
	public long seconds;
	
	public int nanoseconds;
	
	
	
	public double get_totalDays()
	{
		//line 112 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		return ( this.get_totalSeconds() / 86400 );
	}
	
	
	
	
	public double get_totalHours()
	{
		//line 121 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		return ( this.get_totalSeconds() / 3600 );
	}
	
	
	
	
	public double get_totalSeconds()
	{
		//line 130 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		return ( core.time.__TimeSpan.toFloat(this.seconds) + ( ((double) (this.nanoseconds) ) / 1000000000 ) );
	}
	
	
	@Override public java.lang.String toString()
	{
		//line 202 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		return ( ( ( "Seconds: " + (( "" + haxe.root.Std.string(((long) (this.seconds) )) )) ) + " Nanoseconds: " ) + this.nanoseconds );
	}
	
	
	@Override public double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		{
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			boolean __temp_executeDef1 = true;
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			switch (field.hashCode())
			{
				case -1081074357:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("nanoseconds")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						this.nanoseconds = ((int) (value) );
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return value;
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
			}
			
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			if (__temp_executeDef1) 
			{
				//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				return super.__hx_setField_f(field, value, handleProperties);
			}
			else
			{
				//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				throw null;
			}
			
		}
		
	}
	
	
	@Override public java.lang.Object __hx_setField(java.lang.String field, java.lang.Object value, boolean handleProperties)
	{
		//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		{
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			boolean __temp_executeDef1 = true;
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			switch (field.hashCode())
			{
				case -1081074357:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("nanoseconds")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						this.nanoseconds = ((int) (haxe.lang.Runtime.toInt(value)) );
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return value;
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case 1970096767:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("seconds")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						this.seconds = haxe.lang.Runtime.toLong(value);
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return value;
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
			}
			
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			if (__temp_executeDef1) 
			{
				//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				return super.__hx_setField(field, value, handleProperties);
			}
			else
			{
				//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				throw null;
			}
			
		}
		
	}
	
	
	@Override public java.lang.Object __hx_getField(java.lang.String field, boolean throwErrors, boolean isCheck, boolean handleProperties)
	{
		//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		{
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			boolean __temp_executeDef1 = true;
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			switch (field.hashCode())
			{
				case -1776922004:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("toString")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return ((haxe.lang.Function) (new haxe.lang.Closure(this, "toString")) );
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case 1970096767:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("seconds")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return this.seconds;
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case -1495103260:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("get_totalSeconds")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return ((haxe.lang.Function) (new haxe.lang.Closure(this, "get_totalSeconds")) );
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case -1081074357:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("nanoseconds")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return this.nanoseconds;
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case -1769827685:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("totalSeconds")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return this.get_totalSeconds();
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case -577765957:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("totalDays")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return this.get_totalDays();
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case -1946592588:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("get_totalHours")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return ((haxe.lang.Function) (new haxe.lang.Closure(this, "get_totalHours")) );
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case -62925806:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("get_totalDays")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return ((haxe.lang.Function) (new haxe.lang.Closure(this, "get_totalDays")) );
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case -726768085:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("totalHours")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return this.get_totalHours();
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
			}
			
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			if (__temp_executeDef1) 
			{
				//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				return super.__hx_getField(field, throwErrors, isCheck, handleProperties);
			}
			else
			{
				//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				throw null;
			}
			
		}
		
	}
	
	
	@Override public double __hx_getField_f(java.lang.String field, boolean throwErrors, boolean handleProperties)
	{
		//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		{
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			boolean __temp_executeDef1 = true;
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			switch (field.hashCode())
			{
				case -1769827685:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("totalSeconds")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return this.get_totalSeconds();
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case -1081074357:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("nanoseconds")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return ((double) (this.nanoseconds) );
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case -726768085:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("totalHours")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return this.get_totalHours();
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case -577765957:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("totalDays")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return this.get_totalDays();
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
			}
			
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			if (__temp_executeDef1) 
			{
				//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				return super.__hx_getField_f(field, throwErrors, handleProperties);
			}
			else
			{
				//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				throw null;
			}
			
		}
		
	}
	
	
	@Override public java.lang.Object __hx_invokeField(java.lang.String field, java.lang.Object[] dynargs)
	{
		//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		{
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			boolean __temp_executeDef1 = true;
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			switch (field.hashCode())
			{
				case -1776922004:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("toString")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return this.toString();
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case -62925806:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("get_totalDays")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return this.get_totalDays();
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case -1495103260:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("get_totalSeconds")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return this.get_totalSeconds();
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
				case -1946592588:
				{
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					if (field.equals("get_totalHours")) 
					{
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						__temp_executeDef1 = false;
						//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
						return this.get_totalHours();
					}
					
					//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
					break;
				}
				
				
			}
			
			//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
			if (__temp_executeDef1) 
			{
				//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				return super.__hx_invokeField(field, dynargs);
			}
			else
			{
				//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
				throw null;
			}
			
		}
		
	}
	
	
	@Override public void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		baseArr.push("totalSeconds");
		//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		baseArr.push("totalHours");
		//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		baseArr.push("totalDays");
		//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		baseArr.push("nanoseconds");
		//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		baseArr.push("seconds");
		//line 68 "d:\\Workspace\\Core\\src\\core\\time\\TimeSpan.hx"
		super.__hx_getFields(baseArr);
	}
	
	
}

