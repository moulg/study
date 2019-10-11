package game.module.hb.utils{
	
	import game.core.manager.AudioManager;
	import game.module.hb.HbConfig;

	/**
	 * chenyuan
	 */
	public class HbSound{
		
		public static function init():void{
			AudioManager.start(getUrl("bg",true));
		}
		
		public static function effect(str:String):void{
			AudioManager.playSound(getUrl(str));
		}
		
		private static function getUrl(name:String,isMusic:Boolean=false):String{
			return HbConfig.getSoundUrl(name,isMusic);
		}
		
		public static function get initSounds():Array{
			var list:Array = [getUrl("bg",true)];
			var arr:Array = ["start","sieves","gold","jinbi","win","lose","button"];
			while(arr&&arr.length){
				list.push(getUrl(arr.shift()));
			}
			return list;
		}
	}
}