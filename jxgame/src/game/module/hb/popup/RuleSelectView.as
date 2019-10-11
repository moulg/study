package game.module.hb.popup{
	import game.module.hb.HbModel;
	import game.module.hb.enum.HbSignal;
	import game.module.hb.utils.HbSound;
	
	import laya.events.Event;
	import laya.utils.Handler;
	
	import ui.hb.popup.RuleSelectUI;
	
	/**
	 * liuhe
	 */
	public class RuleSelectView extends RuleSelectUI{
		private var time:int;
		public function RuleSelectView(){
			group="hbProcedure";
			var arr:Array=HbModel.instance.ruleData.ruleList;
			ruleSelectList.array=[];
			for (var i:int = 0; i < arr.length; i++){
				ruleSelectList.array.push({explain:arr[i]});
			}
			
			ruleSelectList.hScrollBarSkin=null;
			ruleSelectList.selectEnable=true;
			ruleSelectList.scrollBar.elasticBackTime = 150;
			ruleSelectList.scrollBar.elasticDistance = 200;
			ruleSelectList.mouseHandler = Handler.create(this,onRuleSelectList, null, false);
		}
		
		private function onRuleSelectList(e:Event,index:int):void{
			if(e.type=="click"){
				HbSound.effect("button");
				HbModel.instance.tableSetrule({ruleid:index+1});
				HbModel.instance.event(HbSignal.CAN_JOIN);
				close();
			}
		}
		
		override public function set dataSource(value:*):void{
			time=value/1000;
			timeNum.text=time+"";
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
	}
}