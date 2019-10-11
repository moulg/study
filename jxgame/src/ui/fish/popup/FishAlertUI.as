/**Created by the LayaAirIDE,do not modify.*/
package ui.fish.popup {
	import laya.ui.*;
	import laya.display.*; 
	import laya.display.Text;

	public class FishAlertUI extends View {
		public var closeLayer:Sprite;
		public var close:Image;
		public var closeBtn:Image;
		public var enterBtn:Image;
		public var text:Text;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1920,"height":1080},"child":[{"type":"Image","props":{"y":0,"x":0,"visible":false,"skin":"res/fish/image/bg1.jpg"}},{"type":"Sprite","props":{"y":0,"x":0,"width":1920,"var":"closeLayer","height":1080}},{"type":"Image","props":{"y":222,"x":551,"width":813,"skin":"res/fish/textures/top.png","sizeGrid":"19,16,0,14","mouseEnabled":true,"height":102}},{"type":"Image","props":{"y":273,"x":1313,"var":"close","skin":"res/fish/textures/close.png","anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":237,"x":865,"skin":"res/fish/textures/titletip.png"}},{"type":"Image","props":{"y":322,"x":550,"width":815,"skin":"res/fish/textures/panel1.png","sizeGrid":"0,230,105,263","height":465}},{"type":"Image","props":{"y":336,"x":575,"width":760,"skin":"res/fish/textures/panel2.png","sizeGrid":"18,18,18,19","height":294}},{"type":"Image","props":{"y":698,"x":754,"var":"closeBtn","skin":"res/fish/textures/btncancel.png","anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":698,"x":1166,"var":"enterBtn","skin":"res/fish/textures/btnsure.png","anchorY":0.5,"anchorX":0.5}},{"type":"Text","props":{"y":371,"x":601,"wordWrap":true,"width":698,"var":"text","leading":20,"height":231,"fontSize":40,"font":"Microsoft YaHei","color":"#8dd0e1","align":"center"}}]};
		override protected function createChildren():void {
			View.regComponent("Text",Text);
			super.createChildren();
			createView(uiView);

		}

	}
}