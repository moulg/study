
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Alert=game.core.ui.Alert,AudioManager=game.core.manager.AudioManager,BaseModel=game.core.base.BaseModel;
	var BaseModule=game.core.base.BaseModule,CoreHound=game.core.utils.CoreHound,EffectManager=game.core.manager.EffectManager;
	var Event=laya.events.Event,GameID=game.core.enum.GameID,GlobalConfig=game.core.model.GlobalConfig,GlobalEnum=game.core.enum.GlobalEnum;
	var GlobalModel=game.core.model.GlobalModel,GlobalPopup=game.core.enum.GlobalPopup,HallSetUpUI=ui.hall.popup.HallSetUpUI;
	var Handler=laya.utils.Handler,HomeUI=ui.hall.scene.HomeUI,Loader=laya.net.Loader,Module=game.core.enum.Module;
	var PopupManager=game.core.manager.PopupManager,Redirect=game.core.utils.Redirect,SceneManager=game.core.manager.SceneManager;
	var SettingVo=game.core.vo.SettingVo,Signal=game.core.utils.Signal,Skeleton=laya.ani.bone.Skeleton,Sprite=laya.display.Sprite;
	var Storage=game.core.utils.Storage,Toast=game.core.ui.Toast,View=laya.ui.View;
/**
*chenyuan
*/
//class game.module.hall.enum.HallPopup
var HallPopup=(function(){
	function HallPopup(){}
	__class(HallPopup,'game.module.hall.enum.HallPopup');
	HallPopup.SETUP="SETUP";
	return HallPopup;
})()


/**
*chenyuan
*/
//class game.module.hall.enum.HallScene
var HallScene=(function(){
	function HallScene(){}
	__class(HallScene,'game.module.hall.enum.HallScene');
	HallScene.INDEX="INDEX";
	HallScene.RETURNHALL="RETURNHALL";
	return HallScene;
})()


/**
*chenyuan
*/
//class game.module.hall.enum.HallSignal
var HallSignal=(function(){
	function HallSignal(){}
	__class(HallSignal,'game.module.hall.enum.HallSignal');
	HallSignal.START="START";
	HallSignal.SHOW_HOME="SHOW_HOME";
	return HallSignal;
})()


/**
*chenyuan
*/
//class game.module.hall.HallConfig
var HallConfig=(function(){
	function HallConfig(){}
	__class(HallConfig,'game.module.hall.HallConfig');
	HallConfig.getAniUrl=function(name){
		return "res/hall/ani/"+name+".json";
	}

	HallConfig.getSoundUrl=function(name,isMusic){
		(isMusic===void 0)&& (isMusic=false);
		return "res/hall/sound/"+name+GlobalConfig.getSoundExt(isMusic);
	}

	__static(HallConfig,
	['INIT_SKINS',function(){return this.INIT_SKINS=[
		{url:"res/hall/home.json",type:"atlas"},
		{url:"res/hall/xingdian.json",type:"atlas"},
		{url:"res/hall/ani/jinxiujiaose.png",type:"image"}];}
	]);
	return HallConfig;
})()


/**
*chenyuan
*/
//class game.module.hall.utils.HallSound
var HallSound=(function(){
	function HallSound(){}
	__class(HallSound,'game.module.hall.utils.HallSound');
	__getset(1,HallSound,'initSounds',function(){
		var list=[HallSound.getUrl("bg",true)];
		var arr=["button"];
		while(arr&&arr.length){
			list.push(HallSound.getUrl(arr.shift()));
		}
		return list;
	});

	HallSound.init=function(){
		AudioManager.start(HallSound.getUrl("bg",true));
	}

	HallSound.effect=function(str){
		AudioManager.playSound(HallSound.getUrl(str));
	}

	HallSound.getUrl=function(name,isMusic){
		(isMusic===void 0)&& (isMusic=false);
		return GlobalConfig.getSoundUrl(name,isMusic);
	}

	return HallSound;
})()


/**
*chenyuan
*/
//class game.module.hall.HallModel extends game.core.base.BaseModel
var HallModel=(function(_super){
	function HallModel(){
		HallModel.__super.call(this);
	}

	__class(HallModel,'game.module.hall.HallModel',_super);
	var __proto=HallModel.prototype;
	__proto.init=function(data){
		_super.prototype.init.call(this,data);
		this.event("START");
	}

	// }
	__proto.destroy=function(){
		_super.prototype.destroy.call(this);
	}

	__getset(1,HallModel,'instance',function(){
		if(!HallModel._instance)HallModel._instance=new HallModel();
		return HallModel._instance;
	},game.core.base.BaseModel._$SET_instance);

	HallModel._instance=null;
	return HallModel;
})(BaseModel)


//class game.module.hall.HallModule extends game.core.base.BaseModule
var HallModule=(function(_super){
	function HallModule(){
		HallModule.__super.call(this);
		this.isCache=true;
		PopupManager.reg("HALL","SETUP",HallSetUpView);
		SceneManager.reg("HALL","INDEX",IndexView);
		var res=HallConfig.INIT_SKINS;
		res=res.concat(HallSound.initSounds);
		this.init(res);
	}

	__class(HallModule,'game.module.hall.HallModule',_super);
	var __proto=HallModule.prototype;
	__proto.onInit=function(){
		_super.prototype.onInit.call(this);
		HallModel.instance.once("START",this,this.start);
		HallModel.instance.init(this.dataSource);
	}

	__proto.start=function(){
		SceneManager.enter("HALL","INDEX");
		this.initComplete();
	}

	__proto.enter=function(data){
		_super.prototype.enter.call(this,data);
		HallSound.init();
		if(data!="REDIRECT_BACK"){
			HallModel.instance.event("RETURNHALL");
		}
	}

	__proto.remove=function(){
		_super.prototype.remove.call(this);
	}

	__proto.destroy=function(destroyChild){
		(destroyChild===void 0)&& (destroyChild=true);
		laya.display.Sprite.prototype.destroy.call(this,destroyChild);
		HallModel.instance.destroy();
	}

	return HallModule;
})(BaseModule)


/**
*caoheyan
*/
//class game.module.hall.scene.IndexView extends laya.ui.View
var IndexView=(function(_super){
	function IndexView(){
		this._layer=null;
		this._curViewIndex=-1;
		this.classList=[HomeView];
		this.viewList=null;
		IndexView.__super.call(this);
		this._layer=new Sprite();
		this.addChild(this._layer);
		this.viewList=new Array(this.classList.length);
		HallModel.instance.on("SHOW_HOME",this,this.showView,[0]);
		this.showView(0);
	}

	__class(IndexView,'game.module.hall.scene.IndexView',_super);
	var __proto=IndexView.prototype;
	__proto.showView=function(index){
		if(this._curViewIndex==index)return;
		var view=this.viewList[index];
		if(!view){
			view=new this.classList[index]();
			this.viewList[index]=view;
		}
		this._layer.removeChildren();
		if(index==2){
			var home=this.viewList[0];
			this._layer.addChild(home);
		}
		this._layer.addChild(view);
		this._curViewIndex=index;
	}

	__proto.destroy=function(destroyChild){
		(destroyChild===void 0)&& (destroyChild=true);
		_super.prototype.destroy.call(this,destroyChild);
	}

	return IndexView;
})(View)


/**
*liuhe
*/
//class game.module.hall.scene.HomeView extends ui.hall.scene.HomeUI
var HomeView=(function(_super){
	function HomeView(){
		/****子游戏动画移动值***/
		this.gamesAniI=1;
		/****子游戏动画移动对比值***/
		this.gamesAnicC=0;
		/****是否是点击后清除清除子游戏动画***/
		this.gamesAnicS=false;
		HomeView.__super.call(this);
		var _$this=this;
		EffectManager.getSkeleton(GlobalConfig.getAniUrl("shanxian"),Handler.create(this,function(sk){
			sk.pos(30,22);
			_$this.shanxian.addChild(sk);
		}));
		EffectManager.getSkeleton(HallConfig.getAniUrl("jinxiujiaose"),Handler.create(this,function(sk){
			sk.pos(120,666);
			_$this.jinxiujiaose.addChild(sk);
		}));
		Signal.on("SELF_INFO",this,this.onUpdateSelfInfo);
		this.onUpdateSelfInfo();
		this.setGameList();
		this.btnAdd.on("click",this,this.onAddGold);
		this.btnSetUp.on("click",this,this.onSetUp);
		this.btnBack.on("click",this,this.onBack);
		this.avatar.on("click",this,this.onAvatar);
	}

	__class(HomeView,'game.module.hall.scene.HomeView',_super);
	var __proto=HomeView.prototype;
	__proto.onAdd=function(){
		this.timerOnce(5000,this,this.goGamesAni);
	}

	/**************个人信息*****************/
	__proto.onUpdateSelfInfo=function(){
		this.name.text=GlobalModel.instance.self.nickname;
		this.avatar.skin=GlobalModel.instance.self.avatar;
		this.gold.text=GlobalModel.instance.self.gold/GlobalConfig.goldrate+"";
	}

	__proto.onAvatar=function(){
		CoreHound.effect("button");
		GlobalPopup.openUserInfo();
	}

	__proto.onAddGold=function(){
		CoreHound.effect("button");
		GlobalPopup.openShop();
	}

	__proto.onSetUp=function(){
		CoreHound.effect("button");
		PopupManager.open("HALL","SETUP");
	}

	__proto.onBack=function(){
		CoreHound.effect("button");
		Alert.show("\n是否退回登录页？",Handler.create(this,function(isok){
			if(isok){
				Redirect.game(101);
				Storage.clear();
			}
			CoreHound.effect("button");
		}));
	}

	__proto.setGameList=function(){
		var arr=GlobalModel.instance.gameList;
		this.gameList.array=[];
		for (var i=0;i < arr.length;i++){
			this.gameList.array.push({
				logo:{skin:"res/hall/home/game"+arr[i].gameId+"-"+arr[i].gameState+".png"},
				hotSign:{skin:"res/hall/home/hotSign"+arr[i].hotSign+".png"},
				gameId:arr[i].gameId,
				gameState:arr[i].gameState
			});
		}
		this.gameList.hScrollBarSkin=null;
		this.gameList.selectEnable=true;
		this.gameList.scrollBar.elasticBackTime=150;
		this.gameList.scrollBar.elasticDistance=200;
		this.gameList.mouseHandler=Handler.create(this,this.onGameList,null,false);
	}

	__proto.onGameList=function(e,index){
		if(e.type=="click"){
			CoreHound.effect("button");
			if(this.gameList.array[index].gameState==1){
				Redirect.game(this.gameList.array[index].gameId);
				}else{
				Toast.error("游戏未开启，敬请期待");
			}
			}else if(e.type=="mousedown"){
			this.onGamePanelDown();
			}else if(e.type=="mouseup"){
			this.onGamePanelUp();
			}else if(e.type=="mouseout"){
			this.onGamePanelUp();
		}
	}

	/******进入首页子游戏5秒钟滑动一次*******/
	__proto.goGamesAni=function(){
		if(this.gameList.scrollBar.max-this.gameList.scrollBar.value>100){
			this.gamesAniI=1;
			}else{
			this.gamesAniI=-1;
		}
		this.timerLoop(40,this,this.onGamesAni);
	}

	/****子游戏滑动效果*****/
	__proto.onGamesAni=function(){
		this.gameList.scrollBar.value+=this.gamesAniI;
		this.gamesAnicC++;
		if(this.gamesAnicC==100){
			this.gamesAniI=-this.gamesAniI;
			this.gamesAnicC=0;
		}
	}

	/**点击子游戏清除效果**/
	__proto.onGamePanelDown=function(){
		this.clearTimer(this,this.onGamesAni);
		this.gamesAnicS=true;
	}

	/**点击子游戏后执行5秒后执行效果**/
	__proto.onGamePanelUp=function(){
		if(this.gamesAnicS){
			this.timerOnce(5000,this,this.goGamesAni);
			this.gamesAnicS=false;
		}
	}

	/**在显示列表中被移除**/
	__proto.onRemov=function(){
		this.clearTimer(this,this.goGamesAni);
		this.clearTimer(this,this.onGamesAni);
	}

	__proto.destroy=function(destroyChild){
		(destroyChild===void 0)&& (destroyChild=true);
		laya.ui.View.prototype.destroy.call(this,destroyChild);
	}

	return HomeView;
})(HomeUI)


/**
*liuhe
*/
//class game.module.hall.popup.HallSetUpView extends ui.hall.popup.HallSetUpUI
var HallSetUpView=(function(_super){
	function HallSetUpView(){
		this._status=null;
		this._data=null;
		HallSetUpView.__super.call(this);
		this.musicNum.changeHandler=Handler.create(this,this.onMusicNums,null,false);
		this.effectNum.changeHandler=Handler.create(this,this.onEffectNum,null,false);
		this.btnMusic.on("click",this,this.onMusic);
		this.btnEffect.on("click",this,this.onEffect);
		this.btnClose.on("click",this,this.onClose);
	}

	__class(HallSetUpView,'game.module.hall.popup.HallSetUpView',_super);
	var __proto=HallSetUpView.prototype;
	__proto.onOpened=function(){
		this._data=AudioManager.data;
		this._status=JSON.stringify(this._data);
		this.musicNum.value=this._data.musicVolume;
		this.effectNum.value=this._data.soundVolume;
		this.btnMusic.selected=this._data.musicOff;
		this.btnEffect.selected=this._data.soundOff;
	}

	__proto.onClose=function(){
		CoreHound.effect("button");
		this.close();
	}

	__proto.onMusic=function(){
		this._data.musicOff=this.btnMusic.selected;
		this.voice();
	}

	__proto.onEffect=function(){
		this._data.soundOff=this.btnEffect.selected;
		this.voice();
	}

	__proto.onMusicNums=function(){
		this._data.musicVolume=this.musicNum.value;
		this.voice();
	}

	__proto.onEffectNum=function(){
		this._data.soundVolume=this.effectNum.value;
		this.voice();
	}

	__proto.voice=function(){
		var status=JSON.stringify(this._data);
		if(status!=this._status){
			this._status=status;
			AudioManager.update(this._data);
		}
	}

	return HallSetUpView;
})(HallSetUpUI)



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