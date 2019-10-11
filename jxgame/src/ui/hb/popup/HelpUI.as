/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class HelpUI extends Dialog {
		public var btnClose:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1016,"height":608},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg3.png"}},{"type":"Image","props":{"y":28,"x":375,"skin":"res/common/public/title.png"}},{"type":"Image","props":{"y":33,"x":464,"skin":"res/hb/popup/help0.png"}},{"type":"Image","props":{"y":94,"x":56,"width":890,"skin":"res/common/public/radiusBor1.png","height":480,"sizeGrid":"10,10,10,10"}},{"type":"Image","props":{"y":5,"x":-11,"skin":"res/common/public/shop3.png"}},{"type":"Button","props":{"y":3,"x":939,"var":"btnClose","stateNum":1,"skin":"res/common/public/close.png"}},{"type":"Label","props":{"y":102,"x":66,"text":"【玩法介绍】","fontSize":24,"color":"#4E302B"}},{"type":"Label","props":{"y":135,"x":112,"text":"准备阶段：","leading":5,"fontSize":24,"color":"#87361D"}},{"type":"Label","props":{"y":135,"x":226,"wordWrap":true,"width":700,"text":"游戏开始后，所有玩家需要享红包内塞入金币（房间底注），房间不同需要塞入的金额也不同。","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":197,"x":112,"text":"定规阶段：","leading":5,"fontSize":24,"color":"#87361D"}},{"type":"Label","props":{"y":197,"x":226,"wordWrap":true,"width":700,"text":"所有人塞完金币后，玩家开始选择是否竞选本局的规则制定者，参与竞选需要支付一定数额竞选费，房间不同竞选费不同。注：竞选费归系统所有，不参与红包金额派发。","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":288,"x":88,"text":"选出定规者：","leading":5,"fontSize":24,"color":"#87361D"}},{"type":"Label","props":{"y":288,"x":226,"wordWrap":true,"width":700,"text":"所有人塞完金币后，玩家开始选择是否竞选本局的规则制定者，参与竞选需要支付一定数额竞选费，房间不同竞选费不同。注：竞选费归系统所有，不参与红包金额派发。","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":379,"x":112,"text":"选定规则：","leading":5,"fontSize":24,"color":"#87361D"}},{"type":"Label","props":{"y":379,"x":226,"wordWrap":true,"width":700,"text":"规则制定者可以在以下四种规则中选择一种，作为本局游戏规则。","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":419,"x":66,"text":"【规则介绍】","fontSize":24,"color":"#4E302B"}},{"type":"Label","props":{"y":452,"x":112,"text":"◆ 投掷点数最小的玩家，获得红包全部金额","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":482,"x":112,"text":"◆ 投掷点数最大的玩家，获得红包全部金额","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":511,"x":112,"text":"◆ 所有投掷点数为小的玩家，每个人开启后获取金额随机","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":541,"x":112,"text":"◆ 所有投掷点数为大的玩家，每个人开启后获取金额随机","leading":5,"fontSize":24,"color":"#8D6343"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}