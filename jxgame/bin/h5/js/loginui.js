
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Button=laya.ui.Button,CheckBox=laya.ui.CheckBox,Dialog=laya.ui.Dialog,Label=laya.ui.Label,Panel=laya.ui.Panel;
	var Sprite=laya.display.Sprite,Text=laya.display.Text,TextInput=laya.ui.TextInput,View=laya.ui.View;
//class ui.login.LoginUI extends laya.ui.View
var LoginUI=(function(_super){
	function LoginUI(){
		this.yanhua=null;
		this.denglujiaose=null;
		this.btnPhone=null;
		this.btnAccount=null;
		LoginUI.__super.call(this);
	}

	__class(LoginUI,'ui.login.LoginUI',_super);
	var __proto=LoginUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(LoginUI.uiView);
	}

	LoginUI.uiView={"type":"View","props":{"width":1280,"height":720},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/login/ui/bg.png"}},{"type":"Sprite","props":{"y":150,"x":55,"var":"yanhua"}},{"type":"Sprite","props":{"y":0,"x":0,"var":"denglujiaose"}},{"type":"Image","props":{"y":14,"x":14,"skin":"res/login/ui/logo.png"}},{"type":"Button","props":{"y":550,"x":205,"var":"btnPhone","stateNum":1,"skin":"res/login/ui/onPhone.png"}},{"type":"Button","props":{"y":550,"x":729,"var":"btnAccount","stateNum":1,"skin":"res/login/ui/onAccount.png"}},{"type":"Sprite","props":{"y":680,"x":0,"alpha":0.6},"child":[{"type":"Rect","props":{"y":0,"x":0,"width":1280,"lineWidth":1,"height":40,"fillColor":"#000000"}}]},{"type":"Label","props":{"y":691,"x":136,"text":"抵制不良游戏，拒绝盗版游戏，注意自我保护，谨防受骗上当。适度有地益脑，沉迷游戏伤身，合理安排时间，享受健康生活。","fontSize":18,"color":"#7E7B8F"}}]};
	return LoginUI;
})(View)


//class ui.login.popup.AccountUI extends laya.ui.Dialog
var AccountUI=(function(_super){
	function AccountUI(){
		this.acountText=null;
		this.passText=null;
		this.automatic=null;
		this.btnModify=null;
		this.btnRegister=null;
		this.btnAccout=null;
		this.btnAgree=null;
		this.btnAgreement=null;
		AccountUI.__super.call(this);
	}

	__class(AccountUI,'ui.login.popup.AccountUI',_super);
	var __proto=AccountUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(AccountUI.uiView);
	}

	AccountUI.uiView={"type":"Dialog","props":{"width":686,"height":420},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg1.png"}},{"type":"TextInput","props":{"y":80,"x":113,"width":459,"var":"acountText","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"账号","height":56,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"TextInput","props":{"y":158,"x":114,"width":459,"var":"passText","type":"password","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"密码","height":56,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"CheckBox","props":{"y":226,"x":146,"var":"automatic","stateNum":2,"skin":"res/login/ui/checkbox.png","selected":true}},{"type":"Label","props":{"y":228,"x":173,"text":"自动登录","skin":"res/login/ui/logo.png","fontSize":22,"color":"#3D0000"}},{"type":"Label","props":{"y":226,"x":361,"visible":false,"var":"btnModify","underline":true,"text":"修改密码","skin":"res/login/ui/logo.png","fontSize":22,"color":"#3D0000"}},{"type":"Label","props":{"y":224,"x":481,"var":"btnRegister","underline":true,"text":"账号注册","skin":"res/login/ui/logo.png","fontSize":22,"color":"#3D0000"}},{"type":"Button","props":{"y":269,"x":193,"var":"btnAccout","stateNum":1,"skin":"res/login/ui/enterBg.png","labelSize":30,"labelColors":"#f7d370","label":"账号登录"}},{"type":"CheckBox","props":{"y":354,"x":233,"var":"btnAgree","stateNum":2,"skin":"res/login/ui/checkbox.png","selected":true}},{"type":"Label","props":{"y":351,"x":267,"width":203,"var":"btnAgreement","valign":"middle","text":"同意并阅读用户协议","skin":"res/login/ui/logo.png","height":32,"fontSize":22,"color":"#3D0000"}}]};
	return AccountUI;
})(Dialog)


//class ui.login.popup.AgreementUI extends laya.ui.Dialog
var AgreementUI=(function(_super){
	function AgreementUI(){
		this.agreement=null;
		this.content=null;
		AgreementUI.__super.call(this);
	}

	__class(AgreementUI,'ui.login.popup.AgreementUI',_super);
	var __proto=AgreementUI.prototype;
	__proto.createChildren=function(){
		View.regComponent("Text",Text);
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(AgreementUI.uiView);
	}

	AgreementUI.uiView={"type":"Dialog","props":{"width":1001,"height":608},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg3.png"}},{"type":"Image","props":{"y":94,"x":55,"width":890,"skin":"res/common/public/radiusBor1.png","height":480,"sizeGrid":"10,10,10,10"}},{"type":"Panel","props":{"y":103,"x":69,"width":862,"var":"agreement","height":461},"child":[{"type":"Text","props":{"y":0,"x":0,"wordWrap":true,"width":862,"var":"content","overflow":"scroll","leading":16,"fontSize":24,"font":"Microsoft YaHei","color":"#87361D"}}]},{"type":"Image","props":{"y":38,"x":425,"skin":"res/login/ui/useragree.png"}}]};
	return AgreementUI;
})(Dialog)


//class ui.login.popup.ModifyUI extends laya.ui.Dialog
var ModifyUI=(function(_super){
	function ModifyUI(){
		ModifyUI.__super.call(this);;
	}

	__class(ModifyUI,'ui.login.popup.ModifyUI',_super);
	var __proto=ModifyUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(ModifyUI.uiView);
	}

	ModifyUI.uiView={"type":"Dialog","props":{"width":614,"height":474},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg2.png"}},{"type":"Image","props":{"y":18,"x":229,"skin":"res/login/ui/modify.png"}},{"type":"TextInput","props":{"y":116,"x":188,"width":343,"skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"请输入账号","height":63,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Label","props":{"y":133,"x":124,"text":"账号","skin":"res/login/ui/logo.png","fontSize":28,"color":"#3D0000"}},{"type":"TextInput","props":{"y":196,"x":188,"width":343,"type":"password","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"原密码","height":63,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Label","props":{"y":213,"x":96,"text":"原密码","skin":"res/login/ui/logo.png","fontSize":28,"color":"#3D0000"}},{"type":"TextInput","props":{"y":277,"x":188,"width":343,"type":"password","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"新密码","height":63,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Label","props":{"y":294,"x":96,"text":"新密码","skin":"res/login/ui/logo.png","fontSize":28,"color":"#3D0000"}},{"type":"Button","props":{"y":369,"x":157,"stateNum":1,"skin":"res/login/ui/enterBg.png","labelSize":30,"labelColors":"#f7d370","label":"确 定"}}]};
	return ModifyUI;
})(Dialog)


//class ui.login.popup.PhoneUI extends laya.ui.Dialog
var PhoneUI=(function(_super){
	function PhoneUI(){
		this.phoneText=null;
		this.keyText=null;
		this.btnKeyObtain=null;
		this.btnPhone=null;
		this.btnAgree=null;
		this.btnAgreement=null;
		PhoneUI.__super.call(this);
	}

	__class(PhoneUI,'ui.login.popup.PhoneUI',_super);
	var __proto=PhoneUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(PhoneUI.uiView);
	}

	PhoneUI.uiView={"type":"Dialog","props":{"width":686,"height":420},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg1.png"}},{"type":"TextInput","props":{"y":80,"x":113,"width":459,"var":"phoneText","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"手机号码11位","height":56,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"TextInput","props":{"y":158,"x":114,"width":278,"var":"keyText","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"验证码","height":56,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Button","props":{"y":158,"x":406,"width":166,"var":"btnKeyObtain","stateNum":1,"skin":"res/common/public/radiusBg1.png","labelSize":26,"labelColors":"#f9d7b4","label":"获取验证码","height":55,"sizeGrid":"8,8,8,8"}},{"type":"Button","props":{"y":269,"x":193,"var":"btnPhone","stateNum":1,"skin":"res/login/ui/enterBg.png","labelSize":30,"labelColors":"#f7d370","label":"手机登录"}},{"type":"CheckBox","props":{"y":354,"x":233,"var":"btnAgree","stateNum":2,"skin":"res/login/ui/checkbox.png","selected":true}},{"type":"Label","props":{"y":351,"x":267,"width":203,"var":"btnAgreement","valign":"middle","text":"同意并阅读用户协议","skin":"res/login/ui/logo.png","height":32,"fontSize":22,"color":"#3D0000"}}]};
	return PhoneUI;
})(Dialog)


//class ui.login.popup.RegisterUI extends laya.ui.Dialog
var RegisterUI=(function(_super){
	function RegisterUI(){
		this.accountText=null;
		this.psw1=null;
		this.psw2=null;
		this.btnConfirm=null;
		RegisterUI.__super.call(this);
	}

	__class(RegisterUI,'ui.login.popup.RegisterUI',_super);
	var __proto=RegisterUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(RegisterUI.uiView);
	}

	RegisterUI.uiView={"type":"Dialog","props":{"width":614,"height":474},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg2.png"}},{"type":"Image","props":{"y":19,"x":229,"skin":"res/login/ui/register.png"}},{"type":"TextInput","props":{"y":116,"x":188,"width":343,"var":"accountText","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"请输入账号","height":63,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Label","props":{"y":133,"x":124,"text":"账号","skin":"res/login/ui/logo.png","fontSize":28,"color":"#3D0000"}},{"type":"TextInput","props":{"y":196,"x":188,"width":343,"var":"psw1","type":"password","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"设置密码","height":63,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Label","props":{"y":213,"x":68,"text":"设置密码","skin":"res/login/ui/logo.png","fontSize":28,"color":"#3D0000"}},{"type":"TextInput","props":{"y":277,"x":188,"width":343,"var":"psw2","type":"password","skin":"res/login/ui/radiusBg1.png","promptColor":"#c36460","prompt":"重复密码","height":63,"fontSize":26,"color":"#c36460","align":"center","sizeGrid":"7,7,7,7"}},{"type":"Label","props":{"y":294,"x":68,"text":"重复密码","skin":"res/login/ui/logo.png","fontSize":28,"color":"#3D0000"}},{"type":"Button","props":{"y":369,"x":157,"var":"btnConfirm","stateNum":1,"skin":"res/login/ui/enterBg.png","labelSize":30,"labelColors":"#f7d370","label":"确 定"}}]};
	return RegisterUI;
})(Dialog)



})(window,document,Laya);

if (typeof define === 'function' && define.amd){
	define('laya.core', ['require', "exports"], function(require, exports) {
        'use strict';
        Object.defineProperty(exports, '__esModule', { value: true });
        for (var i in Laya) {
			var o = Laya[i];
            o && o.__isclass && (exports[i] = o);
        }
    });
}