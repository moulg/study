package game.core.ui
{
	import game.core.enum.Module;
	import game.core.manager.ModuleManager;
	import game.core.model.GlobalConfig;
	import game.core.utils.Layer;
	
	import ui.common.ui.ModuleLoadUI;
	
	public class ModuleLoad extends ModuleLoadUI{
		
		private static var loadI:int=50;
		
		private static var _ui:ModuleLoadUI;
		
		
		/**
		 * 显示加载
		 * @param msg 加载消息
		 * @param time 定时关闭时间(默认不关闭,单位ms)
		 */		
		public static function show():void{
			if(!_ui) _ui=new ModuleLoadUI();
			_ui.load.x=0;
			Layer.moduleLoad.addChild(_ui);
			Laya.timer.frameLoop(20,null,onLoad1);
			Laya.stage.size(GlobalConfig.GAME_WIDTH,GlobalConfig.GAME_HEIGHT);
		}
		
		private static function onLoad1():void{
			_ui.load.x+=loadI;
			if(_ui.load.x>=800){
				Laya.timer.clear(null,onLoad1);
			}
		}
		/**
		 * 移除加载
		 */		
		public static function hide():void{
			if(!_ui) _ui=new ModuleLoadUI();
			_ui&&_ui.removeSelf();
			Laya.timer.clearAll(onLoad1);
			if(ModuleManager.moduleId==Module.FISH){
				Laya.stage.size(1920,1080);
			}
		}
	}
}