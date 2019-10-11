/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class RestUI extends Dialog {
		public var timerNum:FontClip;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":150,"height":150},"child":[{"type":"Image","props":{"y":0,"x":14,"skin":"res/hb/ui/rest1.png"}},{"type":"Image","props":{"y":115,"x":13,"skin":"res/hb/ui/rest2.png"}},{"type":"FontClip","props":{"y":39,"x":38,"var":"timerNum","value":"09","skin":"res/hb/ui/FontClip.png","sheet":"0123456789"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}