package game.core.vo{
	/**
	 * chenyuan
	 */
	public class ModuleVo{
		
		public var gameId:int;
		public var moduleId:String;
		public var moduleName:String;
		public var className:String;
		public var mainJsName:String;
		public var resJsName:String;
		
		/**
		 * 模块配置
		 * @param gameId 游戏ID
		 * @param moduleId 模块ID
		 * @param moduleName 模块名字
		 * @param className 执行的类名
		 * @param mainJsName 代码JS文件名
		 * @param resJsName 资源JS文件名
		 */
		public function ModuleVo(gameId:int,moduleId:String,moduleName:String,className:String,mainJsName:String,resJsName:String=null){
			this.gameId = gameId;
			this.moduleId = moduleId;
			this.moduleName = moduleName;
			this.className = className;
			this.mainJsName = mainJsName;
			this.resJsName = resJsName;
		}
	}
}