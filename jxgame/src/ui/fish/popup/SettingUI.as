/**Created by the LayaAirIDE,do not modify.*/
package ui.fish.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class SettingUI extends Dialog {
		public var btnMusic:CheckBox;
		public var btnEffect:CheckBox;
		public var musicNum:HSlider;
		public var effectNum:HSlider;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1920,"height":1080},"child":[{"type":"Image","props":{"visible":false,"skin":"res/fish/image/bg1.jpg"}},{"type":"Image","props":{"y":216,"x":310,"width":1295,"skin":"res/fish/textures/panel1.png","sizeGrid":"0,127,106,127","height":736}},{"type":"Image","props":{"y":114,"x":313,"width":1290,"skin":"res/fish/textures/top.png","sizeGrid":"0,19,0,19","height":102}},{"type":"Image","props":{"y":135,"x":865,"skin":"res/fish/textures/titlesetting.png"}},{"type":"Button","props":{"y":114,"x":1500,"stateNum":1,"skin":"res/fish/textures/close.png","name":"close"}},{"type":"Image","props":{"y":325,"x":1199,"skin":"res/fish/textures/titleeffic1.png"}},{"type":"Image","props":{"y":322,"x":531,"skin":"res/fish/textures/titlemusic1.png"}},{"type":"CheckBox","props":{"y":407,"x":496,"var":"btnMusic","skin":"res/fish/textures/checkbox_switch.png.png"}},{"type":"CheckBox","props":{"y":407,"x":1146,"var":"btnEffect","skin":"res/fish/textures/checkbox_switch.png.png"}},{"type":"Image","props":{"y":639,"x":442,"skin":"res/fish/textures/titlemusic.png"}},{"type":"HSlider","props":{"y":629,"x":600,"width":952,"var":"musicNum","value":100,"skin":"res/fish/textures/hslider.png","sizeGrid":"0,68,0,34","showLabel":false,"height":75}},{"type":"Image","props":{"y":764,"x":442,"skin":"res/fish/textures/titleeffic.png"}},{"type":"HSlider","props":{"y":753,"x":598,"width":952,"var":"effectNum","value":100,"skin":"res/fish/textures/hslider.png","sizeGrid":"0,68,0,34","showLabel":false,"height":75}},{"type":"Image","props":{"y":563,"x":330,"skin":"res/fish/textures/settingline.png"},"child":[{"type":"Image","props":{"y":4,"x":1270,"skin":"res/fish/textures/settingline.png","rotation":180}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}