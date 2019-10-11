package game.module.hb.popup{
	import game.module.hb.HbModel;
	import game.module.hb.enum.HbSignal;
	import game.module.hb.utils.HbSound;
	
	import laya.events.Event;
	
	import ui.hb.popup.RuleAgreeUI;
	
	/**
	 * liuhe
	 */
	public class RuleAgreeView extends RuleAgreeUI{
		
		private var time:int;
		
		public function RuleAgreeView(){
			group="hbProcedure";
			btnJoin.on(Event.CLICK,this,onJoin);
			btnCanJoin.on(Event.CLICK,this,onCanJoin);
		}
		override public function set dataSource(data:*):void{
			time=data.time/1000;
			timeNum.text=time+"";
			rulefee.text="参与竞选需要支付"+data.rulefee+"金币...";
			timerLoop(1000,this,onTimer);
		}
		
		private function onTimer():void{
			time--;
			timeNum.text=time+"";
			if(time<=0){
				close();
				clearTimer(this,onTimer);
			}
		}
		
		private function onJoin():void{
			tableGetrule(1);
		}
		private function onCanJoin():void{
			tableGetrule(-1);
			HbModel.instance.event(HbSignal.CAN_JOIN);
		}
		private function tableGetrule(index:int):void{
			HbSound.effect("button");
			HbModel.instance.tableGetrule({getrule:index});
			close();
		}
	}
}