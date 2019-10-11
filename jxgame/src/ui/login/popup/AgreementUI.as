/**Created by the LayaAirIDE,do not modify.*/
package ui.login.popup {
	import laya.ui.*;
	import laya.display.*; 
	import laya.display.Text;

	public class AgreementUI extends Dialog {
		public var agreement:Panel;
		public var content:Text;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1001,"height":608},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg3.png"}},{"type":"Image","props":{"y":94,"x":55,"width":890,"skin":"res/common/public/radiusBor1.png","height":480,"sizeGrid":"10,10,10,10"}},{"type":"Panel","props":{"y":103,"x":69,"width":862,"var":"agreement","height":461},"child":[{"type":"Text","props":{"y":0,"x":0,"wordWrap":true,"width":862,"var":"content","overflow":"scroll","leading":16,"fontSize":24,"font":"Microsoft YaHei","color":"#87361D"}}]},{"type":"Image","props":{"y":38,"x":425,"skin":"res/login/ui/useragree.png"}}]};
		override protected function createChildren():void {
			View.regComponent("Text",Text);
			super.createChildren();
			createView(uiView);

		}

	}
}