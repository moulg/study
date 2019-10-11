package game.module.hb.popup{
	
	import game.module.hb.HbModel;
	import game.module.hb.utils.HbSound;
	
	import laya.events.Event;
	
	import ui.hb.popup.RuleConfirmUI;
	/**
	 * liuhe
	 */
	public class RuleConfirmView extends RuleConfirmUI{
		
		private var time:int;
		
		public function RuleConfirmView(){
			group="hbProcedure";
			btnBetting.on(Event.CLICK,this,onBetting);
		}
		
		override public function set dataSource(value:*):void{
			time=value/1000;
			timeNum.text=time+"";
			timerLoop(1000,this,onTimer);
			ruleText.text=HbModel.instance.ruleData.getRule;
		}
		
		private function onTimer():void{
			time--;
			timeNum.text=time+"";
			if(time<=0){
				close();
				clearTimer(this,onTimer);
			}
		}
		
		private function onBetting():void{
			HbSound.effect("button");
			HbModel.instance.tableOpen();
			close();
		}
	}
}