/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.scene {
	import laya.ui.*;
	import laya.display.*; 
	import ui.hb.ui.PewUI;
	import ui.hb.ui.SievesUI;
	import ui.hb.ui.GoldUI;

	public class DesktopUI extends View {
		public var bets:Label;
		public var rulefee:Label;
		public var schedule:Sprite;
		public var btnBack:Button;
		public var btnRecharge:Button;
		public var btnColumn:Button;
		public var column:Box;
		public var btnSetUp:Button;
		public var btnRecord:Button;
		public var btnHelp:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1280,"height":720},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/hb/desktop/Bg.png"}},{"type":"Label","props":{"y":410,"x":505,"var":"bets","fontSize":22,"color":"#457076"}},{"type":"Label","props":{"y":410,"x":659,"var":"rulefee","fontSize":22,"color":"#457076"}},{"type":"Image","props":{"y":270,"x":540,"skin":"res/hb/desktop/watermark.png"}},{"type":"Box","props":{"y":-47,"x":271,"name":"pew0"},"child":[{"type":"Pew","props":{"y":0,"x":0,"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":-47,"x":572,"name":"pew1"},"child":[{"type":"Pew","props":{"y":0,"x":0,"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":-47,"x":871,"name":"pew2"},"child":[{"type":"Pew","props":{"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":203,"x":25,"name":"pew3"},"child":[{"type":"Pew","props":{"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":203,"x":1109,"name":"pew4"},"child":[{"type":"Pew","props":{"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":487,"x":271,"name":"pew5"},"child":[{"type":"Pew","props":{"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":487,"x":572,"name":"pew7"},"child":[{"type":"Pew","props":{"y":0,"x":0,"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":487,"x":871,"name":"pew6"},"child":[{"type":"Pew","props":{"y":0,"x":0,"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":175,"x":308,"name":"sieves0"},"child":[{"type":"Sieves","props":{"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":175,"x":609,"name":"sieves1"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":175,"x":908,"name":"sieves2"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":333,"x":165,"name":"sieves3"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":333,"x":1043,"name":"sieves4"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":480,"x":308,"name":"sieves5"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":480,"x":609,"name":"sieves7"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":480,"x":908,"name":"sieves6"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Sprite","props":{"y":0,"x":0,"width":1280,"var":"schedule","stateNum":1,"skin":"res/hb/desktop/column.png","height":720}},{"type":"Box","props":{"y":12,"x":12},"child":[{"type":"Button","props":{"y":3,"var":"btnBack","stateNum":1,"skin":"res/common/public/back.png"}},{"type":"Button","props":{"y":1,"x":1110,"var":"btnRecharge","stateNum":1,"skin":"res/hb/desktop/recharge.png"}},{"type":"Button","props":{"x":1201,"var":"btnColumn","stateNum":1,"skin":"res/hb/desktop/column.png"}},{"type":"Box","props":{"y":64,"x":1123,"visible":false,"var":"column"},"child":[{"type":"Image","props":{"width":145,"skin":"res/hb/desktop/setUpBg.png","height":212,"sizeGrid":"15,13,13,17"}},{"type":"Image","props":{"y":18,"x":15,"skin":"res/common/public/setUp.png"}},{"type":"Label","props":{"y":26,"x":71,"text":"设置","fontSize":28,"color":"#FCE5A3"}},{"type":"Image","props":{"y":74,"x":10,"width":121,"skin":"res/hb/desktop/lateral.png","height":1}},{"type":"Image","props":{"y":90,"x":15,"skin":"res/hb/desktop/record.png"}},{"type":"Label","props":{"y":96,"x":71,"text":"记录","fontSize":28,"color":"#FCE5A3"}},{"type":"Image","props":{"y":144,"x":10,"width":121,"skin":"res/hb/desktop/lateral.png","height":1}},{"type":"Image","props":{"y":155,"x":15,"skin":"res/hb/desktop/help.png"}},{"type":"Label","props":{"y":165,"x":71,"text":"帮助","fontSize":28,"color":"#FCE5A3"}},{"type":"Button","props":{"y":11,"x":2,"width":142,"var":"btnSetUp","height":57}},{"type":"Button","props":{"y":81,"x":2,"width":142,"var":"btnRecord","height":57}},{"type":"Button","props":{"y":150,"x":2,"width":142,"var":"btnHelp","height":57}}]}]},{"type":"Box","props":{"y":112,"x":287,"name":"goldBox0"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":112,"x":588,"name":"goldBox1"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":112,"x":887,"name":"goldBox2"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":360,"x":41,"name":"goldBox3"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":360,"x":1125,"name":"goldBox4"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":642,"x":287,"name":"goldBox5"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":642,"x":887,"name":"goldBox6"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":642,"x":588,"name":"goldBox7"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]}]};
		override protected function createChildren():void {
			View.regComponent("ui.hb.ui.PewUI",PewUI);
			View.regComponent("ui.hb.ui.SievesUI",SievesUI);
			View.regComponent("ui.hb.ui.GoldUI",GoldUI);
			super.createChildren();
			createView(uiView);

		}

	}
}