/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class SlugMoneyUI extends Dialog {
		public var noOpen:Box;
		public var open:Box;
		public var btnOpen:Button;
		public var openNum:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":721,"height":506},"child":[{"type":"Box","props":{"y":0,"x":0,"var":"noOpen"},"child":[{"type":"Image","props":{"y":74,"x":195,"skin":"res/hb/ui/colse2.png"}},{"type":"Image","props":{"y":126,"x":288,"stateNum":1,"skin":"res/hb/ui/colse.png"}},{"type":"Label","props":{"y":318,"x":226,"text":"您在本局不满足获奖条件 ","overflow":"hidden","fontSize":24,"color":"#A4A4A4"}},{"type":"Label","props":{"y":351,"x":293,"text":"不可开启红包","overflow":"hidden","fontSize":24,"color":"#A4A4A4"}},{"type":"Image","props":{"y":0,"x":0,"visible":true,"skin":"res/hb/ui/close1.png"}}]},{"type":"Box","props":{"y":18,"x":0,"var":"open"},"child":[{"type":"Image","props":{"y":56,"x":195,"skin":"res/hb/ui/package.png"}},{"type":"Button","props":{"y":108,"x":288,"var":"btnOpen","stateNum":1,"skin":"res/hb/ui/open.png"}},{"type":"Label","props":{"y":333,"x":457,"width":30,"var":"openNum","overflow":"hidden","height":24,"fontSize":24,"color":"#00FF2A","align":"center"}},{"type":"Image","props":{"skin":"res/hb/ui/open1.png"}},{"type":"Image","props":{"y":53,"x":109,"skin":"res/hb/ui/open2.png"}},{"type":"Label","props":{"y":297,"x":237,"visible":false,"text":"您在本局满足获奖条件 ","overflow":"hidden","fontSize":24,"color":"#E0C076"}},{"type":"Label","props":{"y":333,"x":228,"visible":false,"text":"请点击按钮开启红包","overflow":"hidden","fontSize":24,"color":"#E0C076"}},{"type":"Label","props":{"y":332,"x":450,"visible":false,"text":"(    )","overflow":"hidden","fontSize":24,"color":"#00FF2A"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}