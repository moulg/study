package game.core.base{
	
	import game.core.enum.GlobalEnum;
	import game.core.enum.Module;
	import game.core.manager.ModuleManager;
	import game.core.utils.Signal;
	import game.core.utils.WS;
	
	import laya.events.EventDispatcher;

	/**
	 * chenyuan
	 */
	public class BaseModel extends EventDispatcher{
		
		private var _moduleId:String;
		
		public function BaseModel(){
			
		}
		
		/**
		 * 初始化，必须在子类里调用
		 */		
		public function init(data:*=null):void{
			_moduleId = ModuleManager.moduleId;
			Signal.on(GlobalEnum.MODULE_MESSAGE,this,onModuleMessage);
		}
		
		private function onModuleMessage(data:Object):void{
			var mod:String = String(data.mod).toUpperCase();
			if(_moduleId==mod) onMessage(data);
		}
		
		/**
		 * 模块接受数据，在子类里实现
		 * @param data
		 */		
		protected function onMessage(data:Object):void{
			
		}
		
		/**
		 * 发送数据到接口
		 * @param type 接口地址
		 * @param data 发送数据
		 * @param cb 回调
		 */		
		public function send(type:String,data:Object=null,cb:Function=null):void{
			if(WS.send(type,data,cb)==0) console.error("ws send error");
		}
		
		/**
		 * 模块ID 
		 */		
		public function get moduleId():String{
			return _moduleId;
		}
		
		/**
		 * 游戏ID 
		 */		
		public function get gameId():int{
			return Module.getGameId(moduleId);
		}
		
		/**
		 * 被销毁时被调用
		 */		
		public function destroy():void{
			Signal.off(GlobalEnum.MODULE_MESSAGE,this,onModuleMessage);
			offAll();
		}
	}
}