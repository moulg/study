/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class RuleAgreeUI extends Dialog {
		public var rulefee:Label;
		public var timeNum:Label;
		public var btnJoin:Button;
		public var btnCanJoin:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":574,"height":220},"child":[{"type":"Image","props":{"y":18,"x":4,"width":566,"skin":"res/hb/ui/ruleBg1.png","height":116,"sizeGrid":"40,40,40,40"}},{"type":"Label","props":{"y":44,"x":123,"text":"是否选择参与该局规则制定？","overflow":"hidden","fontSize":26,"color":"#76362C"}},{"type":"Label","props":{"y":78,"x":123,"var":"rulefee","text":"参与竞选需要支付1金币...","overflow":"hidden","fontSize":26,"color":"#76362C"}},{"type":"Label","props":{"y":78,"x":430,"text":"(    )","overflow":"hidden","fontSize":26,"color":"#FF3700"}},{"type":"Label","props":{"y":81,"x":438,"width":32,"var":"timeNum","overflow":"hidden","height":26,"fontSize":26,"color":"#FF3700","align":"center"}},{"type":"Button","props":{"y":155,"x":325,"width":192,"var":"btnJoin","stateNum":1,"skin":"res/common/public/changeBor1.png","labelSize":30,"labelColors":"#511100","label":"参 与","height":65,"sizeGrid":"1,40,4,33"}},{"type":"Button","props":{"y":154,"x":56,"width":192,"var":"btnCanJoin","stateNum":1,"skin":"res/common/public/changeBor2.png","labelSize":30,"labelColors":"#083344","label":"不参与","height":65,"sizeGrid":"18,65,16,40"}},{"type":"Image","props":{"y":0,"x":0,"width":24,"skin":"res/hb/ui/reel1.png","height":152,"sizeGrid":"25,8,31,4"}},{"type":"Image","props":{"y":0,"x":550,"width":24,"skin":"res/hb/ui/reel2.png","height":150,"sizeGrid":"25,8,31,4"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}