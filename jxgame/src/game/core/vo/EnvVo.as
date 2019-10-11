package game.core.vo{
	
	import game.core.manager.ExternalManager;
	import game.core.utils.GlobalUtil;
	import game.core.utils.Platform;
	
	/**
	 * chenyuan
	 */
	public class EnvVo{
		
		/**HTTP**/
		public var http:String;
		/**HOST**/
		public var host:String;
		/**PORT**/
		public var port:int;
		/**TOKEN**/
		public var token:String;
		/**PLATFORM**/
		public var pf:String;
		
		public function EnvVo(){
			
		}
		
		public function setData(data:String):void{
			if(data&&data.length){
				var obj:Object = JSON.parse(data);
				GlobalUtil.serialize(this,obj);
			}
		}
		
		public function get isValid():Boolean{
			var h:String = ExternalManager.getQuery("host");
			return pf==Platform.platform&&(!h||h==http)&&token;
		}
		
		public function get isLogin():Boolean{
			return http&&host&&port&&token;
		}
	}
}