package game.core.manager{
	
	import game.core.enum.GlobalEnum;
	import game.core.utils.Signal;
	import game.core.utils.Storage;
	import game.core.vo.SettingVo;
	
	import laya.media.SoundManager;
	import laya.utils.Handler;
	
	/**
	 * chenyuan
	 */
	public class AudioManager{
		
		private static var _data:SettingVo;
		private static var _isMusic:Boolean;
		private static var _isSound:Boolean;
		private static var _volume:Number = 0;
		private static var _musicUrl:String;
		
		public static function init():void{
			SoundManager.autoStopMusic = true;
			SoundManager.autoReleaseSound = false;
		}
		
		/**
		 * 启动模块音乐
		 * @param musicUrl 背景音乐地址
		 * @param musicVolume 背景音乐音量
		 */		
		public static function start(musicUrl:String=null,musicVolume:int=-1):void{
			reset();
			_musicUrl = musicUrl;
			_data = Storage.getSetting(ModuleManager.moduleId);
			_data.moduleId = ModuleManager.moduleId;
			if(musicVolume>=0) _data.musicVolume=musicVolume;
			render();
			Signal.event(GlobalEnum.MODULE_SOUND,_data);
		}
		
		/**
		 * 停止模块音乐
		 */		
		public static function reset():void{
			_data = null;
			_musicUrl = null;
			_isMusic = false;
			SoundManager.stopMusic();
			SoundManager.stopAllSound();
		}
		
		/**
		 * 更新模块设置
		 * @param data
		 */		
		public static function update(data:SettingVo):void{
			_data = data;
			Storage.updateSetting(ModuleManager.moduleId,data);
			render();
		}
		
		/**
		 * 停止背景音乐
		 */
		public static function stopMusic():void{
			if(!_isMusic||!_isSound) return;
			_volume = SoundManager.musicVolume;
			SoundManager.setMusicVolume(0);
		}
		
		/**
		 * 恢复背景音乐
		 */
		public static function replayMusic():void{
			if(!_isMusic||!_isSound||_volume==0) return;
			SoundManager.setMusicVolume(_volume);
		}
		
		private static function render():void{
			if(_data.musicOff){
				_isMusic = false;
				SoundManager.stopMusic();
			}else{
				if(!_isMusic&&_musicUrl){
					_isMusic = true;
					SoundManager.playMusic(_musicUrl);
				}
			}
			if(_data.soundOff){
				_isSound = false;
				SoundManager.stopAllSound();
			}else{
				_isSound = true;
			}
			SoundManager.setMusicVolume(_data.musicVolume/100);
			SoundManager.setSoundVolume(_data.soundVolume/100);
		}
		
		/**
		 * 最小化背景音量
		 */
		public static function minMusicVolume():void{
			if(!_isMusic||!_isSound) return;
			var cur:Number = SoundManager.musicVolume;
			var min:Number = 0.1;
			if(cur<=min) return;
			_volume = cur;
			function exec():void{
				cur = cur-0.05;
				if(cur<=min){
					Laya.timer.clear(null,exec);
					cur = min;
				}
				SoundManager.setMusicVolume(cur);
			}
			Laya.timer.loop(100,null,exec);
		}
		
		/**
		 * 恢复背景音量
		 */
		public static function resetMusicVolume():void{
			if(!_isMusic||!_isSound||_volume==0) return;
			var cur:Number = SoundManager.musicVolume;
			function exec():void{
				cur = cur+0.05;
				if(cur>=_volume){
					Laya.timer.clear(null,exec);
					cur = _volume;
					_volume = 0;
				}
				SoundManager.setMusicVolume(cur);
			}
			Laya.timer.loop(100,null,exec);
		}
		
		/**
		 * 播放音效
		 * @param url 音效地址
		 * @param loops 循环次数,0表示无限循环
		 */		
		public static function playSound(url:String,loops:int=1,handler:Handler=null):void{
			if(_isSound) SoundManager.playSound(url,loops,handler);
		}
		
		/**
		 * 停止音效
		 * @param url 音效地址
		 */		
		public static function stopSound(url:String):void{
			SoundManager.stopSound(url);
		}
		
		/**
		 * 获取模块设置
		 */		
		public static function get data():SettingVo{
			return _data;
		}
		
	}
}