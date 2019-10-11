package game.core.utils{
	
	import laya.events.EventDispatcher;
	
	/**
	 * chenyuan
	 */
	public class Signal{
		
		private static var _dispatcher:EventDispatcher = new EventDispatcher();
		
		public static function event(type:String,data:*=null):Boolean{
			return _dispatcher.event(type,data);
		}
		
		public static function on(type:String,caller:*,listener:Function,args:Array=null):EventDispatcher{
			return _dispatcher.on(type,caller,listener,args);
		}
		
		public static function once(type:String,caller:*,listener:Function,args:Array=null):EventDispatcher{
			return _dispatcher.once(type,caller,listener,args);
		}
		
		public static function off(type:String,caller:*,listener:Function,onceOnly:Boolean=false):EventDispatcher{
			return _dispatcher.off(type,caller,listener,onceOnly);
		}
		
		public static function offAll(type:String=null):EventDispatcher{
			return _dispatcher.offAll(type);
		}

		public static function listener(type:String,caller:*,listener:Function,args:Array,once:Boolean,offBefore:Boolean=true):EventDispatcher{
			return _dispatcher._createListener(type,caller,listener,args,once,offBefore);
		}
		
		public static function hasListener(type:String):Boolean{
			return _dispatcher.hasListener(type);
		}
		
		public static function isMouseEvent(type:String):Boolean{
			return _dispatcher.isMouseEvent(type);
		}
	}
}