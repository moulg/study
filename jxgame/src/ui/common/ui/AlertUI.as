/**Created by the LayaAirIDE,do not modify.*/
package ui.common.ui {
	import laya.ui.*;
	import laya.display.*; 
	import laya.display.Text;

	public class AlertUI extends View {
		public var closeLayer:Sprite;
		public var text:Text;
		public var closeBtn:Button;
		public var enterBtn:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1280,"height":720},"child":[{"type":"Sprite","props":{"y":0,"x":0,"width":1280,"var":"closeLayer","height":720}},{"type":"Image","props":{"y":179,"x":351,"width":578,"skin":"res/common/public/popBg1.png","mouseEnabled":true,"height":362}},{"type":"Image","props":{"y":201,"x":604,"skin":"res/common/public/tishi.png"}},{"type":"Image","props":{"y":242,"x":384,"width":512,"skin":"res/common/public/radiusBor1.png","height":205,"sizeGrid":"10,10,10,10"}},{"type":"Text","props":{"y":262,"x":396,"wordWrap":true,"width":488,"var":"text","leading":20,"height":167,"fontSize":24,"font":"Microsoft YaHei","color":"#87361D","align":"center"}},{"type":"Button","props":{"y":458,"x":415,"width":192,"var":"closeBtn","stateNum":1,"skin":"res/common/public/changeBor2.png","labelSize":30,"labelColors":"#083344","label":"取 消","height":65,"sizeGrid":"18,65,16,40"}},{"type":"Button","props":{"y":458,"width":192,"var":"enterBtn","stateNum":1,"skin":"res/common/public/changeBor1.png","labelSize":30,"labelColors":"#511100","label":"确 定","height":65,"centerX":128,"sizeGrid":"1,40,4,33"}}]};
		override protected function createChildren():void {
			View.regComponent("Text",Text);
			super.createChildren();
			createView(uiView);

		}

	}
}