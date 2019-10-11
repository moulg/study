
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var AccountUI=ui.login.popup.AccountUI,AgreementUI=ui.login.popup.AgreementUI,AudioManager=game.core.manager.AudioManager;
	var Auth=game.core.utils.Auth,BaseModel=game.core.base.BaseModel,BaseModule=game.core.base.BaseModule,CoreHound=game.core.utils.CoreHound;
	var EffectManager=game.core.manager.EffectManager,Event=laya.events.Event,ExternalManager=game.core.manager.ExternalManager;
	var GlobalConfig=game.core.model.GlobalConfig,GlobalEnum=game.core.enum.GlobalEnum,GlobalModel=game.core.model.GlobalModel;
	var Handler=laya.utils.Handler,Loader=laya.net.Loader,LoginUI=ui.login.LoginUI,ModifyUI=ui.login.popup.ModifyUI;
	var Module=game.core.enum.Module,PhoneUI=ui.login.popup.PhoneUI,PopupManager=game.core.manager.PopupManager;
	var Redirect=game.core.utils.Redirect,RegisterUI=ui.login.popup.RegisterUI,SceneManager=game.core.manager.SceneManager;
	var Signal=game.core.utils.Signal,Skeleton=laya.ani.bone.Skeleton,Storage=game.core.utils.Storage,Toast=game.core.ui.Toast;
/**
*chenyuan
*/
//class game.module.login.enum.LoginEnum
var LoginEnum=(function(){
	function LoginEnum(){}
	__class(LoginEnum,'game.module.login.enum.LoginEnum');
	LoginEnum.LOGIN="LOGIN";
	LoginEnum.AGREEMENT="AGREEMENT";
	LoginEnum.PHONE="PHONE";
	LoginEnum.ACCOUNT="ACCOUNT";
	LoginEnum.MODIFY="MODIFY";
	LoginEnum.REGISTER="REGISTER";
	return LoginEnum;
})()


//class game.module.login.utils.LoginSound
var LoginSound=(function(){
	function LoginSound(){}
	__class(LoginSound,'game.module.login.utils.LoginSound');
	__getset(1,LoginSound,'initSounds',function(){
		var list=[LoginSound.getUrl("bg",true)];
		var arr=["button"];
		while(arr&&arr.length){
			list.push(LoginSound.getUrl(arr.shift()));
		}
		return list;
	});

	LoginSound.init=function(){
		AudioManager.start(LoginSound.getUrl("bg",true));
	}

	LoginSound.effect=function(str){
		AudioManager.playSound(LoginSound.getUrl(str));
	}

	LoginSound.getUrl=function(name,isMusic){
		(isMusic===void 0)&& (isMusic=false);
		return GlobalConfig.getSoundUrl(name,isMusic);
	}

	return LoginSound;
})()


/**
*liuhe
*/
//class game.module.login.LoginModel extends game.core.base.BaseModel
var LoginModel=(function(_super){
	function LoginModel(){
		LoginModel.__super.call(this);
	}

	__class(LoginModel,'game.module.login.LoginModel',_super);
	var __proto=LoginModel.prototype;
	__proto.init=function(data){
		_super.prototype.init.call(this,data);
		var isClear=Boolean(data);
		if(isClear)Storage.clear();
		GlobalModel.instance.reset();
	}

	__proto.onMessage=function(data){}
	__proto.destroy=function(){
		_super.prototype.destroy.call(this);
		LoginModel._instance=null;
	}

	__getset(1,LoginModel,'instance',function(){
		if(!LoginModel._instance)LoginModel._instance=new LoginModel();
		return LoginModel._instance;
	},game.core.base.BaseModel._$SET_instance);

	LoginModel._instance=null;
	return LoginModel;
})(BaseModel)


//class game.module.login.LoginModule extends game.core.base.BaseModule
var LoginModule=(function(_super){
	function LoginModule(){
		LoginModule.__super.call(this);
		PopupManager.reg("LOGIN","AGREEMENT",AgreementView);
		PopupManager.reg("LOGIN","PHONE",PhoneView);
		PopupManager.reg("LOGIN","ACCOUNT",AccountView);
		PopupManager.reg("LOGIN","MODIFY",ModifyView);
		PopupManager.reg("LOGIN","REGISTER",RegisterView);
		SceneManager.reg("LOGIN","LOGIN",LoginView);
		var res=[
		{url:"res/login/ui.json",type:"atlas"},
		{url:"res/login/ani/denglujiaose.png",type:"image"},
		{url:"res/login/ani/yanhua.png",type:"image"},];
		this.init(res);
	}

	__class(LoginModule,'game.module.login.LoginModule',_super);
	var __proto=LoginModule.prototype;
	__proto.onInit=function(){
		_super.prototype.onInit.call(this);
		LoginModel.instance.init(this.dataSource);
		SceneManager.enter("LOGIN","LOGIN");
		this.initComplete();
	}

	__proto.enter=function(data){
		_super.prototype.enter.call(this,data);
		LoginSound.init();
	}

	__proto.remove=function(){
		_super.prototype.remove.call(this);
	}

	__proto.destroy=function(destroyChild){
		(destroyChild===void 0)&& (destroyChild=true);
		laya.display.Sprite.prototype.destroy.call(this,destroyChild);
		LoginModel.instance.destroy();
	}

	LoginModule.getSoundUrl=function(name,isMusic){
		(isMusic===void 0)&& (isMusic=false);
		return "res/login/sound/"+name+GlobalConfig.getSoundExt(isMusic);
	}

	return LoginModule;
})(BaseModule)


/**
*liuhe
*/
//class game.module.login.scene.LoginView extends ui.login.LoginUI
var LoginView=(function(_super){
	function LoginView(){
		this.time=0;
		this.step=0;
		LoginView.__super.call(this);
		var _$this=this;
		this.btnPhone.on("click",this,this.onPhone);
		this.btnAccount.on("click",this,this.onAccount);
		Signal.on("APP_WX_LOGIN",this,this.onWxLogin);
		Signal.on("MODULE_START",this,this.onStart);
		EffectManager.getSkeleton("res/login/ani/denglujiaose.json",Handler.create(this,function(sk){
			sk.x=600;
			sk.y=730;
			_$this.denglujiaose.addChild(sk);
		}));
		EffectManager.getSkeleton("res/login/ani/yanhua.json",Handler.create(this,function(sk){
			sk.x=600;
			sk.y=0;
			_$this.yanhua.addChild(sk);
		}));
	}

	__class(LoginView,'game.module.login.scene.LoginView',_super);
	var __proto=LoginView.prototype;
	__proto.onPhone=function(){
		CoreHound.effect("button");
		PopupManager.open("LOGIN","PHONE");
	}

	__proto.onAccount=function(){
		CoreHound.effect("button");
		PopupManager.open("LOGIN","ACCOUNT");
	}

	__proto.onWxLogin=function(code){
		Auth.instance.loginByWeixin(code);
	}

	__proto.onStart=function(){
		Redirect.start();
	}

	__proto.destroy=function(destroyChild){
		(destroyChild===void 0)&& (destroyChild=true);
		laya.ui.View.prototype.destroy.call(this,destroyChild);
		Signal.off("APP_WX_LOGIN",this,this.onWxLogin);
		Signal.off("MODULE_START",this,this.onStart);
	}

	return LoginView;
})(LoginUI)


/**
*liuhe
*/
//class game.module.login.popup.AccountView extends ui.login.popup.AccountUI
var AccountView=(function(_super){
	function AccountView(){
		AccountView.__super.call(this);
		this.btnAgree.on("click",this,this.onAgree);
		this.btnAgreement.on("click",this,this.onAgreement);
		this.btnModify.on("click",this,this.onModify);
		this.btnRegister.on("click",this,this.onRegister);
		this.btnAccout.on("click",this,this.onAccout);
		this.automatic.on("click",this,this.onAutomatic);
	}

	__class(AccountView,'game.module.login.popup.AccountView',_super);
	var __proto=AccountView.prototype;
	__proto.onModify=function(){
		CoreHound.effect("button");
		PopupManager.open("LOGIN","MODIFY");
	}

	__proto.onAutomatic=function(){
		CoreHound.effect("button");
	}

	__proto.onRegister=function(){
		CoreHound.effect("button");
		PopupManager.open("LOGIN","REGISTER");
	}

	__proto.onAccout=function(){
		CoreHound.effect("button");
		if(!this.acountText.text){
			Toast.error("请输入账号");
			}else if(!this.passText.text){
			Toast.error("请输入密码");
			}else{
			GlobalConfig.isAutomatic=this.automatic.selected;
			Auth.instance.accountLogin(this.acountText.text,this.passText.text);
		}
	}

	__proto.onAgree=function(){
		CoreHound.effect("button");
		this.btnAccout.disabled=!this.btnAgree.selected;
	}

	__proto.onAgreement=function(){
		CoreHound.effect("button");
		PopupManager.open("LOGIN","AGREEMENT");
	}

	return AccountView;
})(AccountUI)


/**
*caoheyan
*/
//class game.module.login.popup.AgreementView extends ui.login.popup.AgreementUI
var AgreementView=(function(_super){
	function AgreementView(){
		AgreementView.__super.call(this);
		Laya.loader.load("res/login/agreement.txt",Handler.create(this,this.onLoaded));
	}

	__class(AgreementView,'game.module.login.popup.AgreementView',_super);
	var __proto=AgreementView.prototype;
	__proto.onLoaded=function(text){
		if(!text)return;
		this.agreement.vScrollBarSkin=null;
		this.agreement.vScrollBar.elasticBackTime=100;
		this.agreement.vScrollBar.elasticDistance=100;
		this.content.text=text;
	}

	return AgreementView;
})(AgreementUI)


/**
*liuhe
*/
//class game.module.login.popup.ModifyView extends ui.login.popup.ModifyUI
var ModifyView=(function(_super){
	function ModifyView(){
		ModifyView.__super.call(this);
	}

	__class(ModifyView,'game.module.login.popup.ModifyView',_super);
	return ModifyView;
})(ModifyUI)


/**
*liuhe
*/
//class game.module.login.popup.PhoneView extends ui.login.popup.PhoneUI
var PhoneView=(function(_super){
	function PhoneView(){
		this.time=60;
		PhoneView.__super.call(this);
		this.btnAgree.on("click",this,this.onAgree);
		this.btnAgreement.on("click",this,this.onAgreement);
		this.btnKeyObtain.on("click",this,this.onKeyObtain);
		this.btnPhone.on("click",this,this.onPhone);
	}

	__class(PhoneView,'game.module.login.popup.PhoneView',_super);
	var __proto=PhoneView.prototype;
	__proto.onKeyObtain=function(){
		CoreHound.effect("button");
		if(this.time==60){
			if(this.phoneText.text==""){
				Toast.error("请输入手机号！");
				}else if(!this.isPhone(this.phoneText.text)){
				Toast.error("请输入正确的手机号码！");
				}else{
				this.timerLoop(1000,this,this.onTimer);
				this.btnKeyObtain.disabled=true;
				this.btnKeyObtain.label="("+this.time+")重新获取";
				this.sendCode(this.phoneText.text);
			}
		}
	}

	__proto.onAgreement=function(){
		CoreHound.effect("button");
		PopupManager.open("LOGIN","AGREEMENT");
	}

	__proto.onAgree=function(){
		CoreHound.effect("button");
		this.btnPhone.disabled=!this.btnAgree.selected;
	}

	__proto.onPhone=function(){
		CoreHound.effect("button");
		if(this.phoneText.text==""){
			Toast.error("请输入手机号！");
			}else if(!this.isPhone(this.phoneText.text)){
			Toast.error("请输入正确的手机号码！");
			}else if(this.keyText.text==""){
			Toast.error("请输入验证码！");
			}else{
			this.loginByPhone(this.phoneText.text,this.keyText.text);
		}
	}

	/**微信登录**/
	__proto.onWeixin=function(){
		ExternalManager.login();
	}

	__proto.onTimer=function(){
		this.time--;
		this.btnKeyObtain.label="("+this.time+")重新获取";
		if(this.time==0){
			this.clearTimer(this,this.onTimer);
			this.btnKeyObtain.disabled=false;
			this.btnKeyObtain.label="获取验证码";
			this.time=60;
		}
	}

	__proto.isPhone=function(str){
		var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
		return myreg.test(str);
	}

	__proto.sendCode=function(phone){
		Auth.instance.sendCode(phone,Handler.create(this,function(data){
		}));
	}

	__proto.loginByPhone=function(phone,code){
		Auth.instance.loginByPhone(phone,code);
	}

	return PhoneView;
})(PhoneUI)


/**
*liuhe
*/
//class game.module.login.popup.RegisterView extends ui.login.popup.RegisterUI
var RegisterView=(function(_super){
	function RegisterView(){
		RegisterView.__super.call(this);
		this.btnConfirm.on("click",this,this.onConfirm);
	}

	__class(RegisterView,'game.module.login.popup.RegisterView',_super);
	var __proto=RegisterView.prototype;
	__proto.onConfirm=function(){
		var _$this=this;
		CoreHound.effect("button");
		if(!this.accountText.text){
			Toast.error("请输入账号");
			}else if(!this.psw1.text){
			Toast.error("请输入密码");
			}else if(!this.psw2.text){
			Toast.error("请输入重复密码");
			}else if(this.psw1.text!=this.psw2.text){
			Toast.error("两次密码输入不一样");
			this.psw1.text="";
			this.psw2.text="";
			}else{
			Auth.instance.accountAdd(this.accountText.text,this.psw1.text,Handler.create(this,function(){
				_$this.accountText.text="";
				_$this.psw1.text="";
				_$this.psw2.text="";
				LoginModel.instance.event("LOGIN");
			}));
		}
	}

	return RegisterView;
})(RegisterUI)



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