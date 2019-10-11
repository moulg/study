/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class RuleConfirmUI extends Dialog {
		public var ruleText:Label;
		public var timeNum:Label;
		public var btnBetting:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":741,"height":360},"child":[{"type":"Image","props":{"y":65,"x":16,"width":710,"skin":"res/hb/ui/ruleBg2.png","height":222,"sizeGrid":"20,20,20,20"}},{"type":"Image","props":{"y":124,"x":30,"width":680,"skin":"res/hb/ui/radiusBg.png","height":79,"sizeGrid":"18,18,18,18"}},{"type":"Label","props":{"y":81,"x":317,"text":"本局规则","fontSize":26,"color":"#76362C","bold":true}},{"type":"Label","props":{"y":151,"x":31,"width":679,"var":"ruleText","height":28,"fontSize":28,"color":"#FFFC00","align":"center"}},{"type":"Label","props":{"y":220,"x":203,"text":"请各位玩家投掷筛子...","fontSize":26,"color":"#76362C"}},{"type":"Label","props":{"y":217,"x":468,"text":"(    )","fontSize":26,"color":"#FF3700"}},{"type":"Label","props":{"y":219,"x":473,"width":35,"var":"timeNum","height":26,"fontSize":26,"color":"#FF3700","align":"center"}},{"type":"Button","props":{"y":295,"x":274,"width":192,"var":"btnBetting","stateNum":1,"skin":"res/common/public/changeBor1.png","labelSize":30,"labelColors":"#511100","label":"投 掷","height":65,"sizeGrid":"1,40,4,33"}},{"type":"Image","props":{"y":46,"x":0,"width":24,"skin":"res/hb/ui/reel1.png","height":259,"sizeGrid":"25,8,31,4"}},{"type":"Image","props":{"y":46,"x":717,"width":24,"skin":"res/hb/ui/reel2.png","height":259,"sizeGrid":"25,8,31,4"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}