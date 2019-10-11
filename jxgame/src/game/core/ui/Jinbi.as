package game.core.ui{
	import game.core.utils.Layer;
	
	import ui.common.ui.JinbiUI;
	
	/**
	 * liuhe
	 */
	public class Jinbi extends JinbiUI{
		
		private static var _ui:JinbiUI;
		public function Jinbi(){
			
		}
		
		/**
		 * 播放金币动画
		 * @param interval(可选) 动画播放的帧间隔时间
		 */	
		public static function aniPlay(interval:int=40):void{
			if(!_ui){
				_ui= new JinbiUI();
			}
			_ui.jinbiAni.interval=interval;
			_ui.jinbiAni.play();
			Layer.xiaojiang.addChild(_ui);
			Laya.timer.frameOnce(100,null,function():void{
				hide();
			});
		
		}
		/**
		 * 移除加载
		 */		
		public static function hide():void{
			_ui&&_ui.removeSelf();
		}
	}
}