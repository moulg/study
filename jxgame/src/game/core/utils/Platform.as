package game.core.utils{
	
	import game.core.manager.ExternalManager;
	
	import laya.utils.Browser;

	/**
	 * chenyuan
	 */
	public class Platform{
		
		/**GGame**/
		public static const GGAME:String = "GGAME";
		/**深游**/
		public static const SY:String = "SY";
		/**弹珠**/
		public static const DANZHU:String = "DANZHU";
		/**快娱**/
		public static const KUAIYU:String = "KUAIYU";
		/**广电**/
		public static const GUANGDIAN:String = "GUANGDIAN";
		/**MintParty**/
		public static const MINTPARTY:String = "MINTPARTY";
		/**演示**/
		public static const DEMO:String = "DEMO";
		/**金舜**/
		public static const JINSHUN:String = "JINSHUN";
		/**当前平台**/
		private static var _platform:String = JINSHUN;
		
		/**初始化平台**/
		public static function init():void{
			_platform = JINSHUN;
			var pf:String = ExternalManager.getConfig("pf");
			if(!pf) return;
			_platform = pf.toUpperCase();
			if(!isSSS&&!isDanzhu&&!isKuaiyu&&!isGuangDian&&!isMintparty&&!isDemo) _platform=JINSHUN;
		}
		
		/**当前平台**/
		public static function get platform():String{
			return _platform;
		}
		
		/**是否GGame**/
		public static function get isGGame():Boolean{
			return _platform==GGAME;
		}
		
		/**是否深游**/
		public static function get isSy():Boolean{
			return _platform==SY;
		}
		
		/**是否金舜十三水**/
		public static function get isSSS():Boolean{
			return isGGame||isSy;
		}
		
		/**是否弹珠**/
		public static function get isDanzhu():Boolean{
			return _platform==DANZHU;
		}
		
		/**是否广电**/
		public static function get isGuangDian():Boolean{
			return _platform==GUANGDIAN;
		}
		
		/**是否快娱**/
		public static function get isKuaiyu():Boolean{
			return _platform==KUAIYU;
		}
		
		/**是否MINTPARTY**/
		public static function get isMintparty():Boolean{
			return _platform==MINTPARTY;
		}
		
		/**是否演示**/
		public static function get isDemo():Boolean{
			return _platform==DEMO;
		}
		
		/**是否金舜**/
		public static function get isJinShun():Boolean{
			return _platform==JINSHUN;
		}
		
		/**是否金舜微信**/
		public static function get isJinShunWeiXin():Boolean{
			return isJinShun&&Browser.onWeiXin;
		}
		
		/**是否金舜网页**/
		public static function get isJinShunWeb():Boolean{
			return isJinShun&&!Browser.onWeiXin;
		}
	}
}