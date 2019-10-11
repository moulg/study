package game.module.hall{
	
	import game.core.base.BaseModel;
	import game.module.hall.enum.HallSignal;
	
	import laya.utils.Handler;

	/**
	 * chenyuan
	 */
	public class HallModel extends BaseModel{
		private static var _instance:HallModel;
		public function HallModel(){
			
		}
		
		override public function init(data:*=null):void{
			super.init(data);
			event(HallSignal.START);
		}

		// /**捕鱼列表**/
		// public function getRoomInfo(handler:Handler):void{
		// 	send("fish.roominfo",{},function(data:Array,code:int):void{
		// 		handler.runWith(data);
		// 	});
		// }
		
		override public function destroy():void{
			super.destroy();
		}
		
		public static function get instance():HallModel{
			if(!_instance) _instance=new HallModel();
			return _instance;
		}
	}
}