package game.module.hb.popup{
	import game.core.manager.AudioManager;
	import game.core.vo.SettingVo;
	
	import laya.events.Event;
	import laya.utils.Handler;
	
	import ui.hb.popup.HbSetUpUI;
	
	/**
	 * liuhe
	 */
	public class HbSetUpView extends HbSetUpUI{
		
		private var _status:String;
		private var _data:SettingVo;
		
		public function HbSetUpView(){
			zOrder=9999;
			musicNum.changeHandler = Handler.create(this,onMusicNums,null,false);
			effectNum.changeHandler = Handler.create(this,onEffectNum,null,false);
			btnMusic.on(Event.CLICK,this,onMusic);
			btnEffect.on(Event.CLICK,this,onEffect);
		}
		
		
		override public function onOpened():void{
			_data = AudioManager.data;
			_status = JSON.stringify(_data);
			musicNum.value = _data.musicVolume;
			effectNum.value = _data.soundVolume;
			btnMusic.selected=_data.musicOff;
			btnEffect.selected=_data.soundOff;
		}
		
		private function onMusic():void{
			_data.musicOff = btnMusic.selected;
			voice();
		}
		
		private function onEffect():void{
			_data.soundOff = btnEffect.selected;
			voice();
		}
		
		private function onMusicNums():void{
			_data.musicVolume = musicNum.value;
			voice();
		}
		private function onEffectNum():void{
			_data.soundVolume = effectNum.value;
			voice();
		}
		
		private function voice():void{
			var status:String = JSON.stringify(_data);
			if(status!=_status){
				_status = status;
				AudioManager.update(_data);
			}
		}
		
	}
}