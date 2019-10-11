package game.module.hb{
	
	import game.core.base.BaseModule;
	import game.core.enum.Module;
	import game.core.manager.PopupManager;
	import game.core.manager.SceneManager;
	import game.module.hb.enum.HbPopup;
	import game.module.hb.enum.HbScene;
	import game.module.hb.enum.HbSignal;
	import game.module.hb.popup.HelpView;
	import game.module.hb.popup.MatchingView;
	import game.module.hb.popup.RecordView;
	import game.module.hb.popup.RestView;
	import game.module.hb.popup.RuleAgreeView;
	import game.module.hb.popup.RuleConfirmView;
	import game.module.hb.popup.RuleSelectView;
	import game.module.hb.popup.HbSetUpView;
	import game.module.hb.popup.SlugMoneyView;
	import game.module.hb.popup.StartView;
	import game.module.hb.scene.Control;
	import game.module.hb.utils.HbSound;

	/**
	 * chenyuan
	 */
	/*[COMPILER OPTIONS:ForcedCompile]*/
	public class HbModule extends BaseModule{
		
	   public function HbModule(){
			PopupManager.reg(Module.HB,HbPopup.HELP,HelpView);
			PopupManager.reg(Module.HB,HbPopup.RECORD,RecordView);
			PopupManager.reg(Module.HB,HbPopup.SETUP,HbSetUpView);
			PopupManager.reg(Module.HB,HbPopup.MATCHING,MatchingView);
			PopupManager.reg(Module.HB,HbPopup.START,StartView);
			PopupManager.reg(Module.HB,HbPopup.REST,RestView);
			PopupManager.reg(Module.HB,HbPopup.RULEAGREE,RuleAgreeView);
			PopupManager.reg(Module.HB,HbPopup.RULESELECT,RuleSelectView);
			PopupManager.reg(Module.HB,HbPopup.RULECONFIRM,RuleConfirmView);
			PopupManager.reg(Module.HB,HbPopup.SLUGMONEY,SlugMoneyView);
			SceneManager.reg(Module.HB,HbScene.CONTROL,Control);
			var res:Array = HbConfig.INIT_SKINS;
			res = res.concat(HbSound.initSounds);
			init(res);
		}
		
		override public function onInit():void{
			super.onInit();
			HbModel.instance.once(HbSignal.START,this,start);
			HbModel.instance.init(dataSource);
		}
		
		private function start():void{
			SceneManager.enter(Module.HB,HbScene.CONTROL);
			super.initComplete();
		}
		
		override public function enter(data:*=null):void{
			super.enter(data);
			HbSound.init();
		}
		
		override public function remove():void{
			super.remove();
		}
		
		override public function destroy(destroyChild:Boolean=true):void{
			super.destroy(destroyChild);
			HbModel.instance.destroy();
		}
	}
}