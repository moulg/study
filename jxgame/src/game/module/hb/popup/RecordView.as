package game.module.hb.popup{
	import game.module.hb.HbModel;
	import game.module.hb.utils.HbSound;
	
	import laya.events.Event;
	
	import ui.hb.popup.RecordUI;
	/**
	 * liuhe
	 */
	public class RecordView extends RecordUI{
		public function RecordView(){
			zOrder=9999;
			recordList.vScrollBarSkin=null;
			recordList.selectEnable=true;
			recordList.scrollBar.elasticBackTime = 150;
			recordList.scrollBar.elasticDistance = 200;
			btnClose.on(Event.CLICK,this,onClose);
		}
		
		private function onClose():void{
			HbSound.effect("button");
			close();
		}
		override public function onOpened():void{
			recordList.array=HbModel.instance.ruleData.getResult;
		}
	}
}