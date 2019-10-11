package game.core.base{
	
	import game.core.enum.GlobalEnum;
	import game.core.ui.ModuleLoad;
	
	import laya.display.Sprite;
	import laya.utils.Handler;
	
	/**
	 * chenyuan
	 */
	public class BaseModule extends Sprite{
		
		private var _dataSource:*;
		private var _isInit:Boolean;
		
		/**模块ID**/
		public var moduleId:String;
		/**当前场景名**/
		public var sceneName:String;
		/**是否缓存不被销毁**/
		public var isCache:Boolean = false;
		public function BaseModule(){
			super();
		}
		
		/**
		 * 初始化模块，必须在子类里调用
		 * @param res 初始化资源，可以为空
		 */		
		public function init(res:Array=null):void{
			if(res&&res.length){
				Laya.loader.load(res,Handler.create(this,initHandler));
			}else{
				frameOnce(1,this,initHandler);
			}
		}
		
		private function initHandler():void{
			_isInit = true;
			onInit();
		}
		
		/**
		 * 初始化处理
		 */
		public function onInit():void{
			
		}
		
		/**
		 * 初始化完成
		 */
		public function initComplete():void{
			event(GlobalEnum.MODULE_COMPLETE,moduleId);
			enter(_dataSource);
			ModuleLoad.hide();
		}
		
		/**
		 * 进入模块时被调用
		 * @param data 携带的数据
		 */		
		public function enter(data:*=null):void{
			
		}
		
		/**
		 * 移除模块时被调用
		 */
		public function remove():void{
			
		}
		
		/**
		 * 是否初始化
		 */
		public function get isInit():Boolean{
			return _isInit;
		}
		
		public function set dataSource(value:*):void{
			_dataSource = value;
			if(_isInit){
				enter(_dataSource);
				ModuleLoad.hide();
			}
		}
		
		/**携带的数据**/
		public function get dataSource():*{
			return _dataSource;
		}
	}
}