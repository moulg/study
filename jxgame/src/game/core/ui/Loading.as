package game.core.ui{
	
	import game.core.utils.Layer;
	
	import ui.common.ui.LoadingUI;

	/**
	 * chenyuan
	 */
	public class Loading{
		
		private static var _ui:LoadingUI;
		
		/**
		 * 显示加载
		 * @param msg 加载消息
		 * @param time 定时关闭时间(默认不关闭,单位ms)
		 */		
		public static function show(msg:String=null,time:int=0):void{
			if(!_ui) _ui=new LoadingUI();
			_ui.text.text = msg||"";
			Layer.loading.addChild(_ui);
			if(time>0) Laya.timer.once(time,null,hide);
		}
		
		/**
		 * 移除加载
		 */		
		public static function hide():void{
			_ui&&_ui.removeSelf();
		}
	}
}