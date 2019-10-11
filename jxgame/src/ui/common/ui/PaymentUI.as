/**Created by the LayaAirIDE,do not modify.*/
package ui.common.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class PaymentUI extends View {
		public var close:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"y":0,"x":0,"width":750,"height":1334},"child":[{"type":"Sprite","props":{"y":0,"x":0,"width":750,"height":1334},"child":[{"type":"Rect","props":{"y":0,"x":0,"width":750,"lineWidth":0,"height":1334,"fillColor":"#000000"}}]},{"type":"Sprite","props":{"y":0,"x":0,"width":750,"height":100},"child":[{"type":"Rect","props":{"y":0,"x":0,"width":750,"lineWidth":0,"height":100,"fillColor":"#ffffff"}}]},{"type":"Label","props":{"y":28,"x":100,"width":550,"text":"请用微信或支付宝扫码支付","height":50,"fontSize":30,"font":"Microsoft YaHei","color":"#000000","align":"center"}},{"type":"Button","props":{"y":32,"x":687,"var":"close","stateNum":1,"skin":"res/common/ui/close.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}