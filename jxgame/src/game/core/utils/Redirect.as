package game.core.utils{
	
	import game.core.enum.GameID;
	import game.core.enum.GlobalEnum;
	import game.core.enum.Module;
	import game.core.manager.ExternalManager;
	import game.core.manager.ModuleManager;
	import game.core.model.GlobalModel;
	import game.core.ui.Toast;

	/**
	 * chenyuan
	 */
	public class Redirect{
		
		private static var _isSingle:Boolean;
		
		/**初始化进入**/
		public static function start():void{
			var gameId:int = parseInt(ExternalManager.getConfig("game"));
			if(isNaN(gameId)) gameId=GameID.HALL;
			if(gameId==GameID.HALL){
				_isSingle = false;
				hall(null,true);
			}else{
				_isSingle = true;
				game(gameId,false,false,false);
			}
		}
		
		/**模块**/
		public static function enter(moduleId:String):void{
			ModuleManager.enter(moduleId);
		}
		
		/**
		 * 登录
		 * @param isClear 是否清除上次登录状态
		 */		
		public static function login(isClear:Boolean=false):void{
			ModuleManager.enter(Module.LOGIN,isClear,null,false);
		}
		
		/**返回**/
		public static function back():void{
			hall(GlobalEnum.BACK);
		}
		
		/**商城**/
		public static function store():void{
			if(ModuleManager.moduleId==Module.HALL) Signal.event(GlobalEnum.STORE,1);
			else hall(GlobalEnum.STORE);
		}
		
		/**大厅**/
		public static function hall(dataSource:*=null,isLoading:Boolean=true):void{
			if(_isSingle){
				ExternalManager.exit();
				return;
			}
			ModuleManager.enter(Module.HALL,dataSource,false,isLoading);
		}
		
		/**
		 * 游戏 
		 * @param gameId 游戏ID
		 * @param dataSource 数据
		 * @return 是否进入
		 */		
		public static function game(gameId:int,dataSource:Boolean=false,isCheck:Boolean=true,isLoading:Boolean=true):Boolean{
			if(isCheck&&!GlobalModel.instance.hasEnterGame(gameId)){
				return false;
			}
			var moduleId:String = Module.getModuleId(gameId);
			if(moduleId){
				ModuleManager.enter(moduleId,dataSource,false,isLoading);
				return true;
			}
			Toast.error("游戏暂未开放");
			return false;
		}
	}
}