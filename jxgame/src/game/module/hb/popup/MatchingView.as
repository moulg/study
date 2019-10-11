package game.module.hb.popup{
	import game.core.manager.EffectManager;
	import game.module.hb.HbConfig;
	
	import laya.ani.bone.Skeleton;
	import laya.utils.Handler;
	
	import ui.hb.popup.MatchingUI;

	/**
	 * liuhe
	 */
	public class MatchingView extends MatchingUI{
		public function MatchingView(){
			group="hbProcedure";
			EffectManager.getSkeleton(HbConfig.getAniUrl("zzwnpp"),Handler.create(this,function(sk:Skeleton):void{
				sk.x = 180;
				sk.y = 30;
				addChild(sk);
			}));
		}
		
	}
}