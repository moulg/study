/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class MatchingUI extends Dialog {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":380,"height":100}};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}