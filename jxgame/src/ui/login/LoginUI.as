/**Created by the LayaAirIDE,do not modify.*/
package ui.login {
	import laya.ui.*;
	import laya.display.*; 

	public class LoginUI extends View {
		public var yanhua:Sprite;
		public var denglujiaose:Sprite;
		public var btnPhone:Button;
		public var btnAccount:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1280,"height":720},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/login/ui/bg.png"}},{"type":"Sprite","props":{"y":150,"x":55,"var":"yanhua"}},{"type":"Sprite","props":{"y":0,"x":0,"var":"denglujiaose"}},{"type":"Image","props":{"y":14,"x":14,"skin":"res/login/ui/logo.png"}},{"type":"Button","props":{"y":550,"x":205,"var":"btnPhone","stateNum":1,"skin":"res/login/ui/onPhone.png"}},{"type":"Button","props":{"y":550,"x":729,"var":"btnAccount","stateNum":1,"skin":"res/login/ui/onAccount.png"}},{"type":"Sprite","props":{"y":680,"x":0,"alpha":0.6},"child":[{"type":"Rect","props":{"y":0,"x":0,"width":1280,"lineWidth":1,"height":40,"fillColor":"#000000"}}]},{"type":"Label","props":{"y":691,"x":136,"text":"抵制不良游戏，拒绝盗版游戏，注意自我保护，谨防受骗上当。适度有地益脑，沉迷游戏伤身，合理安排时间，享受健康生活。","fontSize":18,"color":"#7E7B8F"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}