package game.module.login{
	
	import game.core.base.BaseModel;
	import game.core.model.GlobalModel;
	import game.core.utils.Storage;
	
	/**
	 * liuhe
	 */
	public class LoginModel extends BaseModel{
		
		private static var _instance:LoginModel;
		
		public function LoginModel(){
			
		}
		
		override public function init(data:*=null):void{
			super.init(data);
			var isClear:Boolean = Boolean(data);
			if(isClear) Storage.clear();
			GlobalModel.instance.reset();
		}
		
		override protected function onMessage(data:Object):void{
			
		}
		
		override public function destroy():void{
			super.destroy();
			_instance = null;
		}
		
		public static function get instance():LoginModel{
			if(!_instance) _instance=new LoginModel();
			return _instance;
		}
	}
}