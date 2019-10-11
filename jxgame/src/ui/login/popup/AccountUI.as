/**Created by the LayaAirIDE,do not modify.*/
package ui.login.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class AccountUI extends Dialog {
		public var acountText:TextInput;
		public var passText:TextInput;
		public var automatic:CheckBox;
		public var btnModify:Label;
		public var btnRegister:Label;
		public var btnAccout:Button;
		public var btnAgree:CheckBox;
		public var btnAgreement:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":686,"height":420},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg1.png"}},{"type":"TextInput","props":{"y":80,"x":113,"width":459,"var":"acountText","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"账号","height":56,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"TextInput","props":{"y":158,"x":114,"width":459,"var":"passText","type":"password","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"密码","height":56,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"CheckBox","props":{"y":226,"x":146,"var":"automatic","stateNum":2,"skin":"res/login/ui/checkbox.png","selected":true}},{"type":"Label","props":{"y":228,"x":173,"text":"自动登录","skin":"res/login/ui/logo.png","fontSize":22,"color":"#3D0000"}},{"type":"Label","props":{"y":226,"x":361,"visible":false,"var":"btnModify","underline":true,"text":"修改密码","skin":"res/login/ui/logo.png","fontSize":22,"color":"#3D0000"}},{"type":"Label","props":{"y":224,"x":481,"var":"btnRegister","underline":true,"text":"账号注册","skin":"res/login/ui/logo.png","fontSize":22,"color":"#3D0000"}},{"type":"Button","props":{"y":269,"x":193,"var":"btnAccout","stateNum":1,"skin":"res/login/ui/enterBg.png","labelSize":30,"labelColors":"#f7d370","label":"账号登录"}},{"type":"CheckBox","props":{"y":354,"x":233,"var":"btnAgree","stateNum":2,"skin":"res/login/ui/checkbox.png","selected":true}},{"type":"Label","props":{"y":351,"x":267,"width":203,"var":"btnAgreement","valign":"middle","text":"同意并阅读用户协议","skin":"res/login/ui/logo.png","height":32,"fontSize":22,"color":"#3D0000"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}