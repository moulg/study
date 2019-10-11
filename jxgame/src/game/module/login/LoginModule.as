package game.module.login{
	
	import game.core.base.BaseModule;
	import game.core.enum.Module;
	import game.core.manager.PopupManager;
	import game.core.manager.SceneManager;
	import game.core.model.GlobalConfig;
	import game.module.login.enum.LoginEnum;
	import game.module.login.popup.AccountView;
	import game.module.login.popup.AgreementView;
	import game.module.login.popup.ModifyView;
	import game.module.login.popup.PhoneView;
	import game.module.login.popup.RegisterView;
	import game.module.login.scene.LoginView;
	import game.module.login.utils.LoginSound;
	
	import laya.net.Loader;

	/*[COMPILER OPTIONS:ForcedCompile]*/
	public class LoginModule extends BaseModule{
		
		public function LoginModule(){
			PopupManager.reg(Module.LOGIN,LoginEnum.AGREEMENT,AgreementView);
			PopupManager.reg(Module.LOGIN,LoginEnum.PHONE,PhoneView);
			PopupManager.reg(Module.LOGIN,LoginEnum.ACCOUNT,AccountView);
			PopupManager.reg(Module.LOGIN,LoginEnum.MODIFY,ModifyView);
			PopupManager.reg(Module.LOGIN,LoginEnum.REGISTER,RegisterView);
			SceneManager.reg(Module.LOGIN,LoginEnum.LOGIN,LoginView);
			var res:Array = [
				{url:"res/login/ui.json",type:Loader.ATLAS},
				{url:"res/login/ani/denglujiaose.png",type:Loader.IMAGE},
				{url:"res/login/ani/yanhua.png",type:Loader.IMAGE},
			];
			init(res);
		}
		
		/**获取音效路径**/
		public static function getSoundUrl(name:String,isMusic:Boolean=false):String{
			return "res/login/sound/"+name+GlobalConfig.getSoundExt(isMusic);
		}
		
		override public function onInit():void{
			super.onInit();
			LoginModel.instance.init(dataSource);
			SceneManager.enter(Module.LOGIN,LoginEnum.LOGIN);
			super.initComplete();
		}
		
		override public function enter(data:*=null):void{
			super.enter(data);
//			AudioManager.start();
			LoginSound.init();
		}
		
		override public function remove():void{
			super.remove();
		}
		
		override public function destroy(destroyChild:Boolean=true):void{
			super.destroy(destroyChild);
			LoginModel.instance.destroy();
		}
	}
}