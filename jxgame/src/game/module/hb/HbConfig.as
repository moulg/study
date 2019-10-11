package game.module.hb{
	
	import game.core.model.GlobalConfig;
	
	import laya.net.Loader;

	/**
	 * chenyuan
	 */
	public class HbConfig{	
		
		
		/**初始化资源**/
		public static const INIT_SKINS:Array = [
			{url:"res/hb/select.json",type:Loader.ATLAS},
			{url:"res/hb/desktop.json",type:Loader.ATLAS},
			{url:"res/hb/ui.json",type:Loader.ATLAS},
			{url:"res/hb/popup.json",type:Loader.ATLAS},
			{url:"res/hb/daojishi.json",type:Loader.ATLAS},
			{url:"res/hb/anniuguang.json",type:Loader.ATLAS},
			{url:"res/hb/ani/avatarAni.png",type:Loader.IMAGE},
			{url:"res/hb/ani/jiaose.png",type:Loader.IMAGE},
			{url:"res/hb/ani/saizi.png",type:Loader.IMAGE},
			{url:"res/hb/ani/youxikaishi.png",type:Loader.IMAGE},
			{url:"res/hb/ani/zzwnpp.png",type:Loader.IMAGE}
		];
		
		/**获取动画路径**/
		public static function getAniUrl(name:String):String{
			return "res/hb/ani/"+name+".json";
		}
		
		/**获取音效路径**/
		public static function getSoundUrl(name:String,isMusic:Boolean=false):String{
			return "res/hb/sound/"+name+GlobalConfig.getSoundExt(isMusic);
		}
		
		/**金币比例**/
		public static var goldrate:int;
	}
}