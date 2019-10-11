package game.core.enum{
	
	import game.core.vo.ModuleVo;

	/**
	 * chenyuan
	 */
	public class Module{
		
		/**模块配置**/
		private static var _configs:Object = {};
		/**公共模块**/
		public static const COMMON:String = "COMMON";
		/**游戏大厅**/
		public static const HALL:String = "HALL";
		/**抢红包**/
		public static const HB:String = "HB";
		/**捕鱼**/
		public static const FISH:String = "GAME_FISH";
		/**登录**/
		public static const LOGIN:String = "LOGIN";
		
		/**
		 * 初始化模块
		 */
		public static function init():void{
			reg(GameID.HALL,HALL,"游戏大厅","game.module.hall.HallModule","hall","hallui");
			reg(GameID.HB,HB,"抢红包","game.module.hb.HbModule","hb","hbui");
			reg(GameID.FISH,FISH,"捕鱼","game.module.fish.FishModule","fish","fishui");
			reg(GameID.LOGIN,LOGIN,"登录","game.module.login.LoginModule","login","loginui");
		}
		
		/**
		 * 注册配置
		 * @param moduleId 模块ID
		 * @param moduleName 模块名字
		 * @param className 执行的类名
		 * @param mainJsName 代码JS文件名
		 * @param resJsName 资源JS文件名
		 */
		private static function reg(gameId:int,moduleId:String,moduleName:String,className:String,mainJsName:String,resJsName:String=null):void{
			var vo:ModuleVo = new ModuleVo(gameId,moduleId,moduleName,className,mainJsName,resJsName);
			_configs[vo.moduleId] = vo;
		}
		
		/**
		 * 获取模块配置
		 * @param moduleId 模块ID
		 */
		public static function getConfig(moduleId:String):ModuleVo{
			return _configs[moduleId];
		}
		
		/**
		 * 通过游戏ID获取模块ID
		 * @param gameId 游戏ID
		 */
		public static function getModuleId(gameId:int):String{
			for(var moduleId:String in _configs){
				var vo:ModuleVo = _configs[moduleId];
				if(vo.gameId==gameId) return moduleId;
			}
			return null;
		}
		
		/**
		 * 通过模块ID获取游戏ID
		 * @param moduleId 模块ID
		 */
		public static function getGameId(moduleId:String):int{
			var vo:ModuleVo = getConfig(moduleId);
			if(vo) return vo.gameId;
			return -1;
		}
		
		/**
		 * 模块配置
		 */
		public static function get configs():Object{
			return _configs;
		}
	}
}