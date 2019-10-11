/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class GoldUI extends View {
		public var golds:Box;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":60,"height":60},"child":[{"type":"Box","props":{"y":0,"x":0,"visible":false,"var":"golds"},"child":[{"type":"Image","props":{"y":12,"x":5,"width":20,"skin":"res/common/public/gold.png","height":20}},{"type":"Image","props":{"y":14,"x":24,"width":20,"skin":"res/common/public/gold.png","height":20}},{"type":"Image","props":{"x":35,"width":20,"skin":"res/common/public/gold.png","height":20}},{"type":"Image","props":{"y":25,"x":22,"width":20,"skin":"res/common/public/gold.png","height":20}},{"type":"Image","props":{"y":36,"x":6,"width":20,"skin":"res/common/public/gold.png","height":20}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}