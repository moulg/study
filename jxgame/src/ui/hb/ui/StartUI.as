/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class StartUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1280,"height":720}};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}