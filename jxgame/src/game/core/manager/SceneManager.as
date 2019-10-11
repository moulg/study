package game.core.manager{
	
	import laya.ui.View;

	/**
	 * chenyuan
	 */
	public class SceneManager{
		
		private static var _scenes:Object = {};
		private static var _instances:Object = {};
		
		/**
		 * 注册场景
		 * @param moduleId 模块ID
		 * @param scene 场景名
		 * @param cls 场景类
		 */		
		public static function reg(moduleId:String,scene:String,cls:*):void{
			var name:String = moduleId+"&"+scene;
			if(!_scenes[name]) _scenes[name]=cls;
		}
		
		/**
		 * 进入场景 
		 * @param moduleId 模块ID
		 * @param scene 场景名
		 * @param dataSource 数据
		 * @param destroyCurrent 是否销毁当前场景
		 */		
		public static function enter(moduleId:String,scene:String,dataSource:*=null,destroyCurrent:Boolean=false):void{
			if(moduleId!=ModuleManager.moduleId) return;
			var name:String = moduleId+"&"+scene;
			var last:String = ModuleManager.instance.sceneName;
			if(last!=name){
				var instance:View = _instances[name];
				if(!instance){
					instance = new _scenes[name];
					_instances[name] = instance;
				}
				if(dataSource) instance.dataSource=dataSource;
				ModuleManager.instance.addChild(instance);
				if(last){
					var arr:Array = last.split("&");
					remove(arr[0],arr[1],destroyCurrent);
				}
				ModuleManager.instance.sceneName = name;
			}
		}
		
		/**
		 * 移除场景
		 * @param moduleId 模块ID
		 * @param scene 场景名
		 * @param destroy 是否销毁
		 */		
		public static function remove(moduleId:String,scene:String,destroy:Boolean=false):void{
			if(moduleId!=ModuleManager.moduleId) return;
			var name:String = moduleId+"&"+scene;
			var instance:View = _instances[name];
			if(instance){
				instance.removeSelf();
				if(destroy){
					instance.destroy();
					instance = null;
					delete _instances[name];
				}
			}
		}
		
		/**
		 * 销毁模块所有场景
		 * @param moduleId 模块ID
		 */		
		public static function destroy(moduleId:String):void{
			for(var name:String in _instances){
				if(name.indexOf(moduleId+"&")==0){
					var instance:View = _instances[name];
					instance.removeSelf();
					instance.destroy();
					instance = null;
					delete _instances[name];
				}
			}
		}
	}
}