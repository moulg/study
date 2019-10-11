package game.core.utils{
	
	import laya.display.Sprite;

	/**
	 * chenyuan
	 */
	public class Layer{
		
		/**模块层**/
		public static var module:Sprite;
		/**特效层**/
		public static var ani:Sprite;
		/**弹容层**/
		public static var dialog:Sprite;
		/**小奖层**/
		public static var xiaojiang:Sprite;
		/**UI层**/
		public static var ui:Sprite;
		/**消息层**/
		public static var toast:Sprite;
		/**模块加载层**/
		public static var moduleLoad:Sprite;
		/**加载层**/
		public static var loading:Sprite;
		/**提示层**/
		public static var alert:Sprite;
		
		public static function init():void{
			module = createLayer();
			ani = createLayer();
			dialog = createLayer();
			xiaojiang = createLayer();
			ui = createLayer();
			toast = createLayer();
			moduleLoad=createLayer();
			loading = createLayer();
			alert = createLayer();
		}
		
		private static function createLayer(mouseEnabled:Boolean=true):Sprite{
			var layer:Sprite = new Sprite();
			layer.mouseEnabled = mouseEnabled;
			Laya.stage.addChild(layer);
			return layer;
		}
	}
}