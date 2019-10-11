package game.core.utils{
	
	import game.core.model.GlobalConfig;

	/**
	 * chenyuan
	 */
	public class Lang{
		
		/**简体版本**/
		public static const CN:String = "cn";
		/**英文版本**/
		public static const EN:String = "en";
		/**当前语言**/
		private static var _lang:String = CN;
		
		private static var _text:Object;
		
		public static function init():void{
			_lang = Platform.isMintparty?EN:CN;
		}
		
		public static function start():void{
			_text = Laya.loader.getRes(GlobalConfig.langUrl);
		}
		
		/**当前语言**/
		public static function get lang():String{
			return _lang;
		}
		
		/**是否英文**/
		public static function get isEn():Boolean{
			return _lang==EN;
		}
		
		/**获取语言包文本**/
		public static function text(key:String):String{
			return _text[key]||"";
		}
	}
}