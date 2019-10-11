package game.core.manager{
	
	import game.core.enum.Module;
	import game.core.ui.Loading;
	import game.core.utils.Lang;
	
	import laya.ui.Dialog;
	import laya.utils.Handler;

	/**
	 * chenyuan
	 */
	public class PopupManager{
		
		private static var _popops:Object = {};
		private static var _loaded:Object = {};
		private static var _instances:Object = {};
		
		/**
		 * 注册窗口
		 * @param moduleId 模块ID
		 * @param popup 窗口名
		 * @param cls 窗口类
		 */		
		public static function reg(moduleId:String,popup:String,cls:*,res:Array=null):void{
			var name:String = moduleId+"&"+popup;
			if(!_popops[name]) _popops[name]=[cls,res];
		}
		
		/**
		 * 显示窗口 
		 * @param moduleId 模块ID
		 * @param popup 窗口名
		 * @param dataSource 数据
		 * @param closeOther 是否关闭其它
		 * @param isModal 是否模态
		 */		
		public static function open(moduleId:String,popup:String,dataSource:*=null,closeOther:Boolean=false,isModal:Boolean=true):void{
			if(moduleId!=ModuleManager.moduleId&&moduleId!=Module.COMMON) return;
			var name:String = moduleId+"&"+popup;
			function start():void{
				Loading.hide();
				_loaded[name] = true;
				var instance:Dialog = _instances[name];
				if(!instance){
					instance = new _popops[name][0];
					_instances[name] = instance;
				}
				if(!instance.isPopup){
					if(dataSource) instance.dataSource=dataSource;
					if(isModal){
						instance.popup(closeOther);
					}else{
						instance.show(closeOther);
					}
				}
			}
			if(_loaded[name]){
				start();
			}else{
				var res:Array = _popops[name][1];
				if(res&&res.length){
					Loading.show(Lang.text("loading"));
					Laya.loader.load(res,Handler.create(null,start));
				}else{
					start();
				}
			}
		}
		
		/**
		 * 关闭窗口
		 * @param moduleId 模块ID
		 * @param popup 窗口名
		 * @param type 类型
		 */		
		public static function close(moduleId:String,popup:String,type:String=null):void{
			var name:String = moduleId+"&"+popup;
			var instance:Dialog = _instances[name];
			if(instance&&instance.isPopup) instance.close(type);
		}
		
		/**
		 * 关闭所有窗口
		 */		
		public static function closeAll():void{
			Dialog.closeAll();
		}
		/**
		 * 根据组关闭所有弹出框
		 * @param	str 需要关闭的组名称
		 */	
		public static function closeByGroup(str:String):void{
			Dialog.closeByGroup(str);
		}
		
		/**
		 * 销毁窗口
		 * @param moduleId 模块ID
		 * @param popup 窗口名
		 */		
		public static function destroy(moduleId:String,popup:String):void{
			var name:String = moduleId+"&"+popup;
			var instance:Dialog = _instances[name];
			if(instance){
				instance.destroy();
				instance = null;
				delete _instances[name];
			}
		}
	}
}