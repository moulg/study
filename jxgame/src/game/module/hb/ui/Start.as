package game.module.hb.ui{
	import game.core.manager.EffectManager;
	import game.module.hb.HbConfig;
	import laya.ani.bone.Skeleton;
	import laya.utils.Handler;
	import ui.hb.ui.StartUI;
	/**
	 * liuhe
	 */
	public class Start extends StartUI{
		private var ani:Skeleton;
		public function Start(){
			
		}
		public function isPlay(isP:Boolean):void{
			if(isP){
				EffectManager.getSkeleton(HbConfig.getAniUrl("youxikaishi"),Handler.create(this,function(sk:Skeleton):void{
					ani=sk;
					ani.x = 650;
					ani.y = 360;
					addChild(ani);
				}));
			}else{
				ani.stop();
				ani.destroy();
			}
		}
	}
}