package game.core.model{
	
	import game.core.utils.App;
	import game.core.utils.Lang;
	
	import laya.net.Loader;
	import laya.utils.Browser;
	
	/**
	 * chenyuan
	 */
	public class GlobalConfig{
		
		/**HTTP地址**/
//		public static var HTTP_HOST:String = "http://h5.45yu.com:5556";//外网服务器
//		public static var HTTP_HOST:String = "http://192.168.8.182:15538";//内网182
//		public static var HTTP_HOST:String = "http://192.168.8.181:15538";//内网181
//		public static var HTTP_HOST:String = "http://192.168.8.70:15538";//内网70
//		public static var HTTP_HOST:String = "http://122.114.237.127:15538";//外网127
//		public static var HTTP_HOST:String = "http://192.168.8.111:80";//黄
//		public static var HTTP_HOST:String = "http://192.168.8.29:80";//董
// 		public static var HTTP_HOST:String = "http://192.168.8.14:80";//戴
 		public static var HTTP_HOST:String = "http://192.168.8.22:15538";//柳
//		public static var HTTP_HOST:String = "http://abgames.45yu.com:5555";//苹果审核服
		
		/**测试ID(>0才有效)**/
		public static const TEST_ID:int = 0;
		
		/**游戏宽度**/
		public static const GAME_WIDTH:uint = 1280;
		
		/**游戏高度**/
		public static const GAME_HEIGHT:uint = 720;
		
		/**是否分模块加载**/
		public static const IS_MODULE_LOAD:Boolean = true;
		
		/**是否打印WS数据**/
		public static var IS_PRINT_WS:Boolean = false;
		
		/**金币比例**/
		public static var goldrate:int=100;
		
		/**是否自动登录**/
		public static var isAutomatic:Boolean = true;
		
		/**获取资源版本**/
		public static function getResVer():String{
			if(Browser.window.cfg&&Browser.window.cfg.resver) return Browser.window.cfg.resver+"/res.json";
			return null;
		}
		
		/**初始化资源**/
		public static const INIT_RES:Array = [
			{url:langUrl},
			{url:"res/common/ui.json",type:Loader.ATLAS},
			{url:"res/common/public.json",type:Loader.ATLAS},
			{url:"res/common/jinbi.json",type:Loader.ATLAS},
			{url:"res/common/gold.json",type:Loader.ATLAS},
			{url:"res/common/ani/shanxian.png",type:Loader.IMAGE}
		];
		
		/**语言包地址**/
		public static function get langUrl():String{
			return "res/common/lang"+Lang.lang+".json";
		}
		
		/**
		 * 获取默认头像
		 * @param type 0无 1男 2女
		 */		
		public static function getDefultFace(type:int=1):String{
			return "res/common/ui/face_"+type+".png";
		}
		
		/**获取动画路径**/
		public static function getAniUrl(name:String):String{
			return "res/common/ani/"+name+".json";
		}
		
		/**
		 * 获取道具特效
		 * @param itemId 道具ID
		 */
		public static function getItemAni(itemId:int):String{
			return "res/common/sk/"+itemId+".json";
		}
		
		/**获取音效路径**/
		public static function getSoundUrl(name:String,isMusic:Boolean=false):String{
			return "res/common/sound/"+name+getSoundExt(isMusic);
		}
		
		/**
		 * 获取音效文件后缀
		 * @param isMusic 是否背景音乐
		 */		
		public static function getSoundExt(isMusic:Boolean):String{
			return (App.isApp&&!isMusic)?".wav":".mp3";
		}
	}
}