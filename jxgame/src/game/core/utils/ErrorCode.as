package game.core.utils{
	
	/**
	 * chenyuan
	 */
	public class ErrorCode{
		
		public static const PAY:int = 10109;
		
		public static function pay(data:Object):void{
			
		}
		
		public static function getMsg(code:int):String{
			var str:String = Lang.text(code.toString());
			if(!str||!str.length) str="ERROR:"+code;
			return str;
		}
	}
}