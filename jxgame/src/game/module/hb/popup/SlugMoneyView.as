package game.module.hb.popup{
	import game.core.ui.Jinbi;
	import game.module.hb.HbModel;
	import game.module.hb.utils.HbSound;
	
	import laya.events.Event;
	import laya.utils.Handler;
	
	import ui.hb.popup.SlugMoneyUI;

	/**
	 * liuhe
	 */
	public class SlugMoneyView extends SlugMoneyUI{
		
		private var time:int;
		
		public function SlugMoneyView(){
			group="hbProcedure";
			btnOpen.on(Event.CLICK,this,onOpen);
		}
		
		override public function set dataSource(data:*):void{
			time=data.time/1000;
			openNum.text=time+"";
			timerLoop(1000,this,onTimer);
			if(data.iswin==1){
				noOpen.visible=false;
				open.visible=true;
				HbSound.effect("win")
				timerOnce(1500,this,onJinbi);
			}else{
				noOpen.visible=true;
				open.visible=false;
				HbSound.effect("lose");
			}
		}
		
		private function onTimer():void{
			time--;
			openNum.text=time+"";
			if(time<=0){
				close();
				clearTimer(this,onTimer);
			}
		}
		
		
		private function onOpen():void{
			HbSound.effect("button");
			HbModel.instance.tableMoney(Handler.create(this,function(data:Object):void{
				onJinbi();
			}));
		}
		
		private function onJinbi():void{
			HbSound.effect("jinbi");
			Jinbi.aniPlay();
			close();
		}
	}
}