package game.module.hb.popup{
	import ui.hb.popup.RestUI;

	/**
	 * liuhe
	 */
	public class RestView extends RestUI{
		
		private var time:int;
		public function RestView(){
			group="hbProcedure";
		}
		override public function set dataSource(value:*):void{
			time=value/1000;
			timerNum.value=time+"";
			timerLoop(1000,this,onTimer);
		}
		
		private function onTimer():void{
			time--;
			if(time<10){
				timerNum.value="0"+time;
			}else{
				timerNum.value=""+time;
			}
			if(time<=0){
				close();
				clearTimer(this,onTimer);
			}
		}
	}
}