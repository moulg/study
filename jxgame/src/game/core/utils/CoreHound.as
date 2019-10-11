package game.core.utils
{
	import game.core.manager.AudioManager;
	import game.core.model.GlobalConfig;

	public class CoreHound{
		public static function effect(str:String):void{
			AudioManager.playSound(getUrl(str));
		}
		
		private static function getUrl(name:String,isMusic:Boolean=false):String{
			return GlobalConfig.getSoundUrl(name,isMusic);
		}
	}
}