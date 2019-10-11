/**Created by the LayaAirIDE,do not modify.*/
package ui.common.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class ShopUI extends Dialog {
		public var btnClose:Button;
		public var shopList:List;
		public var gold:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1148,"height":684},"child":[{"type":"Image","props":{"y":50,"x":15,"skin":"res/common/popup/shop/shopBg.png"}},{"type":"Button","props":{"y":25,"x":1073,"var":"btnClose","stateNum":1,"skin":"res/common/public/close.png"}},{"type":"Image","props":{"y":6,"x":3,"skin":"res/common/popup/shop/shop1.png"}},{"type":"Image","props":{"y":6,"x":1147,"skin":"res/common/popup/shop/shop1.png","skewY":180}},{"type":"Image","props":{"y":0,"x":440,"skin":"res/common/popup/shop/shop2.png"}},{"type":"Image","props":{"y":49,"x":1,"skin":"res/common/public/shop3.png"}},{"type":"Image","props":{"y":5,"x":1149,"skin":"res/common/popup/shop/shop4.png","skewY":180}},{"type":"Image","props":{"y":5,"x":0,"skin":"res/common/popup/shop/shop4.png"}},{"type":"Image","props":{"y":9,"x":536,"skin":"res/common/popup/shop/shop0.png"}},{"type":"List","props":{"y":98,"x":86,"width":976,"var":"shopList","spaceY":12,"spaceX":11,"height":482},"child":[{"type":"Box","props":{"renderType":"render"},"child":[{"type":"Image","props":{"skin":"res/common/popup/shop/shop6.png"}},{"type":"Label","props":{"y":8,"x":43,"width":149,"text":"500金币","name":"gold","height":24,"fontSize":24,"color":"#FEFEFE","bold":true,"align":"center"}},{"type":"Image","props":{"y":47,"x":59,"skin":"res/common/gold/gold1.png","name":"img"}},{"type":"Label","props":{"y":187,"x":10,"width":214,"text":"￥500","name":"price","height":24,"fontSize":30,"color":"#76362C","align":"center"}}]}]},{"type":"Image","props":{"y":622,"x":834,"width":247,"skin":"res/common/public/radiusBg2.png","height":46,"sizeGrid":"16,18,17,12"}},{"type":"Image","props":{"y":619,"x":797,"skin":"res/common/public/gold.png"}},{"type":"Label","props":{"y":630,"x":847,"width":231,"var":"gold","text":180002,"height":28,"fontSize":28,"color":"#E4BC88","align":"center"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}