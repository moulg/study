/**Created by the LayaAirIDE,do not modify.*/
package ui.login.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class RegisterUI extends Dialog {
		public var accountText:TextInput;
		public var psw1:TextInput;
		public var psw2:TextInput;
		public var btnConfirm:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":614,"height":474},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg2.png"}},{"type":"Image","props":{"y":19,"x":229,"skin":"res/login/ui/register.png"}},{"type":"TextInput","props":{"y":116,"x":188,"width":343,"var":"accountText","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"请输入账号","height":63,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Label","props":{"y":133,"x":124,"text":"账号","skin":"res/login/ui/logo.png","fontSize":28,"color":"#3D0000"}},{"type":"TextInput","props":{"y":196,"x":188,"width":343,"var":"psw1","type":"password","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"设置密码","height":63,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Label","props":{"y":213,"x":68,"text":"设置密码","skin":"res/login/ui/logo.png","fontSize":28,"color":"#3D0000"}},{"type":"TextInput","props":{"y":277,"x":188,"width":343,"var":"psw2","type":"password","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"重复密码","height":63,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Label","props":{"y":294,"x":68,"text":"重复密码","skin":"res/login/ui/logo.png","fontSize":28,"color":"#3D0000"}},{"type":"Button","props":{"y":369,"x":157,"var":"btnConfirm","stateNum":1,"skin":"res/login/ui/enterBg.png","labelSize":30,"labelColors":"#f7d370","label":"确 定"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}