package game.module.hb.ui{
	
	import game.core.manager.EffectManager;
	import game.module.hb.HbConfig;
	import laya.ani.bone.Skeleton;
	import laya.utils.Handler;
	import ui.hb.ui.SievesUI;
	/**
	 * liuhe
	 */
	public class Sieves extends SievesUI{
		private var ani:Skeleton;
		public function Sieves(){
			
		}
		
		/**
		 * 设置骰子点数
		 * @param index 点数
		 */
		public function onSieves(index:int):void{
			sievesImg.visible=false;
			saizi.visible=true;
			sievesImg.skin="res/hb/ui/sieves"+index+".png";
			EffectManager.getSkeleton(HbConfig.getAniUrl("saizi"),Handler.create(this,function(sk:Skeleton):void{
				ani=sk;
				ani.pos(30,35);
				saizi.addChild(ani);
			}));
			timerOnce(1000,this,onTimer);
		}
		
		private function onTimer():void{
			sievesImg.visible=true;
			ani&&ani.destroy();
			saizi.visible=false;
		}
		
		/**隐藏骰子**/
		public function deleteSieves():void{
			ani&&ani.destroy();
			sievesImg.visible=false;
			saizi.visible=false;
		}
	}
}