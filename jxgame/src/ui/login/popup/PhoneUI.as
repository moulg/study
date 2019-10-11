/**Created by the LayaAirIDE,do not modify.*/
package ui.login.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class PhoneUI extends Dialog {
		public var phoneText:TextInput;
		public var keyText:TextInput;
		public var btnKeyObtain:Button;
		public var btnPhone:Button;
		public var btnAgree:CheckBox;
		public var btnAgreement:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":686,"height":420},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg1.png"}},{"type":"TextInput","props":{"y":80,"x":113,"width":459,"var":"phoneText","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"手机号码11位","height":56,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"TextInput","props":{"y":158,"x":114,"width":278,"var":"keyText","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"验证码","height":56,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Button","props":{"y":158,"x":406,"width":166,"var":"btnKeyObtain","stateNum":1,"skin":"res/common/public/radiusBg1.png","labelSize":26,"labelColors":"#f9d7b4","label":"获取验证码","height":55,"sizeGrid":"8,8,8,8"}},{"type":"Button","props":{"y":269,"x":193,"var":"btnPhone","stateNum":1,"skin":"res/login/ui/enterBg.png","labelSize":30,"labelColors":"#f7d370","label":"手机登录"}},{"type":"CheckBox","props":{"y":354,"x":233,"var":"btnAgree","stateNum":2,"skin":"res/login/ui/checkbox.png","selected":true}},{"type":"Label","props":{"y":351,"x":267,"width":203,"var":"btnAgreement","valign":"middle","text":"同意并阅读用户协议","skin":"res/login/ui/logo.png","height":32,"fontSize":22,"color":"#3D0000"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}