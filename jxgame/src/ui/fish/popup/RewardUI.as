/**Created by the LayaAirIDE,do not modify.*/
package ui.fish.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class RewardUI extends Dialog {
		public var aniNode:Image;
		public var score:FontClip;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1920,"mouseThrough":true,"height":1080},"child":[{"type":"Image","props":{"visible":false,"skin":"res/fish/image/bg1.jpg"}},{"type":"Image","props":{"y":540,"x":960,"var":"aniNode","mouseThrough":true}},{"type":"FontClip","props":{"y":620,"x":960,"var":"score","skin":"res/fish/textures/goldnum1.png","sheet":"0123456789","anchorY":0.5,"anchorX":0.5}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}