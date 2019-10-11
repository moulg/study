/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class RecordUI extends Dialog {
		public var btnClose:Button;
		public var recordList:List;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1016,"height":608},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg3.png"}},{"type":"Image","props":{"y":28,"x":375,"skin":"res/common/public/title.png"}},{"type":"Image","props":{"y":94,"x":56,"width":890,"skin":"res/common/public/radiusBor1.png","height":420,"sizeGrid":"10,10,10,10"}},{"type":"Image","props":{"y":34,"x":461,"skin":"res/hb/popup/record0.png"}},{"type":"Button","props":{"y":3,"x":939,"var":"btnClose","stateNum":1,"skin":"res/common/public/close.png"}},{"type":"Image","props":{"y":5,"x":-11,"skin":"res/common/public/shop3.png"}},{"type":"Image","props":{"y":98,"x":61,"width":880,"skin":"res/hb/popup/tabBg.png","height":63,"sizeGrid":"30,30,30,30"}},{"type":"Label","props":{"y":119,"x":92,"text":"序号","fontSize":24,"color":"#4E302B"}},{"type":"Image","props":{"y":109,"x":159,"skin":"res/hb/popup/division.png"}},{"type":"Label","props":{"y":119,"x":176,"text":"点数","fontSize":24,"color":"#4E302B"}},{"type":"Image","props":{"y":109,"x":241,"skin":"res/hb/popup/division.png"}},{"type":"Label","props":{"y":119,"x":622,"text":"规则","fontSize":24,"color":"#4E302B"}},{"type":"Label","props":{"y":119,"x":272,"text":"盈利","fontSize":24,"color":"#4E302B"}},{"type":"Image","props":{"y":109,"x":352,"skin":"res/hb/popup/division.png"}},{"type":"List","props":{"y":169,"x":75,"width":861,"var":"recordList","spaceY":10,"height":318},"child":[{"type":"Box","props":{"renderType":"render"},"child":[{"type":"Label","props":{"width":76,"text":"99999","name":"index","height":24,"fontSize":24,"color":"#87361D","align":"center"}},{"type":"Label","props":{"x":98,"width":48,"text":"10","name":"number","height":24,"fontSize":24,"color":"#87361D","align":"center"}},{"type":"Label","props":{"x":172,"width":99,"text":"8000","name":"profit","height":24,"fontSize":24,"color":"#87361D","align":"center"}},{"type":"Label","props":{"x":284,"width":577,"text":"所有投掷点数为大的玩家，每个人开启后获取金额随机","name":"rule","height":24,"fontSize":24,"color":"#87361D","align":"center"}}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}