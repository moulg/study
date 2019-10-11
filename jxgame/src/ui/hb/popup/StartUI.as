/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class StartUI extends Dialog {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":640,"mouseThrough":false,"height":360}};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}