package game.module.fish{
	
	import game.core.base.BaseModule;
	import game.core.enum.Module;
	import game.core.manager.PopupManager;
	import game.core.manager.SceneManager;
	import game.module.fish.enum.FishPopup;
	import game.module.fish.enum.FishScene;
	import game.module.fish.enum.FishSignal;
	import game.module.fish.popup.FishSetting;
	import game.module.fish.scene.FishHome;
	import game.core.manager.PopupManager;
	import game.module.fish.enum.FishPopup;
	import game.module.fish.popup.FishSetting;
	import game.module.fish.popup.FishHelp;
	import game.module.fish.utils.FishSound;
	import game.module.fish.popup.FishReward;

	/**
	 * chenyuan
	 */
	/*[COMPILER OPTIONS:ForcedCompile]*/
	public class FishModule extends BaseModule{
		
		public function FishModule(){
			super();
			PopupManager.reg(Module.FISH,FishPopup.REWARD,FishReward);
			PopupManager.reg(Module.FISH,FishPopup.HELP,FishHelp);
			PopupManager.reg(Module.FISH,FishPopup.SETUP,FishSetting);
			SceneManager.reg(Module.FISH,FishScene.FISHHOME,FishHome);
			var res:Array = FishConfig.INIT_SKINS;
			res = res.concat(FishSound.initSounds);
			init(res);
		}
		
		override public function onInit():void{
			super.onInit();
			FishModel.instance.once(FishSignal.START,this,start);
			FishModel.instance.init(dataSource);
		}
		
		private function start():void{
			SceneManager.enter(Module.FISH,FishScene.FISHHOME);
			super.initComplete();
		}
		
		override public function enter(data:*=null):void{
			super.enter(data);
		}
		
		override public function remove():void{
			super.remove();
		}
		
		override public function destroy(destroyChild:Boolean=true):void{
			super.destroy(destroyChild);
			FishModel.instance.destroy();
		}
	}
}