package game.module.login.popup{
	
	import laya.utils.Handler;
	
	import ui.login.popup.AgreementUI;
	
	/**
	 *caoheyan 
	 */
	public class AgreementView extends AgreementUI{
		
		public function AgreementView(){
			super();
			Laya.loader.load("res/login/agreement.txt",Handler.create(this,onLoaded));
		}
		
		private function onLoaded(text:String):void{
			if(!text) return;
			agreement.vScrollBarSkin = null;
			agreement.vScrollBar.elasticBackTime = 100;
			agreement.vScrollBar.elasticDistance = 100;
			content.text = text;
		}
	}
}