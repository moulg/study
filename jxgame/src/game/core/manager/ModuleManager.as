package game.core.manager{
	
	import game.core.base.BaseModule;
	import game.core.enum.GlobalEnum;
	import game.core.enum.Module;
	import game.core.model.GlobalConfig;
	import game.core.ui.ModuleLoad;
	import game.core.utils.App;
	import game.core.utils.Layer;
	import game.core.utils.Signal;
	import game.core.vo.ModuleVo;
	
	import laya.utils.Browser;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;

	/**
	 * chenyuan
	 */
	public class ModuleManager{
		
		private static var _moduleId:String;
		private static var _instance:BaseModule;
		private static var _modules:Object = {};
		private static var _instances:Object = {};
		private static var _isEnter:Boolean = false;
		
		/**
		 * 进入模块 
		 * @param moduleId 模块ID
		 * @param dataSource 数据
		 * @param isEffect 是否显示效果
		 * @param isLoading 是否显示加载动画
		 */		
		public static function enter(moduleId:String,dataSource:*=null,isEffect:Boolean=false,isLoading:Boolean=true):void{
			if(_moduleId==moduleId) return;
			PopupManager.closeAll();
			function toggle(cur:BaseModule,old:BaseModule,isLoad:Boolean):void{
				if(isLoad&&!_isEnter){
					_isEnter = true;
					Signal.event(GlobalEnum.MODULE_COMPLETE,moduleId);
				}
				if(cur.isInit){
					Layer.module.addChild(cur);
					if(old){
						if(isEffect){
							cur.x = GlobalConfig.GAME_WIDTH;
							Tween.to(cur,{x:0},100,Ease.backOut);
							Tween.to(old,{x:-GlobalConfig.GAME_WIDTH},100,Ease.backOut);
							Laya.timer.once(120,null,function():void{
								remove(old);
							});
						}else{
							remove(old);
						}
					}
				}else{
					cur.once(GlobalEnum.MODULE_COMPLETE,null,toggle,[cur,old,true]);
				}
			}
			function start():void{
				_moduleId = moduleId;
				var instance:BaseModule = _instances[moduleId];
				if(!instance){
					instance = new _modules[moduleId];
					instance.moduleId = moduleId;
					_instances[moduleId] = instance;
				}
				instance.dataSource = dataSource;
				toggle(instance,_instance,false);
				_instance = instance;
			}
			if(isLoading) ModuleLoad.show();
			if(_modules[moduleId]){
				start();
			}else{
				loadModule(moduleId,start);
			}
		}
		
		private static function loadModule(moduleId:String,cb:Function):void{
			var obj:ModuleVo = Module.getConfig(moduleId);
			function complete():void{
				_modules[moduleId] = getClass(obj.className);
				cb();
			}
			if(!GlobalConfig.IS_MODULE_LOAD||App.isMiniGame){
				complete();
				return;
			}
			var arr:Array = [getJs(obj.mainJsName)];
			if(obj.resJsName) arr.unshift(getJs(obj.resJsName));
			function exec(data:String):void{
				if(data){
					__JS__('var script=document.createElement("script");');
					__JS__('script.type="text/javascript";');
					__JS__('script.text=data;');
					__JS__('document.body.appendChild(script);');
				}
				load();
			}
			function load():void{
				if(arr&&arr.length){
					Laya.loader.load(arr.shift(),Handler.create(null,exec));
				}else{
					complete();
				}
			}
			load();
		}
		
		private static function remove(instance:BaseModule):void{
			if(instance){
				instance.remove();
				instance.removeSelf();
				if(!instance.isCache){
					SceneManager.destroy(instance.moduleId);
					delete _instances[instance.moduleId];
					instance.destroy();
					instance = null;
				}
			}
		}
		
		private static function getJs(name:String):String{
			return "js/"+name+".js";
		}
		
		private static function getClass(name:String):Class{
			var obj:* = Browser.window;
			var arr:Array = name.split(".");
			while(arr&&arr.length){
				obj = obj[arr.shift()];
			}
			return obj;
		}
		
		/**
		 * 当前模块ID
		 */		
		public static function get moduleId():String{
			return _moduleId;
		}
		
		/**
		 * 当前模块实例
		 */		
		public static function get instance():BaseModule{
			return _instance;
		}
	}
}