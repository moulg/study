package game.module.login.popup{
	import game.core.enum.Module;
	import game.core.manager.ExternalManager;
	import game.core.manager.PopupManager;
	import game.core.ui.Toast;
	import game.core.utils.Auth;
	import game.core.utils.CoreHound;
	import game.module.login.enum.LoginEnum;
	
	import laya.events.Event;
	import laya.utils.Handler;
	
	import ui.login.popup.PhoneUI;

	/**
	 * liuhe
	 */
	public class PhoneView extends PhoneUI
	{
		private var time:int=60;
		
		public function PhoneView(){
		
			btnAgree.on(Event.CLICK,this,onAgree);
			btnAgreement.on(Event.CLICK,this,onAgreement);
			btnKeyObtain.on(Event.CLICK,this,onKeyObtain);
			btnPhone.on(Event.CLICK,this,onPhone);
		}
		
		private function onKeyObtain():void{
			CoreHound.effect("button");
			if(time==60){
				if(phoneText.text==""){
					Toast.error("请输入手机号！");
				}else if(!isPhone(phoneText.text)){
					Toast.error("请输入正确的手机号码！");
				}else{
					timerLoop(1000,this,onTimer);
					btnKeyObtain.disabled=true;
					btnKeyObtain.label="("+time+")重新获取";
					sendCode(phoneText.text);
				}
			}
		}
		
		private function onAgreement():void{
			CoreHound.effect("button");
			PopupManager.open(Module.LOGIN,LoginEnum.AGREEMENT);
		}
		
		private function onAgree():void{
			CoreHound.effect("button");
			btnPhone.disabled = !btnAgree.selected;
		}
		
		
		private function onPhone():void{
			CoreHound.effect("button");
			if(phoneText.text==""){
				Toast.error("请输入手机号！");
			}else if(!isPhone(phoneText.text)){
				Toast.error("请输入正确的手机号码！");
			}else if(keyText.text==""){
				Toast.error("请输入验证码！");
			}else{
				loginByPhone(phoneText.text,keyText.text);
			}
		}
		
		/**微信登录**/
		private function onWeixin():void{
			ExternalManager.login();
		}
		
		private function onTimer():void{
			time--;
			btnKeyObtain.label="("+time+")重新获取";
			if(time==0){
				clearTimer(this,onTimer);
				btnKeyObtain.disabled=false;
				btnKeyObtain.label="获取验证码";
				time = 60;
			}
		}
		
		private function isPhone(str:String):Boolean{
			var myreg:RegExp = /^[1][3,4,5,7,8][0-9]{9}$/;
			return myreg.test(str);
		}
		
		private function sendCode(phone:String):void{
			Auth.instance.sendCode(phone,Handler.create(this,function(data:Object):void{
				
			}));
		};
		
		private function loginByPhone(phone:String,code:String):void{
			Auth.instance.loginByPhone(phone,code);
		};
		
		
	}
}