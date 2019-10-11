package game.core.utils{
	
	import game.core.manager.ExternalManager;
	
	import laya.utils.Browser;
	import laya.wx.mini.MiniAdpter;

	/**
	 * chenyuan
	 */
	public class App{
		
		private static var maxMem:int = 0;
		public static var config:Object = {};
		
		public static function init():void{
			if(isMiniGame){
				MiniAdpter.init();
				config = Browser.window.appConfig;
				MiniAdpter.nativefiles = config.res;
				Browser.window.wx.onHide(function():void{
					Browser.window.wx.exitMiniProgram();
				});
			}else if(isApp){
				if(isIos){
					config = Browser.window.appConfig;
				}else if(isAndroid){
					config = JSON.parse(Browser.window.appConfig);
				}
				if(Browser.window.conchConfig){
					maxMem = Browser.window.conchConfig.getTotalMem()/1024;
				}
			}
		}
		
		/**是否APP**/
		public static function get isApp():Boolean{
			return isIos||isAndroid;
		}
		
		/**是否IOS**/
		public static function get isIos():Boolean{
			return Browser.window.appos=="ios";
		}
		
		/**是否ANDROID**/
		public static function get isAndroid():Boolean{
			return Browser.window.appos=="android";
		}
		
		/**是否IOS审核版本**/
		public static function get isIosCheck():Boolean{
			return isIos&&ExternalManager.getConfig("check")=="true";
		}
		
		/**是否微信小游戏**/
		public static function get isMiniGame():Boolean{
			return __JS__('window').appos=="minigame";
		}
		
		/**是否高内存**/
		public static function get isHighMem():Boolean{
			if(isApp) return maxMem==0||maxMem>=1000;
			return true;
		}
	}
}