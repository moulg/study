package game.module.hb.popup{
	import game.module.hb.utils.HbSound;
	
	import laya.events.Event;
	
	import ui.hb.popup.HelpUI;
	/**
	 * liuhe
	 */
	public class HelpView extends HelpUI{
		public function HelpView(){
			zOrder=9999;
			btnClose.on(Event.CLICK,this,onClose);
		}
		
		private function onClose():void{
			HbSound.effect("button");
			close();
		}
	}
}