package game.module.login.scene{
	import game.core.enum.GlobalEnum;
	import game.core.enum.Module;
	import game.core.manager.EffectManager;
	import game.core.manager.PopupManager;
	import game.core.utils.Auth;
	import game.core.utils.CoreHound;
	import game.core.utils.Redirect;
	import game.core.utils.Signal;
	import game.module.login.enum.LoginEnum;
	
	import laya.ani.bone.Skeleton;
	import laya.events.Event;
	import laya.utils.Handler;
	
	import ui.login.LoginUI;

	/**
	 * liuhe
	 */
	public class LoginView extends LoginUI{
		private var time:int;
		private var step:int;
		
		public function LoginView(){
			
			btnPhone.on(Event.CLICK,this,onPhone);
			btnAccount.on(Event.CLICK,this,onAccount);
			
			Signal.on(GlobalEnum.APP_WX_LOGIN,this,onWxLogin);
			Signal.on(GlobalEnum.MODULE_START,this,onStart);
			
				EffectManager.getSkeleton("res/login/ani/denglujiaose.json",Handler.create(this,function(sk:Skeleton):void{
					sk.x = 600;
					sk.y = 730;
					denglujiaose.addChild(sk);
				}));
				EffectManager.getSkeleton("res/login/ani/yanhua.json",Handler.create(this,function(sk:Skeleton):void{
					sk.x = 600;
					sk.y = 0;
					yanhua.addChild(sk);
				}));
		}
		
		private function onPhone():void{
			CoreHound.effect("button");
			PopupManager.open(Module.LOGIN,LoginEnum.PHONE);
		}
		
		private function onAccount():void{
			CoreHound.effect("button");
			PopupManager.open(Module.LOGIN,LoginEnum.ACCOUNT);
		}
		
		private function onWxLogin(code:String):void{
			Auth.instance.loginByWeixin(code);
		};
		
		private function onStart():void{
			Redirect.start();
		}
		
		override public function destroy(destroyChild:Boolean=true):void{
			super.destroy(destroyChild);
			Signal.off(GlobalEnum.APP_WX_LOGIN,this,onWxLogin);
			Signal.off(GlobalEnum.MODULE_START,this,onStart);
		}
	}
}