/**Created by the LayaAirIDE,do not modify.*/
package ui.common.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class ToastUI extends View {
		public var bg:Image;
		public var text:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":883,"height":57},"child":[{"type":"Image","props":{"y":0,"x":0,"width":883,"var":"bg","skin":"res/common/ui/toast.png","sizeGrid":"10,270,10,270","height":57}},{"type":"Label","props":{"y":11,"wordWrap":true,"width":883,"var":"text","text":"你好","leading":10,"layoutEnabled":true,"height":34,"fontSize":24,"font":"Microsoft YaHei","color":"#ffffff","align":"center"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}