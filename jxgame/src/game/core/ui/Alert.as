package game.core.ui{
	
	import game.core.manager.PopupManager;
	import game.core.utils.Layer;
	
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ui.Dialog;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	import ui.common.ui.AlertUI;

	/**
	 * chenyuan
	 */
	public class Alert{
		
		private static var _ui:AlertUI;
		private static var _mask:Sprite;
		private static var _callback:Handler;
		private static var _isLayerClose:Boolean;
		private static var _leading:Number;
		private static var _fontSize:int;
		private static var _enterBtnX:int;
		
		/**
		 * 提示框 
		 * @param msg 提示消息
		 * @param callback 回调(点击确定返回true,否则返回false)
		 * @param isShowClose 是否显示关闭按钮
		 * @param isLayerClose 是否可点击背景关闭
		 * @param isCloseOtherPopup 是否关闭其它弹窗
		 * @param isModal 是否模态
		 * @param fontSize 字体大小
		 * @param leading 垂直行间距
		 */		
		public static function show(msg:String,callback:Handler=null,isShowClose:Boolean=true,isLayerClose:Boolean=true,isCloseOtherPopup:Boolean=false,isModal:Boolean=true,fontSize:int=0,leading:Number=0):void{
			if(!_ui){
				_ui = new AlertUI();
				_ui.closeBtn.on(Event.CLICK,null,close,[Dialog.CLOSE]);
				_ui.enterBtn.on(Event.CLICK,null,close,[Dialog.OK]);
				_ui.closeLayer.on(Event.CLICK,null,close,[Dialog.CANCEL]);
				_leading = _ui.text.leading;
				_fontSize = _ui.text.fontSize;
				_enterBtnX=_ui.enterBtn.centerX;
			}
			_callback = callback;
			_isLayerClose = isLayerClose;
			_ui.closeBtn.visible = isShowClose;
			if(isShowClose){
				_ui.enterBtn.centerX=_enterBtnX;
			}else{
				_ui.enterBtn.centerX=0;
			}
			_ui.text.leading = leading||_leading;
			_ui.text.fontSize = fontSize||_fontSize;
			_ui.text.text = msg;
			var sw:int = Laya.stage.width;
			var sh:int = Laya.stage.height;
			if(isCloseOtherPopup) PopupManager.closeAll();
			if(isModal){
				if(!_mask){
					_mask = new Sprite();
					_mask.size(sw,sh);
					_mask.graphics.drawRect(0,0,_mask.width,_mask.height,UIConfig.popupBgColor);
					_mask.alpha = UIConfig.popupBgAlpha;
				}
				Layer.alert.addChild(_mask);
			}
			Layer.alert.addChild(_ui);
			_ui.x = Math.round(((sw-_ui.width)>>1)+_ui.pivotX);
			_ui.y = Math.round(((sh-_ui.height)>>1)+_ui.pivotY);
			_ui.scale(1,1);
			Tween.from(_ui,{x:sw/2,y:sh/2,scaleX:0,scaleY:0},300,Ease.backOut);
		}

		private static function close(type:String):void{
			if(!_isLayerClose&&type==Dialog.CANCEL) return;
			Tween.to(_ui,{x:Laya.stage.width/2,y:Laya.stage.height/2,scaleX:0,scaleY:0},300,Ease.strongOut,Handler.create(null,function():void{
				if(_callback) _callback.runWith(type==Dialog.OK);
				if(_mask) _mask.removeSelf();
				_ui.removeSelf();
			}));
		}
	}
}