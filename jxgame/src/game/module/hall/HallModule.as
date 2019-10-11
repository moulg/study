package game.module.hall{
	
	import game.core.base.BaseModule;
	import game.core.enum.GlobalEnum;
	import game.core.enum.Module;
	import game.core.manager.PopupManager;
	import game.core.manager.SceneManager;
	import game.module.hall.enum.HallPopup;
	import game.module.hall.enum.HallScene;
	import game.module.hall.enum.HallSignal;
	import game.module.hall.popup.HallSetUpView;
	import game.module.hall.scene.IndexView;
	import game.module.hall.utils.HallSound;
	
	/**
	 * chenyuan
	 */
	/*[COMPILER OPTIONS:ForcedCompile]*/
	public class HallModule extends BaseModule{
		
		public function HallModule(){
			isCache = true;
			
			PopupManager.reg(Module.HALL,HallPopup.SETUP,HallSetUpView);
			SceneManager.reg(Module.HALL,HallScene.INDEX,IndexView);
			var res:Array = HallConfig.INIT_SKINS;
			res = res.concat(HallSound.initSounds);
			init(res);
		}
		
		override public function onInit():void{
			super.onInit();
			HallModel.instance.once(HallSignal.START,this,start);
			HallModel.instance.init(dataSource);
		}
		
		private function start():void{
			SceneManager.enter(Module.HALL,HallScene.INDEX);
			super.initComplete();
		}
		
		override public function enter(data:*=null):void{
			super.enter(data);
			HallSound.init();
			if(data!=GlobalEnum.BACK){
				HallModel.instance.event(HallScene.RETURNHALL);
			}
		}
		
		override public function remove():void{
			super.remove();
		}
		
		override public function destroy(destroyChild:Boolean=true):void{
			super.destroy(destroyChild);
			HallModel.instance.destroy();
		}
	}
}