/**Created by the LayaAirIDE,do not modify.*/
package ui.fish.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class FishHelpUI extends Dialog {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1920,"height":1080},"child":[{"type":"Image","props":{"y":0,"x":0,"visible":false,"skin":"res/fish/image/bg1.jpg"}},{"type":"Image","props":{"y":179,"x":320,"width":1295,"skin":"res/fish/textures/panel1.png","sizeGrid":"0,127,106,127","height":795}},{"type":"Image","props":{"y":78,"x":323,"width":1290,"skin":"res/fish/textures/top.png","sizeGrid":"0,19,0,19","height":102}},{"type":"Image","props":{"y":97,"x":873,"skin":"res/fish/textures/titlehelp.png"}},{"type":"Image","props":{"y":191,"x":346,"skin":"res/fish/textures/panel3.png"}},{"type":"Button","props":{"y":78,"x":1509,"stateNum":1,"skin":"res/fish/textures/close.png","name":"close"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}