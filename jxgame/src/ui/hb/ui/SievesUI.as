/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class SievesUI extends View {
		public var sievesImg:Image;
		public var saizi:Sprite;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":62,"height":72},"child":[{"type":"Image","props":{"y":0,"x":0,"visible":false,"var":"sievesImg","skin":"res/hb/ui/sieves1.png"}},{"type":"Sprite","props":{"y":0,"x":0,"width":62,"var":"saizi","skin":"res/hb/ui/sieves1.png","height":72}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}