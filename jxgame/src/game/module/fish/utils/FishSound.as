package game.module.fish.utils{
	
	import game.core.manager.AudioManager;
	import game.module.fish.FishConfig;
	import laya.media.SoundManager;

	/**
	 * chenyuan
	 */
	public class FishSound{
		//背景音乐
		public static function init(index:int):void{
			var url:String = FishConfig.getBgSoundUrl(index);
			AudioManager.start(url);
		}
		//
		public static function effect(str:String):void{
			var url:String = FishConfig.getSoundUrl(str);
			AudioManager.playSound(url);
		}
		public static function get initSounds():Array{
			return [];
		}
	}
}