package game.module.hall{
	
	import game.core.model.GlobalConfig;
	
	import laya.net.Loader;

	/**
	 * chenyuan
	 */
	public class HallConfig{
		
		/**初始化资源**/
		public static const INIT_SKINS:Array = [
			{url:"res/hall/home.json",type:Loader.ATLAS},
			{url:"res/hall/xingdian.json",type:Loader.ATLAS},
			{url:"res/hall/ani/jinxiujiaose.png",type:Loader.IMAGE}
		];
		
		/**获取动画路径**/
		public static function getAniUrl(name:String):String{
			return "res/hall/ani/"+name+".json";
		}
		
		/**获取音效路径**/
		public static function getSoundUrl(name:String,isMusic:Boolean=false):String{
			return "res/hall/sound/"+name+GlobalConfig.getSoundExt(isMusic);
		}
	}
}