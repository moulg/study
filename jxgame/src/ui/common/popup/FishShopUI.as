/**Created by the LayaAirIDE,do not modify.*/
package ui.common.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class FishShopUI extends Dialog {
		public var btnClose:Image;
		public var shopList:List;
		public var gold:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1720,"height":890},"child":[{"type":"Image","props":{"y":45,"x":403,"width":1317,"skin":"res/common/popup/fishShop/fish2.png","sizeGrid":"0,127,105,127","height":845}},{"type":"Image","props":{"y":89,"x":0,"skin":"res/common/popup/fishShop/fish5.png"}},{"type":"Image","props":{"y":1,"x":1756,"skin":"res/common/popup/fishShop/fish1.png","skewY":180}},{"type":"Image","props":{"y":1,"x":350,"skin":"res/common/popup/fishShop/fish1.png"}},{"type":"Image","props":{"y":-16,"x":1647,"var":"btnClose","skin":"res/common/popup/fishShop/fish3.png"}},{"type":"List","props":{"y":145,"x":520,"width":1096,"var":"shopList","spaceY":30,"spaceX":40,"height":669},"child":[{"type":"Box","props":{"y":0,"x":0,"width":334,"renderType":"render","height":318},"child":[{"type":"Image","props":{"skin":"res/common/popup/fishShop/fish6.png"}},{"type":"Image","props":{"x":331,"skin":"res/common/popup/fishShop/fish6.png","skewY":180}},{"type":"Image","props":{"y":9,"x":7,"skin":"res/common/popup/fishShop/fish7.png"}},{"type":"Image","props":{"y":39,"x":105,"skin":"res/common/gold/gold1.png","name":"img"}},{"type":"Label","props":{"y":165,"x":13,"width":306,"text":"500金币","name":"gold","height":28,"fontSize":28,"color":"#5ccbe7","align":"center"}},{"type":"Image","props":{"y":228,"x":40,"width":258,"skin":"res/common/popup/fishShop/fish4.png","sizeGrid":"0,21,0,20","height":90}},{"type":"Label","props":{"y":246,"x":58,"width":214,"text":"￥500","name":"price","fontSize":42,"color":"#ffffff","align":"center"}}]}]},{"type":"Label","props":{"y":-76,"x":191,"width":231,"visible":false,"var":"gold","text":180002,"height":28,"fontSize":28,"color":"#E4BC88","align":"center"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}