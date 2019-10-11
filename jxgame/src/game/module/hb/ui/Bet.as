package game.module.hb.ui{
	import ui.hb.ui.BetUI;
	/**
	 * liuhe
	 */
	public class Bet extends BetUI{
		public function Bet(){
			
		}
		
		/**红包播放动画**/
		public function onMoneyAni():void{
			timerOnce(1300,this,function():void{
				moneyAni.visible=true;
				moneyAni.interval=100;
				moneyAni.play();
				timerOnce(500,this,function():void{
					moneyAni.visible=false;
					moneyAni.stop();
				})
					
			})
		}
	}
}