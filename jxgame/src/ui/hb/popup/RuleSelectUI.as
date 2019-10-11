/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class RuleSelectUI extends Dialog {
		public var timeNum:Label;
		public var ruleSelectList:List;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":640,"height":331},"child":[{"type":"Image","props":{"y":18,"x":15,"width":610,"skin":"res/hb/ui/ruleBg2.png","height":295,"sizeGrid":"20,20,20,20"}},{"type":"Image","props":{"y":73,"x":28,"width":584,"skin":"res/hb/ui/radiusBg.png","height":219,"sizeGrid":"18,18,18,18"}},{"type":"Label","props":{"y":34,"x":180,"text":"请选择本局游戏规则...","fontSize":26,"color":"#76362C"}},{"type":"Label","props":{"y":32,"x":434,"text":"(    )","fontSize":26,"color":"#FF3700"}},{"type":"Label","props":{"y":35,"x":442,"width":30,"var":"timeNum","height":26,"fontSize":26,"color":"#FF3700","align":"center"}},{"type":"List","props":{"y":83,"x":45,"width":555,"var":"ruleSelectList","spaceY":4,"height":202},"child":[{"type":"Box","props":{"renderType":"render"},"child":[{"type":"Image","props":{"width":555,"stateNum":1,"skin":"res/common/public/changeBor1.png","name":"btnRoom","labelSize":22,"labelColors":"#333333","labelBold":true,"label":"进 入","height":47,"sizeGrid":"1,40,4,33"}},{"type":"Label","props":{"y":10,"x":0,"width":555,"text":"投掷点数最小的玩家，获得红包全部金额","name":"explain","fontSize":22,"color":"#511100","align":"center"}}]}]},{"type":"Image","props":{"y":0,"x":0,"width":24,"skin":"res/hb/ui/reel1.png","height":331,"sizeGrid":"25,8,31,4"}},{"type":"Image","props":{"y":0,"x":617,"width":24,"skin":"res/hb/ui/reel2.png","height":331,"sizeGrid":"25,8,31,4"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}