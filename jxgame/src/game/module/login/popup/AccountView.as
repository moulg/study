package game.module.login.popup{
	import game.core.enum.Module;
	import game.core.manager.PopupManager;
	import game.core.model.GlobalConfig;
	import game.core.ui.Toast;
	import game.core.utils.Auth;
	import game.core.utils.CoreHound;
	import game.module.login.enum.LoginEnum;
	
	import laya.events.Event;
	
	import ui.login.popup.AccountUI;

	/**
	 * liuhe
	 */
	public class AccountView extends AccountUI{
		public function AccountView(){
			btnAgree.on(Event.CLICK,this,onAgree);
			btnAgreement.on(Event.CLICK,this,onAgreement);
			btnModify.on(Event.CLICK,this,onModify);
			btnRegister.on(Event.CLICK,this,onRegister);
			btnAccout.on(Event.CLICK,this,onAccout);
			automatic.on(Event.CLICK,this,onAutomatic);
		}
		
		private function onModify():void{
			CoreHound.effect("button");
			PopupManager.open(Module.LOGIN,LoginEnum.MODIFY);
		}
		
		private function onAutomatic():void{
			CoreHound.effect("button");
		}
		
		private function onRegister():void{
			CoreHound.effect("button");
			PopupManager.open(Module.LOGIN,LoginEnum.REGISTER);
		}
		
		private function onAccout():void{
			CoreHound.effect("button");
			if(!acountText.text){
				Toast.error("请输入账号");
			}else if(!passText.text){
				Toast.error("请输入密码");
			}else{
				GlobalConfig.isAutomatic=automatic.selected;
				Auth.instance.accountLogin(acountText.text,passText.text);
			}
		}
		
		private function onAgree():void{
			CoreHound.effect("button");
			btnAccout.disabled = !btnAgree.selected;
		}
		
		private function onAgreement():void{
			CoreHound.effect("button");
			PopupManager.open(Module.LOGIN,LoginEnum.AGREEMENT);
		}
	}
}