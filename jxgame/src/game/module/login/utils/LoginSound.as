package game.module.login.utils{
	import game.core.manager.AudioManager;
	import game.core.model.GlobalConfig;

	public class LoginSound{
		public static function init():void{
			AudioManager.start(getUrl("bg",true));
		}
		
		public static function effect(str:String):void{
			AudioManager.playSound(getUrl(str));
		}
		
		private static function getUrl(name:String,isMusic:Boolean=false):String{
			return GlobalConfig.getSoundUrl(name,isMusic);
		}
		
		public static function get initSounds():Array{
			var list:Array = [getUrl("bg",true)];
			var arr:Array = ["button"];
			while(arr&&arr.length){
				list.push(getUrl(arr.shift()));
			}
			return list;
		}
	}
}