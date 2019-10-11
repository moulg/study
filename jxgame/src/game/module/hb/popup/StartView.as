package game.module.hb.popup{
	import game.core.manager.EffectManager;
	import game.module.hb.HbConfig;
	
	import laya.ani.bone.Skeleton;
	import laya.utils.Handler;
	
	import ui.hb.popup.StartUI;

	/**
	 * liuhe
	 */
	public class StartView extends StartUI{
		public function StartView(){
			group="hbProcedure";
			EffectManager.getSkeleton(HbConfig.getAniUrl("youxikaishi"),Handler.create(this,function(sk:Skeleton):void{
				sk.x = 300;
				sk.y = 200;
				addChild(sk);
			}));
		}
	}
}