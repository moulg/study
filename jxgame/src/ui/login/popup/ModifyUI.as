/**Created by the LayaAirIDE,do not modify.*/
package ui.login.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class ModifyUI extends Dialog {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":614,"height":474},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg2.png"}},{"type":"Image","props":{"y":18,"x":229,"skin":"res/login/ui/modify.png"}},{"type":"TextInput","props":{"y":116,"x":188,"width":343,"skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"请输入账号","height":63,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Label","props":{"y":133,"x":124,"text":"账号","skin":"res/login/ui/logo.png","fontSize":28,"color":"#3D0000"}},{"type":"TextInput","props":{"y":196,"x":188,"width":343,"type":"password","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"原密码","height":63,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Label","props":{"y":213,"x":96,"text":"原密码","skin":"res/login/ui/logo.png","fontSize":28,"color":"#3D0000"}},{"type":"TextInput","props":{"y":277,"x":188,"width":343,"type":"password","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"新密码","height":63,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Label","props":{"y":294,"x":96,"text":"新密码","skin":"res/login/ui/logo.png","fontSize":28,"color":"#3D0000"}},{"type":"Button","props":{"y":369,"x":157,"stateNum":1,"skin":"res/login/ui/enterBg.png","labelSize":30,"labelColors":"#f7d370","label":"确 定"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}