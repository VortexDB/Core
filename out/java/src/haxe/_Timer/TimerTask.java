// Generated by Haxe 4.0.0-preview.4+1e3e5e016
package haxe._Timer;

import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public class TimerTask extends java.util.TimerTask
{
	public TimerTask(haxe.Timer timer)
	{
		//line 195 "C:\\HaxeToolkit\\haxe\\std\\haxe\\Timer.hx"
		super();
		//line 196 "C:\\HaxeToolkit\\haxe\\std\\haxe\\Timer.hx"
		this.timer = timer;
	}
	
	
	public haxe.Timer timer;
	
	@Override public void run()
	{
		//line 200 "C:\\HaxeToolkit\\haxe\\std\\haxe\\Timer.hx"
		this.timer.run.__hx_invoke0_o();
	}
	
	
}


