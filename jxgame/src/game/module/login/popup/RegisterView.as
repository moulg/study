package game.module.login.popup{
	import game.core.ui.Toast;
	import game.core.utils.Auth;
	import game.core.utils.CoreHound;
	import game.module.login.LoginModel;
	import game.module.login.enum.LoginEnum;
	
	import laya.events.Event;
	import laya.utils.Handler;
	
	import ui.login.popup.RegisterUI;

	/**
	 * liuhe
	 */
	public class RegisterView extends RegisterUI{
		public function RegisterView(){
			btnConfirm.on(Event.CLICK,this,onConfirm);	
		}
		
		private function onConfirm():void{
			CoreHound.effect("button");
			if(!accountText.text){
				Toast.error("请输入账号");
			}else if(!psw1.text){
				Toast.error("请输入密码");
			}else if(!psw2.text){
				Toast.error("请输入重复密码");
			}else if(psw1.text!=psw2.text){
				Toast.error("两次密码输入不一样");
				psw1.text="";
				psw2.text="";
			}else{
				Auth.instance.accountAdd(accountText.text,psw1.text,Handler.create(this,function():void{
					accountText.text="";
					psw1.text="";
					psw2.text="";
					LoginModel.instance.event(LoginEnum.LOGIN);
				}));
			}
		}
	}
}