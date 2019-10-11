package game.core.ui{
	
	import game.core.manager.ExternalManager;
	import game.core.model.GlobalConfig;
	import game.core.utils.Layer;
	
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	import ui.common.ui.ToastUI;

	/**
	 * chenyuan
	 */
	public class Toast{
		
		private static var _bg:Sprite;
		private static var _ui:ToastUI;
		
		/**
		 * 成功提示
		 * @param msg 消息
		 */		
		public static function success(msg:String):void{
			show(msg,"#FFFFFF");
		}
		
		/**
		 * 失败提示 
		 * @param msg 消息
		 */		
		public static function error(msg:String):void{
			show(msg,"#FFFFFF");
		}
		
		/**
		 * 自定义提示
		 * @param msg 消息
		 * @param color 颜色
		 * @param y Y轴位置
		 * @param delay 显示时间
		 * @param isLock 是否锁屏
		 * @param complete 完成回调
		 */
		public static function show(msg:String,color:String=null,y:int=-1,delay:int=1000,isLock:Boolean=false,complete:Handler=null):void{
			if(!ExternalManager.isStart){
				ExternalManager.error(msg);
				return;
			}
			if(!_ui){
				_ui = new ToastUI();
				_ui.x = (GlobalConfig.GAME_WIDTH-_ui.width)>>1;
				_ui.on(Event.RESIZE,null,onResize);
			}
			if(isLock){
				if(!_bg){
					_bg = new Sprite();
					_bg.mouseEnabled = true;
					_bg.size(GlobalConfig.GAME_WIDTH,GlobalConfig.GAME_HEIGHT);
				}
				Layer.toast.addChild(_bg);
			}
			var pos:int = y>-1?y:GlobalConfig.GAME_HEIGHT/2-88;
			_ui.y = pos+100;
			_ui.alpha = 0;
			_ui.text.text = msg;
			_ui.height=_ui.text.displayHeight+22;
			_ui.bg.height=_ui.height;
			_ui.text.color = color||"#A8A8F4";
			Layer.toast.addChild(_ui);
			Tween.clearAll(_ui);
			Tween.to(_ui,{y:pos,alpha:1},100);
			Tween.to(_ui,{y:pos-100,alpha:0},100,null,Handler.create(null,function():void{
				_ui.removeSelf();
				_bg&&_bg.removeSelf();
				complete&&complete.run();
			}),delay);
		}
		
		private static function onResize():void{
			//_ui.bg.height = _ui.text.height+35;
		}
	}
}