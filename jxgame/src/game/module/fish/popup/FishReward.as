package game.module.fish.popup{
	
	import game.core.utils.CoreHound;
	
	import ui.common.popup.ShopUI;
	import ui.fish.popup.RewardUI;
	import game.core.manager.EffectManager;
	import laya.utils.Handler;
	import laya.ani.bone.Skeleton;
	import game.module.fish.FishConfig;
	import game.core.manager.PopupManager;
	import game.module.fish.utils.FishSound;
	import laya.utils.Tween;
	import game.core.enum.Module;
	import game.module.fish.enum.FishPopup;

	public class FishReward extends RewardUI{
		
		private var _skAni:Skeleton = null;
		public function FishReward(){
			score.value = "";
			// scaleX = 1;
			// scaleY = 1;
		}
		override public function set dataSource(data:*):void{

			if(_skAni)_skAni.removeSelf();

			score.value = data.score+"";

			EffectManager.getSkeleton(data.url,Handler.create(this,function(sk:Skeleton):void{
				_skAni = sk;
				aniNode.addChild(sk);
				FishSound.effect("reward.mp3");
			}));

			// Tween.to(this,{scaleX:0,scaleX:0},100);

			frameOnce(120,this,function():void{
				if(_skAni)_skAni.removeSelf();
				PopupManager.close(Module.FISH,FishPopup.REWARD);
			});
		}
		override public function onClosed(type:String=null):void{
			super.onClosed(type);
		}
	}
}