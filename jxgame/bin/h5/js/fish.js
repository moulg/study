
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Animation=laya.display.Animation,AudioManager=game.core.manager.AudioManager,BaseModel=game.core.base.BaseModel;
	var BaseModule=game.core.base.BaseModule,Box=laya.ui.Box,Browser=laya.utils.Browser,Button=laya.ui.Button;
	var ColorFilter=laya.filters.ColorFilter,CoreHound=game.core.utils.CoreHound,Dialog=laya.ui.Dialog,Ease=laya.utils.Ease;
	var EffectManager=game.core.manager.EffectManager,Event=laya.events.Event,FishAlertUI=ui.fish.popup.FishAlertUI;
	var FishHelpUI=ui.fish.popup.FishHelpUI,FishSceneUI=ui.fish.scene.FishSceneUI,FontClip=laya.ui.FontClip,GlobalConfig=game.core.model.GlobalConfig;
	var GlobalEnum=game.core.enum.GlobalEnum,GlobalModel=game.core.model.GlobalModel,GlobalPopup=game.core.enum.GlobalPopup;
	var Handler=laya.utils.Handler,Image=laya.ui.Image,Label=laya.ui.Label,Layer=game.core.utils.Layer,Loader=laya.net.Loader;
	var Module=game.core.enum.Module,Point=laya.maths.Point,PopupManager=game.core.manager.PopupManager,Redirect=game.core.utils.Redirect;
	var RewardUI=ui.fish.popup.RewardUI,RoomViewUI=ui.fish.scene.RoomViewUI,SceneManager=game.core.manager.SceneManager;
	var SettingUI=ui.fish.popup.SettingUI,SettingVo=game.core.vo.SettingVo,ShopUI=ui.common.popup.ShopUI,Signal=game.core.utils.Signal;
	var Skeleton=laya.ani.bone.Skeleton,Sprite=laya.display.Sprite,Toast=game.core.ui.Toast,Tween=laya.utils.Tween;
	var UIConfig=Laya.UIConfig,View=laya.ui.View;
/**
*chenyuan
*/
//class game.module.fish.enum.FishPopup
var FishPopup=(function(){
	function FishPopup(){}
	__class(FishPopup,'game.module.fish.enum.FishPopup');
	FishPopup.SETUP="SETUP";
	FishPopup.HELP="HELP";
	FishPopup.REWARD="REWARD";
	return FishPopup;
})()


/**
*chenyuan
*/
//class game.module.fish.enum.FishScene
var FishScene=(function(){
	function FishScene(){}
	__class(FishScene,'game.module.fish.enum.FishScene');
	FishScene.FISH="FISH";
	FishScene.FISHHOME="FISHHOME";
	FishScene.ROOMVIEW="ROOMVIEW";
	FishScene.FISHVIEW="FISHVIEW";
	return FishScene;
})()


/**
*chenyuan
*/
//class game.module.fish.enum.FishSignal
var FishSignal=(function(){
	function FishSignal(){}
	__class(FishSignal,'game.module.fish.enum.FishSignal');
	FishSignal.START="START";
	FishSignal.ROOMLIST="ROOMLIST";
	FishSignal.NEWFISH="NEWFISH";
	FishSignal.ALLFISH="ALLFISH";
	FishSignal.NEWSCENE="NEWSCENE";
	FishSignal.CURSCENE="CURSCENE";
	FishSignal.NEWBULLET="NEWBULLET";
	FishSignal.NEWUSER="NEWUSER";
	FishSignal.ALLUSER="ALLUSER";
	FishSignal.NEWBATTERY="NEWBATTERY";
	FishSignal.LOCKFISH="LOCKFISH";
	FishSignal.QLOCKFISH="QLOCKFISH";
	FishSignal.USERPROP="USERPROP";
	FishSignal.OFFLINE="OFFLINE";
	FishSignal.ENTERFINISHED="ENTERFINISHED";
	FishSignal.REWARD="REWARD";
	return FishSignal;
})()


/**
*chenyuan
*/
//class game.module.fish.FishConfig
var FishConfig=(function(){
	function FishConfig(){}
	__class(FishConfig,'game.module.fish.FishConfig');
	/**捕鱼游戏的宽**/
	__getset(1,FishConfig,'GAME_WIDTH',function(){
		return 1920;
	});

	/**捕鱼游戏的高**/
	__getset(1,FishConfig,'GAME_HEIGHT',function(){
		return 1080;
	});

	/**入场提示动画**/
	__getset(1,FishConfig,'sceneAni',function(){
		return "Ani/aniScene.ani";
	});

	/**水纹动画**/
	__getset(1,FishConfig,'waterWave',function(){
		return "Ani/aniWaterWave.ani";
	});

	/**按钮走光动画**/
	__getset(1,FishConfig,'runLight',function(){
		return "Ani/aniRunLight.ani";
	});

	/**子弹动画路径**/
	__getset(1,FishConfig,'bulletUrl',function(){
		return "Ani/aniBullet.ani";
	});

	/**道具动画**/
	__getset(1,FishConfig,'propAction',function(){
		return "Ani/aniProp.ani";
	});

	/**核弹资源**/
	__getset(1,FishConfig,'bomUrl',function(){
		return "res/fish/textures/hedan.png";
	});

	/**渔网动画路径**/
	__getset(1,FishConfig,'fishNetUrl',function(){
		return "Ani/aniNet.ani";
	});

	FishConfig.getRoomNameUrl=function(index){
		return "res/fish/room/num"+index+".png";
	}

	FishConfig.getRoomIconUrl=function(index){
		return "res/fish/room/icon"+index+".png";
	}

	FishConfig.getRoomStrokeColor=function(index){
		var stroke=['#1c5914','#5d308f','#865804'];
		return stroke[index]||'';
	}

	FishConfig.getSoundUrl=function(name){
		return "res/fish/sound/"+name;
	}

	FishConfig.getBgSoundUrl=function(name){
		return "res/fish/sound/bg"+name+".mp3";
	}

	FishConfig.getNumPic=function(idnex){
		var url={gold:"res/fish/textures/goldnum.png",
			tip:"res/fish/spine/nizhenniu.json"};
		return url[idnex];
	}

	FishConfig.getSpineAni=function(idnex){
		var url={0:"res/fish/spine/chongzhi.json",
			1:"res/fish/spine/nizhenniu.json",
			2:"res/fish/spine/taibangle.json",
			3:"res/fish/spine/zhuanfanla.json",
			4:"res/fish/spine/baofula.json"};
		return url[idnex];
	}

	FishConfig.getBatteryPipUrl=function(index){
		var url={1:"res/fish/battery/bow2_1.png",
			2:"res/fish/battery/bow2_1.png",
			3:"res/fish/battery/bow2_1.png",
			4:"res/fish/battery/bow2_1.png",
			5:"res/fish/battery/bow2_2.png",
			6:"res/fish/battery/bow2_2.png",
			7:"res/fish/battery/bow2_2.png",
			8:"res/fish/battery/bow2_3.png",
			9:"res/fish/battery/bow2_3.png",
			10:"res/fish/battery/bow2_3.png"};
		return url[index];
	}

	FishConfig.getBatteryUrl=function(index){
		var url={1:"res/fish/battery/bow1_1.png",
			2:"res/fish/battery/bow1_1.png",
			3:"res/fish/battery/bow1_1.png",
			4:"res/fish/battery/bow1_1.png",
			5:"res/fish/battery/bow1_2.png",
			6:"res/fish/battery/bow1_2.png",
			7:"res/fish/battery/bow1_2.png",
			8:"res/fish/battery/bow1_3.png",
			9:"res/fish/battery/bow1_3.png",
			10:"res/fish/battery/bow1_3.png"};
		return url[index];
	}

	FishConfig.getBatterySound=function(index){
		var url={1:"bulFire.mp3",
			2:"bulFire.mp3",
			3:"bulFire.mp3",
			4:"bulFire.mp3",
			5:"bulEff.mp3",
			6:"bulEff.mp3",
			7:"bulEff.mp3",
			8:"bulFla.mp3",
			9:"bulFla.mp3",
			10:"bulFla.mp3"};
		return url[index];
	}

	FishConfig.getFishNetName=function(index){
		var url={1:"net1_1",
			2:"net1_1",
			3:"net1_1",
			4:"net1_1",
			5:"net2_1",
			6:"net2_1",
			7:"net2_1",
			8:"net3_1",
			9:"net3_1",
			10:"net3_1"};
		return url[index];
	}

	FishConfig.getBulletName=function(index){
		var url={1:"ani1",
			2:"ani1",
			3:"ani1",
			4:"ani1",
			5:"ani2",
			6:"ani2",
			7:"ani2",
			8:"ani3",
			9:"ani3",
			10:"ani3"};
		return url[index];
	}

	FishConfig.getBulletNum=function(index){
		var url={1:1,
			2:1,
			3:1,
			4:1,
			5:2,
			6:2,
			7:2,
			8:3,
			9:3,
			10:3};
		return url[index];
	}

	__static(FishConfig,
	['INIT_SKINS',function(){return this.INIT_SKINS=[
		{url:"res/fish/image/bg1.jpg",type:"image"},{url:"res/fish/image/bg2.jpg",type:"image"},
		{url:"res/fish/image/bg3.jpg",type:"image"},{url:"res/fish/image/bg4.jpg",type:"image"},
		{url:"res/fish/image/bg5.jpg",type:"image"},{url:"res/fish/image/bg6.jpg",type:"image"},
		{url:"res/fish/res/res03.json",type:"atlas"},{url:"res/fish/res/res16.json",type:"atlas"},
		{url:"res/fish/res/res04.json",type:"atlas"},{url:"res/fish/res/res05.json",type:"atlas"},
		{url:"res/fish/res/res06.json",type:"atlas"},{url:"res/fish/res/res07.json",type:"atlas"},
		{url:"res/fish/res/res08.json",type:"atlas"},{url:"res/fish/res/res09.json",type:"atlas"},
		{url:"res/fish/res/res10.json",type:"atlas"},{url:"res/fish/res/res11.json",type:"atlas"},
		{url:"res/fish/res/res12.json",type:"atlas"},{url:"res/fish/res/res13.json",type:"atlas"},
		{url:"res/fish/res/res14.json",type:"atlas"},{url:"res/fish/res/res15.json",type:"atlas"},
		{url:"res/fish/battery.json",type:"atlas"},{url:"res/fish/textures.json",type:"atlas"},
		{url:"res/fish/bullet.json",type:"atlas"},{url:"res/fish/net.json",type:"atlas"},
		{url:"res/fish/room.json",type:"atlas"},{url:"res/fish/gold.json",type:"atlas"},
		{url:"res/fish/here.json",type:"atlas"},{url:"res/fish/lock.json",type:"atlas"},
		{url:"res/fish/btnLight.json",type:"atlas"},{url:"res/fish/spine/chongzhi/chongzhi.png",type:"image"},
		{url:"res/fish/spine/baofula.png",type:"image"},{url:"res/fish/spine/nizhenniu.png",type:"image"},
		{url:"res/fish/spine/taibangle.png",type:"image"},{url:"res/fish/spine/zhuanfanla.png",type:"image"},
		{url:"res/fish/waterWave.json",type:"atlas"},{url:"res/fish/prop/ice.json",type:"atlas"},
		{url:"res/fish/prop/bom.json",type:"atlas"},{url:"res/fish/prop/flash.json",type:"atlas"},
		{url:"res/fish/bubble.json",type:"atlas"},{url:"res/fish/weave.json",type:"atlas"},
		{url:"Ani/aniFish.ani",type:"json"},{url:"Ani/aniScene.ani",type:"json"},
		{url:"Ani/aniNet.ani",type:"json"},{url:"Ani/aniBullet.ani",type:"json"},
		{url:"Ani/aniGold.ani",type:"json"},{url:"Ani/aniRunLight.ani",type:"json"},
		{url:"Ani/aniWaterWave.ani",type:"json"},{url:"Ani/aniProp.ani",type:"json"},];},'SCENE_CONFIG',function(){return this.SCENE_CONFIG={
			1:{id:1,res:"res/fish/image/bg%d.jpg"},
			2:{id:2,res:"res/fish/image/bg%d.jpg"},
			3:{id:3,res:"res/fish/image/bg%d.jpg"},
			4:{id:4,res:"res/fish/image/bg%d.jpg"},
			5:{id:5,res:"res/fish/image/bg%d.jpg"},
			6:{id:6,res:"res/fish/image/bg%d.jpg"}
			};},'FISH_CONFIG',function(){return this.FISH_CONFIG={
			1:{type:1,desc:"泥鳅",res:"Ani/aniFish.ani",aani:{key:"fish1_1",interval:128,loop:-1},dani:{key:"fish1_2",interval:128,loop:10},ice:0.5,bonding_box:[{r:16,a:0,b:0}]},
			2:{type:2,desc:"蝴蝶鱼",res:"Ani/aniFish.ani",aani:{key:"fish2_1",interval:152,loop:-1},dani:{key:"fish2_2",interval:24,loop:10},ice:0.6,bonding_box:[{r:30,a:0,b:0}]},
			3:{type:3,desc:"小丑鱼",res:"Ani/aniFish.ani",aani:{key:"fish3_1",interval:64,loop:-1},dani:{key:"fish3_2",interval:100,loop:10},ice:0.9,bonding_box:[{r:55,a:0,b:0}]},
			4:{type:4,desc:"河豚",res:"Ani/aniFish.ani",aani:{key:"fish4_1",interval:256,loop:-1},dani:{key:"fish4_2",interval:23,loop:10},ice:0.6,bonding_box:[{r:30,a:0,b:0}]},
			5:{type:5,desc:"大眼鱼",res:"Ani/aniFish.ani",aani:{key:"fish5_1",interval:133,loop:-1},dani:{key:"fish5_2",interval:16,loop:10},ice:0.9,bonding_box:[{r:35,a:0,b:0}]},
			6:{type:6,desc:"花斑鱼",res:"Ani/aniFish.ani",aani:{key:"fish6_1",interval:152,loop:-1},dani:{key:"fish6_2",interval:16,loop:10},ice:0.9,bonding_box:[{r:40,a:0,b:0}]},
			7:{type:7,desc:"海马",res:"Ani/aniFish.ani",aani:{key:"fish7_1",interval:152,loop:-1},dani:{key:"fish7_2",interval:16,loop:10},ice:0.9,bonding_box:[{r:30,a:0,b:0}]},
			8:{type:8,desc:"青蛙",res:"Ani/aniFish.ani",aani:{key:"fish8_1",interval:152,loop:-1},dani:{key:"fish8_2",interval:16,loop:10},ice:0.9,bonding_box:[{r:54,a:0,b:0}]},
			9:{type:9,desc:"乌龟",res:"Ani/aniFish.ani",aani:{key:"fish9_1",interval:64,loop:-1},dani:{key:"fish9_2",interval:30,loop:10},ice:1.5,bonding_box:[{r:67,a:0,b:0}]},
			10:{type:10,desc:"虾",res:"Ani/aniFish.ani",aani:{key:"fish10_1",interval:25,loop:-1},dani:{key:"fish10_2",interval:25,loop:10},ice:1.0,bonding_box:[{r:45,a:0,b:0}]},
			11:{type:11,desc:"草鱼",res:"Ani/aniFish.ani",aani:{key:"fish11_1",interval:190,loop:-1},dani:{key:"fish11_2",interval:24,loop:10},ice:1.5,bonding_box:[{r:40,a:-40,b:0},{r:50,a:58,b:0}]},
			12:{type:12,desc:"金龙",res:"Ani/aniFish.ani",aani:{key:"fish12_1",interval:112,loop:-1},dani:{key:"fish12_2",interval:210,loop:1},ice:2.2,bonding_box:[{r:80,a:55,b:0},{r:30,a:-80,b:0}]},
			13:{type:13,desc:"银龙",res:"Ani/aniFish.ani",aani:{key:"fish13_1",interval:112,loop:-1},dani:{key:"fish13_2",interval:210,loop:1},ice:2.2,bonding_box:[{r:30,a:130,b:0},{r:80,a:0,b:0},{r:30,a:-130,b:0}]},
			14:{type:14,desc:"尖嘴鱼",res:"Ani/aniFish.ani",aani:{key:"fish14_1",interval:152,loop:-1},dani:{key:"fish14_2",interval:8,loop:10},ice:2.2,bonding_box:[{r:40,a:127,b:5},{r:55,a:22,b:0},{r:40,a:-78,b:-1}]},
			15:{type:15,desc:"蝙蝠鱼",res:"Ani/aniFish.ani",aani:{key:"fish15_1",interval:285,loop:-1},dani:{key:"fish15_2",interval:27,loop:10},ice:2.2,bonding_box:[{r:85,a:53,b:0},{r:35,a:-80,b:0}]},
			16:{type:16,desc:"小海豚",res:"Ani/aniFish.ani",aani:{key:"fish16_1",interval:152,loop:-1},dani:{key:"fish16_2",interval:30,loop:10},ice:3.0,bonding_box:[{r:110,a:-122,b:-10},{r:130,a:130,b:0}]},
			17:{type:17,desc:"大白鲨",res:"Ani/aniFish.ani",aani:{key:"fish17_1",interval:152,loop:-1},dani:{key:"fish17_2",interval:19,loop:10},ice:3.0,bonding_box:[{r:110,a:110,b:0},{r:80,a:-70,b:0}]},
			18:{type:18,desc:"美人鱼",res:"Ani/aniFish.ani",aani:{key:"fish18_1",interval:300,loop:-1},dani:{key:"fish18_2",interval:80,loop:10},ice:3.0,bonding_box:[{r:110,a:110,b:0},{r:80,a:-70,b:0}]},
			19:{type:19,desc:"金蟾",res:"Ani/aniFish.ani",aani:{key:"fish19_1",interval:340,loop:-1},dani:{key:"fish19_2",interval:24,loop:5},ice:3.0,bonding_box:[{r:125,a:0,b:0}]},
			20:{type:20,desc:"黄金鱼",res:"Ani/aniFish.ani",aani:{key:"fish20_1",interval:285,loop:-1},dani:{key:"fish20_2",interval:8,loop:10},ice:3.3,bonding_box:[{r:160,a:120,b:0},{r:120,a:-150,b:0}]},
			21:{type:21,desc:"全屏炸弹",res:"Ani/aniFish.ani",aani:{key:"fish21_1",interval:345,loop:-1},dani:{key:"fish21_2",interval:80,loop:1},ice:3.3,bonding_box:[{r:160,a:120,b:0},{r:120,a:-150,b:0}]},
			22:{type:22,desc:"绿草鱼",res:"Ani/aniFish.ani",aani:{key:"fish22_1",interval:345,loop:-1},dani:{key:"fish22_2",interval:120,loop:10},ice:2.0,bonding_box:[{r:80,a:0,b:0}]},
			23:{type:23,desc:"J币",res:"Ani/aniFish.ani",aani:{key:"fish23_1",interval:180,loop:-1},dani:{key:"fish23_2",interval:24,loop:5},ice:2.0,bonding_box:[{r:100,a:0,b:0}]}
			};},'BATTERY_CONFIG',function(){return this.BATTERY_CONFIG={
			1:{id:1,res:["res/fish/battery/paozuo.png","res/fish/battery/goldflat.png","res/fish/battery/dda.png","res/fish/battery/add.png","res/fish/battery/waitEnter.png"],music_eff:{1:"",2:""},fangle:90,bangle:180,bgangle:180,pos:{x:1493,y:81},scorepos:{x:1493+300,y:81},linea:"res/fish/lock/lock_1.png",line:"res/fish/lock/lock_1_1.png"},
			2:{id:2,res:["res/fish/battery/paozuo.png","res/fish/battery/goldflat.png","res/fish/battery/dda.png","res/fish/battery/add.png","res/fish/battery/waitEnter.png"],music_eff:{1:"",2:""},fangle:90,bangle:180,bgangle:180,pos:{x:422,y:81},scorepos:{x:422+300,y:81},linea:"res/fish/lock/lock_2.png",line:"res/fish/lock/lock_2_1.png"},
			3:{id:3,res:["res/fish/battery/paozuo.png","res/fish/battery/goldflat.png","res/fish/battery/dda.png","res/fish/battery/add.png","res/fish/battery/waitEnter.png"],music_eff:{1:"",2:""},fangle:90,bangle:0,bgangle:0,pos:{x:1493,y:1003},scorepos:{x:1493,y:1003},linea:"res/fish/lock/lock_3.png",line:"res/fish/lock/lock_3_1.png"},
			4:{id:4,res:["res/fish/battery/paozuo.png","res/fish/battery/goldflat.png","res/fish/battery/dda.png","res/fish/battery/add.png","res/fish/battery/waitEnter.png"],music_eff:{1:"",2:""},fangle:90,bangle:0,bgangle:0,pos:{x:422,y:1003},scorepos:{x:422,y:1003},linea:"res/fish/lock/lock_4.png",line:"res/fish/lock/lock_4_1.png"}
			};},'BULLET_CONFIG',function(){return this.BULLET_CONFIG={
			1:{bul:"aniBullet.ani",anet:"aniNet.ani"}
			};},'PROP_CONFIG',function(){return this.PROP_CONFIG={
	};}

	]);
	return FishConfig;
})()


/**
*chenyuan
*/
//class game.module.fish.popup.FishAlert
var FishAlert=(function(){
	function FishAlert(){}
	__class(FishAlert,'game.module.fish.popup.FishAlert');
	FishAlert.show=function(msg,callback,isShowClose,isLayerClose,isCloseOtherPopup,isModal,leading){
		(isShowClose===void 0)&& (isShowClose=true);
		(isLayerClose===void 0)&& (isLayerClose=true);
		(isCloseOtherPopup===void 0)&& (isCloseOtherPopup=false);
		(isModal===void 0)&& (isModal=true);
		(leading===void 0)&& (leading=0);
		if(!FishAlert._ui){
			FishAlert._ui=new FishAlertUI();
			FishAlert._ui.close.on("click",null,FishAlert.close,["close"]);
			FishAlert._ui.enterBtn.on("click",null,FishAlert.close,["ok"]);
			FishAlert._ui.closeBtn.on("click",null,FishAlert.close,["close"]);
			FishAlert._leading=FishAlert._ui.text.leading;
			FishAlert._enterBtnX=FishAlert._ui.enterBtn.centerX;
		}
		FishAlert._callback=callback;
		FishAlert._isLayerClose=isLayerClose;
		FishAlert._ui.closeBtn.visible=isShowClose;
		if(isShowClose){
			FishAlert._ui.enterBtn.centerX=FishAlert._enterBtnX;
			}else{
			FishAlert._ui.enterBtn.centerX=0;
		}
		FishAlert._ui.text.leading=leading||FishAlert._leading;
		FishAlert._ui.text.text=msg;
		var sw=Laya.stage.width;
		var sh=Laya.stage.height;
		if(isCloseOtherPopup)PopupManager.closeAll();
		if(isModal){
			if(!FishAlert._mask){
				FishAlert._mask=new Sprite();
				FishAlert._mask.size(sw,sh);
				FishAlert._mask.graphics.drawRect(0,0,FishAlert._mask.width,FishAlert._mask.height,UIConfig.popupBgColor);
				FishAlert._mask.alpha=UIConfig.popupBgAlpha;
			}
			Layer.alert.addChild(FishAlert._mask);
		}
		Layer.alert.addChild(FishAlert._ui);
		FishAlert._ui.x=Math.round(((sw-FishAlert._ui.width)>>1)+FishAlert._ui.pivotX);
		FishAlert._ui.y=Math.round(((sh-FishAlert._ui.height)>>1)+FishAlert._ui.pivotY);
		FishAlert._ui.scale(1,1);
		Tween.from(FishAlert._ui,{x:sw/2,y:sh/2,scaleX:0,scaleY:0},300,Ease.backOut);
	}

	FishAlert.close=function(type){
		if(!FishAlert._isLayerClose&&type=="cancel")return;
		Tween.to(FishAlert._ui,{x:Laya.stage.width/2,y:Laya.stage.height/2,scaleX:0,scaleY:0},300,Ease.strongOut,Handler.create(null,function(){
			if(FishAlert._callback)FishAlert._callback.runWith(type=="ok");
			if(FishAlert._mask)FishAlert._mask.removeSelf();
			FishAlert._ui.removeSelf();
		}));
	}

	FishAlert._ui=null;
	FishAlert._mask=null;
	FishAlert._callback=null;
	FishAlert._isLayerClose=false;
	FishAlert._leading=NaN;
	FishAlert._enterBtnX=0;
	return FishAlert;
})()


/**
*chenyuan
*/
//class game.module.fish.utils.FishSound
var FishSound=(function(){
	function FishSound(){}
	__class(FishSound,'game.module.fish.utils.FishSound');
	__getset(1,FishSound,'initSounds',function(){
		return [];
	});

	FishSound.init=function(index){
		var url=FishConfig.getBgSoundUrl(index);
		AudioManager.start(url);
	}

	FishSound.effect=function(str){
		var url=FishConfig.getSoundUrl(str);
		AudioManager.playSound(url);
	}

	return FishSound;
})()


//class game.module.fish.vo.BatteryManager
var BatteryManager=(function(){
	var SingletonEnforcer;
	function BatteryManager(enforcer){
		this._panel=null;
		this._object=[];
		this._batPos=[];
		if(!enforcer)throw new console.log("Singleton Error");
	}

	__class(BatteryManager,'game.module.fish.vo.BatteryManager');
	var __proto=BatteryManager.prototype;
	__proto.destroy=function(){
		BatteryManager._instance=null;
	}

	__proto.init=function(panel){
		this._panel=panel;
		if(this._panel){
			}else{
			return;
		}
		for(var battery_config in FishConfig.BATTERY_CONFIG){
			var config=FishConfig.BATTERY_CONFIG[battery_config];
			if(config){
				var battery=new Battery(config);
				this._panel.addChild(battery);
				this._object.push(battery);
			}
		}
	}

	//显示对应位置炮台
	__proto.createBattery=function(bInfo){
		var battery=this._object[parseInt(bInfo.chairid)];
		if(battery){
			battery.come();
			battery.self=bInfo.isSelf;
			battery.name=bInfo.name;
			battery.score=bInfo.score;
			battery.playerId=bInfo.id;
			if(battery.self){
				battery.runTips();
			}
		}
	}

	//切换炮台
	__proto.newBattery=function(batteryMultiple,chairID){
		var bat=this._object[chairID];
		if(bat){
			bat.multiple=batteryMultiple;
			bat.speed=FishModel.instance.bulletSpeed;
			bat.chairdID=chairID;
		}
	}

	//
	__proto.newRotation=function(selfIndex){
		for(var i=0;i<this._object.length;i++){
			var bat=this._object[i];
			if(bat){
				if(selfIndex<=1){
					bat.newRotationBg(180);
				}
				else {
					bat.newRotationBg(0);
				}
				if(selfIndex<=1){
					if(i>1){
						bat.newRotationMul(180);
						}else{
						bat.newRotationMul(0);
					}
					}else{
					if(i>1){
						bat.newRotationMul(0);
						}else{
						bat.newRotationMul(180);
					}
				}
				if(selfIndex<=1){
					if(i==3){
						bat.newRotationPosX(125);
					}
					}else{
					if(i==0){
						bat.newRotationPosX(-125);
					}
				}
			}
		}
	}

	//
	__proto.autoFire=function(enable){
		for(var i=0;i<this._object.length;i++){
			var bat=this._object[i];
			if(bat&&bat.self){
				bat.autoFire=enable;
				return;
			}
		}
	}

	__proto.autoLock=function(enable){
		for(var i=0;i<this._object.length;i++){
			var bat=this._object[i];
			if(bat&&bat.self){
				bat.autoLock=enable;
				if(!enable)bat.setQlockFish();
				return;
			}
		}
	}

	__proto.lockFish=function(chirdId,fishId){
		(fishId===void 0)&& (fishId="");
		var bat=this._object[chirdId];
		if(bat){
			bat.lockFish=fishId;
			if(""!=fishId){
				bat.autoLock=true;
			}
			else{
				bat.autoLock=false;
			}
		}
	}

	//提示动画
	__proto.runTips=function(){
		for(var i=0;i<this._object.length;i++){
			var bat=this._object[i];
			if(bat&&bat.self){
				bat.runTips();
				return;
			}
		}
	}

	//自己开炮发射子弹
	__proto.reqbatteryFire=function(pos){
		for(var i=0;i<this._object.length;i++){
			var bat=this._object[i];
			if(bat&&bat.self&&FishModel.instance.changing==false){
				bat.reqfire(pos);
				return;
			}
		}
	}

	//其他人开炮发射子弹
	__proto.batteryFire=function(bInfo){
		var bat=this._object[parseInt(bInfo.chairID)];
		if(bat){
			bat.fireAngle(bInfo);
			bat.score=bInfo.score;
		}
	}

	//获取炮台
	__proto.getbattery=function(playerId){
		for(var i=0;i<this._object.length;i++){
			var bat=this._object[i];
			if(bat&&bat.playerId==playerId){
				return bat;
			}
		}
		return null;
	}

	//获取炮台
	__proto.updateBatteryScore=function(playerId,score){
		for(var i=0;i<this._object.length;i++){
			var bat=this._object[i];
			if(bat&&bat.playerId==playerId){
				bat.score=parseInt(score);
			}
		}
	}

	__proto.destroyAllBattery=function(){
		for(var i=0;i<this._object.length;i++){
			var bat=this._object[i];
			if(bat){
				bat.reset();
			}
		}
	}

	__proto.destroybattery=function(playerId){
		for(var i=0;i<this._object.length;i++){
			var bat=this._object[i];
			if(bat&&bat.playerId==playerId){
				bat.reset();
			}
		}
	}

	//炮台刷新
	__proto.update=function(){
		for(var i=0;i<this._object.length;i++){
			var bat=this._object[i];
			if(bat&&bat._batteryNode.visible){
				bat.update();
			}
		}
	}

	__getset(0,__proto,'lockList',null,function(list){
		for(var i=0;i<this._object.length;i++){
			var bat=this._object[i];
			if(bat){
				bat.lockList=list;
			}
		}
	});

	__getset(1,BatteryManager,'Instance',function(){
		if(!BatteryManager._instance)BatteryManager._instance=new BatteryManager(new SingletonEnforcer());
		return BatteryManager._instance;
	});

	BatteryManager._instance=null;
	BatteryManager.__init$=function(){
		//
		//class SingletonEnforcer
		SingletonEnforcer=(function(){
			function SingletonEnforcer(){}
			__class(SingletonEnforcer,'');
			return SingletonEnforcer;
		})()
	}

	return BatteryManager;
})()


//class game.module.fish.vo.BulletManager
var BulletManager=(function(){
	var SingletonEnforcer;
	function BulletManager(enforcer){
		this._panel=null;
		this._object=[];
		this._objectBBx=[];
		if(!enforcer)throw new console.log("Singleton Error");
	}

	__class(BulletManager,'game.module.fish.vo.BulletManager');
	var __proto=BulletManager.prototype;
	__proto.destroy=function(){
		BulletManager._instance=null;
	}

	__proto.init=function(panel){
		this._panel=panel;
		if(this._panel){
			}else{
			return;
		}
	}

	//创建并发射子弹（...）
	__proto.send=function(bInfo){
		var bul=new Bullet(bInfo);
		this._panel.addChild(bul);
		this._object[bInfo.bulletId]=bul;
		this._objectBBx[bInfo.bulletId]=bul.BBX;
	}

	__proto.shotSomething=function(id){
		var bullt=this._object[id];
		if(bullt){
			bullt.shotSomething();
			this._object[id]=null;
			this._objectBBx[id]=null;
		}
	}

	//子弹刷新
	__proto.update=function(){
		var count=0;
		for(var i=0 in this._object){
			var obj=this._object[i];
			if(obj){
				count++;
				obj.update();
				this._objectBBx[i]=obj.BBX;
			}
		}
		return count;
	}

	__proto.clearBullets=function(){
		for(var i=0 in this._object){
			var obj=this._object[i];
			if(obj){
				obj.removeSelf();
				this._object[i]=null;
				this._objectBBx[i]=null;
			}
		}
		this._object=[];
		this._objectBBx=[];
	}

	__getset(0,__proto,'bulletes',function(){
		return this._object;
	});

	__getset(1,BulletManager,'Instance',function(){
		if(!BulletManager._instance)BulletManager._instance=new BulletManager(new SingletonEnforcer());
		return BulletManager._instance;
	});

	BulletManager._instance=null;
	BulletManager.__init$=function(){
		//
		//class SingletonEnforcer
		SingletonEnforcer=(function(){
			function SingletonEnforcer(){}
			__class(SingletonEnforcer,'');
			return SingletonEnforcer;
		})()
	}

	return BulletManager;
})()


//class game.module.fish.vo.CollideManager
var CollideManager=(function(){
	var SingletonEnforcer;
	//碰撞检测
	function CollideManager(enforcer){
		if(!enforcer)throw new console.log("Singleton Error");
	}

	__class(CollideManager,'game.module.fish.vo.CollideManager');
	var __proto=CollideManager.prototype;
	__proto.destroy=function(){
		CollideManager._instance=null;
	}

	//子弹刷新
	__proto.update=function(){
		var count=0;
		var fish_lst=[];
		var bullt_lst=BulletManager.Instance.bulletes;
		for(var bulltindex in bullt_lst){
			var bullet=bullt_lst[bulltindex];
			if(bullet){
				var bbx=bullet.BBX;
				var bat=BatteryManager.Instance.getbattery(bullet.playerID);
				if(bat&&bat.lockFish!=""&&bullet.lockFish!=""){
					var fish=FishManager.Instance.getfisheById(bat.lockFish);
					if(fish&&bat.lockFish==bullet.lockFish){
						if(fish.isCatched(bbx)){
							fish_lst.push({bulletID:bullet.bulletID,fishID:fish.fishID,playerID:bullet.playerID});
						}
						}else{
						var fishO1=FishManager.Instance.catchFishByBBX(bbx);
						count+=fishO1.count;
						if(fishO1.fish){
							fish_lst.push({bulletID:bullet.bulletID,fishID:fishO1.fish.fishID,playerID:bullet.playerID});
						}
					}
					}else{
					var fishO2=FishManager.Instance.catchFishByBBX(bbx);
					count+=fishO2.count;
					if(fishO2.fish){
						fish_lst.push({bulletID:bullet.bulletID,fishID:fishO2.fish.fishID,playerID:bullet.playerID});
					}
				}
			}
		}
		for(var i=0 in fish_lst){
			var item=fish_lst[i];
			if(item){
				var userInfo=FishModel.instance.getUserInfo(item.playerID);
				if(userInfo){
					FishModel.instance.sendHitFish(item.bulletID,item.fishID,item.playerID);
					BulletManager.Instance.shotSomething(item.bulletID);
				}
			}
		}
		return count;
	}

	__getset(1,CollideManager,'Instance',function(){
		if(!CollideManager._instance)CollideManager._instance=new CollideManager(new SingletonEnforcer());
		return CollideManager._instance;
	});

	CollideManager._instance=null;
	CollideManager.__init$=function(){
		//
		//class SingletonEnforcer
		SingletonEnforcer=(function(){
			function SingletonEnforcer(){}
			__class(SingletonEnforcer,'');
			return SingletonEnforcer;
		})()
	}

	return CollideManager;
})()


//class game.module.fish.vo.CoolingManager
var CoolingManager=(function(){
	var SingletonEnforcer;
	function CoolingManager(enforcer){
		this._cdTime=0;
		this._effTime=0;
		this._coolInfo={};
		this._coolItems={};
		this._cooling={};
		if(!enforcer)throw new console.log("Singleton Error");
	}

	__class(CoolingManager,'game.module.fish.vo.CoolingManager');
	var __proto=CoolingManager.prototype;
	__proto.destroy=function(){
		CoolingManager._instance=null;
	}

	__proto.init=function(items){
		this._coolItems=items;
	}

	__proto.Cooling=function(id){
		for(var i=0 in this._coolInfo){
			var propInfo=this._coolInfo[i];
			if(propInfo&&propInfo.id==id){
				this.startCooling(propInfo.id,propInfo.cdTime,propInfo.cdTime);
				return;
			}
		}
	}

	__proto.checkCooling=function(){
		for(var i=0 in this._coolInfo){
			var propInfo=this._coolInfo[i];
			if(propInfo&&propInfo.timerCD>0){
				this.startCooling(propInfo.id,propInfo.timerCD,propInfo.cdTime);
			}
		}
	}

	__proto.startCooling=function(id,cool,cdTime){
		this._cooling[id]={id:id,time:cool,cd:cdTime};
	}

	__proto.updateTime=function(){
		for(var index=0 in this._cooling){
			var item=this._cooling[index];
			if(item){
				if(item.time>0){
					item.time=item.time-16;
					var percent=item.time/item.cd;
					var p=Math.floor(percent*360);
					this.updateNode(item.id,p,false,item.time);
				}
				else{
					this.updateNode(item.id,0,true,0);
					this._cooling[index]=null;
					delete this._cooling[index];
				}
			}
		}
	}

	__proto.updateNode=function(id,p,end,time){
		var obj=this._coolItems[id];
		if(obj){
			var bar=obj["effect"];
			if(bar){
				bar.graphics.clear();
				if(!end){
					bar.scaleY=-1;
					bar.rotation=-90;
					bar.graphics.drawPie(-60,-60,90,0,p,"#000000");
				}
			};
			var timer=obj["timer"];
			if(timer){
				this._cdTime=0;
				time=Math.floor(time/1000);
				time<=0?timer.text="":timer.text=time+"";
			}
		}
		return true;
	}

	__proto.reset=function(){
		for(var i=0 in this._coolInfo){
			var propInfo=this._coolInfo[i];
			if(propInfo){
				propInfo.timerCD=0;
				this.updateNode(propInfo.id,0,true,0);
			}
		}
		this._cooling={};
	}

	__getset(0,__proto,'propInfo',null,function(info){
		this._coolInfo=info;
		this.checkCooling();
	});

	__getset(1,CoolingManager,'Instance',function(){
		if(!CoolingManager._instance)CoolingManager._instance=new CoolingManager(new SingletonEnforcer());
		return CoolingManager._instance;
	});

	CoolingManager._instance=null;
	CoolingManager.__init$=function(){
		//
		//class SingletonEnforcer
		SingletonEnforcer=(function(){
			function SingletonEnforcer(){}
			__class(SingletonEnforcer,'');
			return SingletonEnforcer;
		})()
	}

	return CoolingManager;
})()


//class game.module.fish.vo.FishManager
var FishManager=(function(){
	var SingletonEnforcer;
	function FishManager(enforcer){
		this._bbx=[];
		this._index=[];
		this._object=[];
		this._objectBBX=[];
		this._panel=null;
		this._switch=0;
		if(!enforcer)throw new console.log("Singleton Error");
	}

	__class(FishManager,'game.module.fish.vo.FishManager');
	var __proto=FishManager.prototype;
	__proto.destroy=function(){
		FishManager._instance=null;
	}

	__proto.init=function(panel){
		this._panel=panel;
		if(this._panel){
		}else{}
	}

	//创建鱼接口
	__proto.createFish=function(fInfo){
		var fish=this._object[fInfo.id];
		if(fish){
			}else{
			fish=new Fish(fInfo);
			this._panel.addChild(fish);
			this._object[fInfo.id]=fish;
			this._objectBBX[fInfo.id]=fish.BBX;
		}
	}

	__proto.catchFishByBBX=function(bbx){
		var res={fish:null,count:0};
		for(var i=0 in this._objectBBX){
			var abbx=this._objectBBX[i];
			if(abbx){
				for(var y=0 in bbx){
					var butBBx=bbx[y];
					if(butBBx){
						for(var x=0 in abbx){
							var fishbbx=abbx[x];
							if(fishbbx){
								res.count++;
								var dis=Math.floor(Math.sqrt(Math.pow(fishbbx.a-butBBx.a,2)+Math.pow(fishbbx.b-butBBx.b,2)));
								if(butBBx.r+fishbbx.r>dis){
									this._object[i].beenShot();
									res.fish=this._object[i];
									return res;
								}
							}
						}
					}
				}
			}
		}
		return res;
	}

	__proto.catchFishByPos=function(pos){
		for(var i=0 in this._objectBBX){
			var abbx=this._objectBBX[i];
			if(abbx){
				for(var x=0 in abbx){
					var fishbbx=abbx[x];
					if(fishbbx){
						var dis=Math.floor(Math.sqrt(Math.pow(fishbbx.a-pos.x,2)+Math.pow(fishbbx.b-pos.y,2)));
						if(fishbbx.r>dis){
							return this._object[i];
						}
					}
				}
			}
		}
		return null;
	}

	__proto.removeFish=function(index,fishID,score,act){
		var batConfig=FishConfig.BATTERY_CONFIG[index+1];
		if(batConfig){
			var fish=this._object[fishID];
			if(fish){
				fish.fishScore=score;
				fish.fishScoreAniPos=batConfig.scorepos;
				fish.death();
				this._object[fishID]=null;
				this._objectBBX[fishID]=null;
				if(act){
					FishModel.instance.event("REWARD",{index:fish.fishType,score:score});
				}
			}
		}
	}

	__proto.getfisheById=function(id){
		return this._object[id];
	}

	//
	__proto.update=function(){
		var count=0;
		var list=[];
		for(var i=0 in this._object){
			var obj=this._object[i];
			if(obj){
				count++;
				if(obj._life){
					obj.update();
					obj.fishPause=FishModel.instance.pauseFishes;
					this._objectBBX[i]=obj.BBX;
					list.push(obj);
				}
				else{
					obj.removeSelf();
					this._object[i]=null;
					this._objectBBX[i]=null;
				}
			}
		}
		BatteryManager.Instance.lockList=list;
		return count;
	}

	__proto.clearFishes=function(){
		for(var i=0 in this._object){
			var obj=this._object[i];
			if(obj){
				obj.removeSelf();
				this._object[i]=null;
				this._objectBBX[i]=null;
			}
		}
		this._object=[];
		this._objectBBX=[];
	}

	__getset(0,__proto,'fishes',function(){
		return this._object;
	});

	__getset(1,FishManager,'Instance',function(){
		if(!FishManager._instance)FishManager._instance=new FishManager(new SingletonEnforcer());
		return FishManager._instance;
	});

	FishManager._instance=null;
	FishManager.__init$=function(){
		//
		//class SingletonEnforcer
		SingletonEnforcer=(function(){
			function SingletonEnforcer(){}
			__class(SingletonEnforcer,'');
			return SingletonEnforcer;
		})()
	}

	return FishManager;
})()


//class game.module.fish.vo.PropManager
var PropManager=(function(){
	var SingletonEnforcer;
	function PropManager(enforcer){
		this._propInfo={};
		this._proping={};
		this._panel=null;
		this.ICE='by01';
		this.BOM='by02';
		this.ELE='by03';
		if(!enforcer)throw new console.log("Singleton Error");
	}

	__class(PropManager,'game.module.fish.vo.PropManager');
	var __proto=PropManager.prototype;
	__proto.destroy=function(){
		PropManager._instance=null;
	}

	__proto.init=function(panel){
		this._panel=panel;
		if(this._panel){
		}else{}
	}

	__proto.proping=function(id){
		for(var i=0 in this._propInfo){
			var propInfo=this._propInfo[i];
			if(propInfo&&propInfo.id==id){
				this.startProp(propInfo.id,propInfo.effectTime);
				return;
			}
		}
	}

	__proto.stopProp=function(id){
		var info=this._proping[id];
		if(info){
			info.time=0;
		}
	}

	__proto.updateTime=function(){
		for(var index in this._proping){
			var item=this._proping[index];
			if(item){
				if(item.time>0){
					item.time=item.time-16;
					}else{
					this.effect(item.id,false);
					this._proping[index]=null;
					delete this._proping[index];
				}
			}
		}
	}

	__proto.checkProp=function(){
		for(var i=0 in this._propInfo){
			var propInfo=this._propInfo[i];
			if(propInfo&&propInfo.timerEffect>0){
				this.startProp(propInfo.id,propInfo.timerEffect);
			}
		}
	}

	__proto.startProp=function(id,time){
		this._proping[id]={id:id,time:time};
		this.effect(id,true);
	}

	__proto.effect=function(id,state){
		switch(id){
			case this.ICE:{
					FishModel.instance.pauseFishes=state;
				}break ;
			case this.BOM:{
				}break ;
			case this.ELE:{
				}break ;
			}
	}

	__proto.runAction=function(data){
		switch(data.id){
			case this.ICE:{
				}break ;
			case this.BOM:{
					this.runBomAct(data,Handler.create(this,this.propRes));
				}break ;
			case this.ELE:{
					this.runFlashAct(data,Handler.create(this,this.propRes));
				}break ;
			}
	}

	__proto.propRes=function(data){
		console.log(" propRes:"+JSON.stringify(data));
		for(var i=0 in data.arr){
			var fishData=data.arr[i];
			if(fishData){
				FishManager.Instance.removeFish(data.seatIndex,fishData.id,fishData.score,false);
			}
		};
		var player=FishModel.instance.getUserInfo(data.playerId);
		if(player){
			player.playerGold=data.playerMoney;
			BatteryManager.Instance.updateBatteryScore(data.playerId,data.playerMoney);
		}
	}

	__proto.runBomAct=function(data,callback){
		if(!this._panel){
			return;
		};
		var time=600;
		var ani1=new Image(FishConfig.bomUrl);
		ani1.anchorX=0.5;
		ani1.anchorY=0.5;
		ani1.rotation=0;
		ani1.pos(960,-200);
		this._panel.addChild(ani1);
		Tween.to(ani1,{y:540,rotation:360},time);
		var ani2=new Animation();
		ani2.loadAnimation(FishConfig.propAction);
		ani2.interval=80;
		ani2.play(0,false,"bom");
		ani2.visible=false;
		ani2.scale(3.0,3.0);
		this._panel.addChild(ani2);
		this._panel.timerOnce(time,this._panel,function(){
			ani2.x=ani1.x;
			ani2.y=ani1.y;
			ani1.visible=false;
			ani2.visible=true;
			ani2.play(0,false,"bom");
			FishSound.effect("propBom.mp3");
		});
		ani2.on("complete",this,function(){
			if(callback){
				callback.runWith(data);
			}
			ani1.removeSelf();
			ani2.removeSelf();
		});
	}

	__proto.runFlashAct=function(data,callback){
		if(!this._panel){
			return;
		};
		var time=1500;
		var ani1=new Animation();
		ani1.loadAnimation(FishConfig.propAction);
		ani1.interval=150;
		ani1.x=960;
		ani1.y=400;
		ani1.scale(2.0,2.0);
		ani1.play(0,true,"flash");
		this._panel.addChild(ani1);
		var ani2=new Animation();
		ani2.loadAnimation(FishConfig.propAction);
		ani2.interval=150;
		ani2.x=960;
		ani2.y=540;
		ani2.scale(2.0,2.0);
		ani2.play(0,false,"ani4");
		ani2.visible=false;
		this._panel.addChild(ani2);
		this._panel.timerOnce(10,this._panel,function(){
			ani2.visible=true;
			ani2.play(0,true,"ani4");
		});
		ani2.timerOnce(time,ani2,function(){
			if(callback){
				callback.runWith(data);
			}
			ani1.stop();
			ani1.removeSelf();
			ani2.stop();
			ani2.removeSelf();
		});
		FishSound.effect("propFla.mp3");
	}

	__getset(0,__proto,'propInfo',null,function(info){
		this._propInfo=info;
		this.checkProp();
	});

	__getset(1,PropManager,'Instance',function(){
		if(!PropManager._instance)PropManager._instance=new PropManager(new SingletonEnforcer());
		return PropManager._instance;
	});

	PropManager._instance=null;
	PropManager.__init$=function(){
		//
		//class SingletonEnforcer
		SingletonEnforcer=(function(){
			function SingletonEnforcer(){}
			__class(SingletonEnforcer,'');
			return SingletonEnforcer;
		})()
	}

	return PropManager;
})()


/**
*chenyuan
*/
//class game.module.fish.FishModel extends game.core.base.BaseModel
var FishModel=(function(_super){
	function FishModel(){
		//房间号
		this._roomId=0;
		//房间倍率
		this._roomMul=0;
		//子弹速度
		this._bulletSpeed=0;
		//进入时所有鱼
		this._enterfishes=[];
		//所有玩家
		this._players=[];
		//场景id
		this._sceneid=1;
		//自动锁定
		this._autoLock=false;
		//自动发射
		this._autoFire=false;
		//暂停所有鱼
		this._pauseFishes=false;
		//玩家技能
		this._playerCooling=[];
		//生效道具
		this._sceneRotation=false;
		//
		this._gameVisible=true;
		//
		this._sceneChange=false;
		FishModel.__super.call(this);
	}

	__class(FishModel,'game.module.fish.FishModel',_super);
	var __proto=FishModel.prototype;
	__proto.init=function(data){
		_super.prototype.init.call(this,data);
		this.event("START");
		FishSound.init(this._sceneid);
	}

	__proto.onMessage=function(data){
		switch(data.op){
			case "newFish":{
					this.event("NEWFISH",data.data);
				}break ;
			case "newScene":{
					this._sceneid=data.sceneId;
					this.event("NEWSCENE",data);
				}break ;
			case "newBullet":{
					this.event("NEWBULLET",data);
				}break ;
			case "inTable":{
					this.userEnder(data.seat);
					this.event("NEWUSER");
				}break ;
			case "newBulletType":{
					this.event("NEWBATTERY",data);
				}break ;
			case "removeBullet":{
				}break ;
			case "lock":{
					this.event("LOCKFISH",data);
				}break ;
			case "unlock":{
					this.event("QLOCKFISH",data);
				}break ;
			case "killFish":{
					if(data.deadType=="bulletHit"){
						this.fishDeath(data);
					}
				}break ;
			case "spItemUsed":{
					this.useProp(data);
				}break ;
			case "quit":{
					this.event("OFFLINE",data);
				}break ;
			case "offline":{
					this.event("OFFLINE",data);
				}break ;
			case "unFreeze":{
					PropManager.Instance.stopProp(data.id);
				}break ;
			default :
				console.error("----fish message",data);
				break ;
			}
	}

	__proto.enter=function(){
		var _$this=this;
		if(this._roomId!=0){
			this.send("fish.enter",{roomId:this._roomId},function(data,code){
				if(code==0){
					_$this.getInfo();
				}
				if(code==500){
					FishAlert.show("\n"+data.errMsg,Handler.create(this,function(isok){
						if(isok){
							GlobalPopup.openShop(true);
							game.module.fish.FishModel.instance.event("ROOMVIEW");
						}
					}));
					return;
				}
			});
			}else{
			game.module.fish.FishModel.instance.event("ROOMVIEW");
		}
	}

	/**捕鱼列表**/
	__proto.getRoomInfo=function(){
		var _$this=this;
		this.send("fish.roominfo",{},function(data,code){
			_$this.event("ROOMLIST",data);
		});
	}

	__proto.getInfo=function(){
		var _$this=this;
		this.send("fish.tableinfo",{},function(data){
			game.module.fish.FishModel.instance.event("FISHVIEW");
			var tableinfo=data.data;
			_$this._enterfishes=tableinfo.allFish;
			_$this.event("ALLFISH");
			_$this._players=[];
			for(var indey=0;indey<tableinfo.allPlayer.length;indey++){
				var player=tableinfo.allPlayer[indey];
				if(player.isSat){
					_$this._players.push({
						playerId:player.playerId,
						playerName:player.playerName,
						playerGold:player.playerGold,
						playerAvatar:player.playerAvatar,
						index:player.index,
						tableId:player.tableId,
						roomId:player.roomId,
						batteryLevel:parseInt(player.batteryLevel),
						lockedFish:player.lockedFish});
				}
			}
			_$this.event("ALLUSER");
			_$this._sceneid=tableinfo.curScen?tableinfo.curScen:_$this._sceneid;
			_$this.event("CURSCENE");
			PropManager.Instance.propInfo=tableinfo.propInfo;
			CoolingManager.Instance.propInfo=tableinfo.propInfo;
			_$this.event("ENTERFINISHED");
		});
	}

	__proto.userEnder=function(user){
		var player=this.getUserInfo(user.playerId);
		if(!player){
			this._players.push({
				playerId:user.playerId,
				playerName:user.playerName,
				playerGold:user.playerGold,
				playerAvatar:user.playerAvatar,
				index:user.index,
				tableId:user.tableId,
				roomId:user.roomId,
				batteryLevel:parseInt(user.batteryLevel),
				lockedFish:user.lockedFish});
		}
	}

	__proto.getSelfInfo=function(){
		for(var index=0;index<this._players.length;index++){
			var info=this._players[index];
			if(info&&GlobalModel.instance.self.userId==info.playerId){
				return info;
			}
		}
		return null;
	}

	__proto.getUserInfo=function(playerId){
		for(var index=0;index<this._players.length;index++){
			var info=this._players[index];
			if(info&&playerId==info.playerId){
				return info;
			}
		}
		return null;
	}

	__proto.getUserInfoByChairId=function(seatId){
		for(var index=0;index<this._players.length;index++){
			var info=this._players[index];
			if(info&&seatId==info.index){
				return info;
			}
		}
		return null;
	}

	//
	__proto.deletUserInfoByChairId=function(seatId){
		for(var index=0;index<this._players.length;index++){
			var info=this._players[index];
			if(info&&seatId==info.index){
				delete this._players[index];
				return;
			}
		}
	}

	__proto.sendBullet=function(angle){
		if(this._sceneChange)return;
		this.send("fish.shot",{angle:angle},function(data,code){
		});
	}

	// }
	__proto.sendChangeBat=function(type){
		var _$this=this;
		this.send("fish.changebullet",{key:type},function(data,code){
			var res=data.data;
			for(var index=0;index<_$this._players.length;index++){
				var info=_$this._players[index];
				if(info&&res.playerId==info.playerId){
					_$this._players[index].batteryLevel=parseInt(res.currBatteryLevel);
					return;
				}
			}
		});
	}

	__proto.sendHitFish=function(bulletID,fishID,playerID){
		this.send("fish.hitfish",{bulletId:bulletID,fishId:fishID,playerId:playerID},function(data,code){
		});
	}

	// }
	__proto.sendAutoLock=function(fishId){
		this.send("fish.lock",{fishId:fishId},function(data,code){
		});
	}

	//trace("==================锁鱼");
	__proto.sendQAutoLock=function(){
		this.send("fish.unlock",{},function(data,code){
		});
	}

	//trace("==================锁鱼");
	__proto.sendProp=function(propId){
		this.send("fish.spitem",{itemType:propId},function(data){
		});
	}

	//trace("==================使用道具:"+propId);
	__proto.exit=function(){
		this.send("fish.quit",{},function(data){
			if(0==data.code){}
				game.module.fish.FishModel.instance.event("ROOMVIEW");
		});
	}

	//鱼死亡
	__proto.fishDeath=function(data){
		for(var i=0 in data.arr){
			var fishData=data.arr[i];
			if(fishData){
				FishManager.Instance.removeFish(data.seatIndex,fishData.id,fishData.score,true);
			}
		};
		var player=this.getUserInfo(data.playerId);
		if(player){
			player.playerGold=data.playerMoney;
			BatteryManager.Instance.updateBatteryScore(data.playerId,data.playerMoney);
		}
	}

	//使用道具
	__proto.useProp=function(data){
		if(data.playerId==GlobalModel.instance.self.userId){
			CoolingManager.Instance.Cooling(data.id);
		}
		PropManager.Instance.proping(data.id);
		PropManager.Instance.runAction(data);
	}

	__proto.getAngleByTwoPoint=function(pos1,pos2){
		var angle=(180 / Math.PI)*Math.atan((pos1.y-pos2.y)/(pos1.x-pos2.x));
		if(pos1.x>pos2.x&&pos1.y>pos2.y){}
			else if(pos1.x<pos2.x&&pos1.y>pos2.y){
			angle=180+angle;
		}
		else if(pos1.x<pos2.x&&pos1.y<pos2.y){
			angle=180+angle;
		}
		else if(pos1.x>pos2.x&&pos1.y<pos2.y){
			angle=360+angle;
		}
		return angle;
	}

	__proto.destroy=function(){
		_super.prototype.destroy.call(this);
		FishModel._instance=null;
	}

	__getset(0,__proto,'pauseFishes',function(){
		return this._pauseFishes;
		},function(pause){
		this._pauseFishes=pause;
	});

	__getset(0,__proto,'enterfishes',function(){
		return this._enterfishes;
	});

	__getset(0,__proto,'autoLock',function(){
		return this._autoLock;
		},function(lock){
		this._autoLock=lock;
	});

	__getset(0,__proto,'players',function(){
		return this._players;
	});

	__getset(0,__proto,'Cooling',function(){
		return this._playerCooling;
	});

	__getset(0,__proto,'changing',function(){
		return this._sceneChange;
		},function(enable){
		this._sceneChange=enable;
	});

	__getset(0,__proto,'sceneid',function(){
		return this._sceneid;
		},function(id){
		this._sceneid=id;
	});

	__getset(0,__proto,'autoFire',function(){
		return this._autoFire;
		},function(auto){
		this._autoFire=auto;
	});

	__getset(0,__proto,'sceneRotation',function(){
		return this._sceneRotation;
		},function(rotation){
		this._sceneRotation=rotation;
	});

	__getset(0,__proto,'roomId',function(){
		return this._roomId;
		},function(roomId){
		this._roomId=roomId;
	});

	__getset(0,__proto,'bulletSpeed',function(){
		return this._bulletSpeed;
		},function(speed){
		this._bulletSpeed=speed;
	});

	__getset(0,__proto,'roomMul',function(){
		return this._roomMul;
		},function(roomId){
		this._roomMul=roomId;
	});

	__getset(1,FishModel,'instance',function(){
		if(!FishModel._instance)FishModel._instance=new FishModel();
		return FishModel._instance;
	},game.core.base.BaseModel._$SET_instance);

	FishModel._instance=null;
	return FishModel;
})(BaseModel)


//class game.module.fish.vo.Battery extends laya.display.Sprite
var Battery=(function(_super){
	function Battery(bInfo){
		//炮台
		this._batteryNode=null;
		this._batteryBg=null;
		this._batteryInfo=null;
		//等待进入
		this._wateEnter=null;
		//用户昵称
		this._userNick=null;
		//用户分数
		this._userScore=null;
		//用户倍数
		this._userMul=null;
		//加
		this._add=null;
		//减
		this._cut=null;
		//
		this._battery=null;
		this._batteryPip=null;
		//
		this._self=false;
		this._multiple=0;
		this._config=null;
		this._fireAngle=0;
		this._fireSpeed=0;
		this._frameCount=0;
		//自动锁定
		this._autoLock=false;
		//自动发射
		this._autoFire=false;
		//炮台开关
		this._fire=true;
		this._lockItem=[];
		this._lock_fish_lst=[];
		//锁定的鱼
		this._lockFish_ID="";
		//椅子号
		this._chaird_ID=0;
		//玩家id
		this._playerID="";
		Battery.__super.call(this);
		this._config=bInfo;
		this.initData();
		this.initView();
	}

	__class(Battery,'game.module.fish.vo.Battery',_super);
	var __proto=Battery.prototype;
	__proto.initData=function(){
		this._self=false;
		this._multiple=1;
		this._fireSpeed=FishModel.instance.bulletSpeed*1000;
		this._playerID=this._config.id;
		this._fireAngle=this._config.fangle;
	}

	__proto.initView=function(){
		this.x=this._config.pos.x;
		this.y=this._config.pos.y;
		this._batteryNode=new Sprite();
		this.addChild(this._batteryNode);
		this._batteryBg=new Image(this._config.res[0]);
		this._batteryBg.anchorX=0.5;
		this._batteryBg.anchorY=0.5;
		this._batteryBg.rotation=this._config.bgangle;
		this._batteryNode.addChild(this._batteryBg);
		this._batteryInfo=new Sprite();
		this._batteryNode.addChild(this._batteryInfo);
		var flag=new Image(this._config.res[1]);
		flag.pos(-345,-20);
		this._batteryInfo.addChild(flag);
		this._userScore=new Label("99999");
		this._userScore.anchorX=0.0;
		this._userScore.anchorY=0.5;
		this._userScore.font="Arial";
		this._userScore.fontSize=20;
		this._userScore.color="#ffffff";
		this._userScore.align="left";
		this._userScore.pos(-300,0);
		this._batteryInfo.addChild(this._userScore);
		this._userNick=new Label("ABCDEF");
		this._userNick.anchorX=0.0;
		this._userNick.anchorY=0.5;
		this._userNick.font="Arial";
		this._userNick.fontSize=20;
		this._userNick.color="#ffffff";
		this._userNick.align="left";
		this._userNick.pos(180,0);
		this._batteryInfo.addChild(this._userNick);
		this._add=new Image(this._config.res[3]);
		this._add.pos(70,-35);
		this._batteryInfo.addChild(this._add);
		this._add.on("click",this,this.addCallback);
		this._cut=new Image(this._config.res[2]);
		this._cut.pos(-140,-35);
		this._batteryInfo.addChild(this._cut);
		this._cut.on("click",this,this.cutCallback);
		this._battery=new Image(FishConfig.getBatteryUrl(this._multiple));
		this._battery.anchorX=0.5;
		this._battery.anchorY=0.5;
		this._battery.rotation=this._config.bangle;
		this._batteryNode.addChild(this._battery);
		this._batteryPip=new Image(FishConfig.getBatteryPipUrl(this._multiple));
		this._batteryPip.pos(66,25);
		this._batteryPip.anchorX=0.5;
		this._batteryPip.anchorY=1;
		this._battery.addChild(this._batteryPip);
		this._userMul=new Label("倍数");
		this._userMul.anchorX=0.5;
		this._userMul.anchorY=0.5;
		this._userMul.font="Arial";
		this._userMul.fontSize=16;
		this._userMul.color="#ffffff";
		this._userMul.align="center";
		this._userMul.pos(67,73);
		this._battery.addChild(this._userMul);
		this._wateEnter=new Image(this._config.res[4]);
		this._wateEnter.anchorX=0.5;
		this._wateEnter.anchorY=0.5;
		this._wateEnter.visible=false;
		this.addChild(this._wateEnter);
		for(var i=1;i<20;i++){
			var lineI=new Image(this._config.line);
			lineI.anchorX=0.5;
			lineI.anchorY=0.5;
			lineI.y=-100*i;
			lineI.x=66;
			lineI.visible=false;
			this._battery.addChild(lineI);
			this._lockItem.push(lineI);
		}
	}

	__proto.cutCallback=function(){
		FishModel.instance.sendChangeBat(0);
	}

	__proto.addCallback=function(){
		FishModel.instance.sendChangeBat(1);
	}

	//入场提示动画
	__proto.runTips=function(){}
	//向某坐标点开火
	__proto.reqfire=function(pos){
		var point=new Point(this._battery.x,this._battery.y);
		this.localToGlobal(point);
		if(FishModel.instance.sceneRotation){
			point.x=FishConfig.GAME_WIDTH-point.x;
			point.y=FishConfig.GAME_HEIGHT-point.y;
		};
		var angle=FishModel.instance.getAngleByTwoPoint(pos,{x:point.x,y:point.y});
		if(FishModel.instance.sceneRotation){
			if(pos.y<point.y){
				angle=angle-180;
			}
		}
		this._fireAngle=angle;
		this._battery.rotation=angle+this._config.fangle;
		if(this._self&&this._fire){
			FishModel.instance.sendBullet(Math.floor(this._fireAngle));
			this._fire=false;
		}
	}

	//向某角度点开火
	__proto.fireAngle=function(info){
		var _$this=this;
		if(!this._self){
			this._battery.rotation=info.angle+this._config.fangle;
		};
		var point=new Point(this._battery.x,this._battery.y);
		this.localToGlobal(point);
		if(FishModel.instance.sceneRotation){
			point.x=FishConfig.GAME_WIDTH-point.x;
			point.y=FishConfig.GAME_HEIGHT-point.y;
		}
		BulletManager.Instance.send({mul:this._multiple,spos:{x:point.x,y:point.y},angle:info.angle,chairID:info.chairID,bulletId:info.bulletId,lockfish:this._lockFish_ID,playerId:this._playerID});
		Tween.to(this._batteryPip,{scaleX :1.15,scaleY:0.8 },0.2);
		this.frameOnce(2,this,function(){
			Tween.to(_$this._batteryPip,{scaleX :1,scaleY:1 },0.4);
		});
		FishSound.effect(FishConfig.getBatterySound(this._multiple));
	}

	__proto.updateView=function(){
		if(this._userMul){
			var textMul=this._multiple*FishModel.instance.roomMul+".00";
			this._userMul.text=textMul;
		}
		if(this._battery)this._battery.skin=FishConfig.getBatteryUrl(this._multiple);
		if(this._batteryPip)this._batteryPip.skin=FishConfig.getBatteryPipUrl(this._multiple);
	}

	//取消锁定鱼id
	__proto.setQlockFish=function(){
		var fish=FishManager.Instance.getfisheById(this._lockFish_ID);
		if(fish){
			fish.shotflag.visible=false;
		}
		this.setlockLineLengh(0);
		this._lockFish_ID="";
	}

	__proto.setlockLineLengh=function(dis){
		var count=dis / 88;
		for(var i=0;i<20;i++){
			var lineI=this._lockItem[i];
			if(lineI){
				if(i<count-4){
					lineI.visible=true;
					}else{
					lineI.visible=false;
				}
				if(count<=0){
					lineI.visible=false;
				}
			}
		}
	}

	__proto.update=function(){
		this._frameCount=this._frameCount+16;
		if(this._autoFire){
			this.reqSend();
			this._fire=false;
		}
		if(this._autoLock){
			this._fire=false;
			var fish=FishManager.Instance.getfisheById(this._lockFish_ID);
			if(fish){
				var fishPos={x:fish.lockPos.x,y:fish.lockPos.y};
				if(fishPos.x<FishConfig.GAME_WIDTH&&fishPos.x>0&&fishPos.y<FishConfig.GAME_HEIGHT&&fishPos.y>0){
					var batPos=new Point(this._battery.x,this._battery.y);
					this.localToGlobal(batPos);
					if(FishModel.instance.sceneRotation){
						batPos.x=FishConfig.GAME_WIDTH-batPos.x;
						batPos.y=FishConfig.GAME_HEIGHT-batPos.y;
					};
					var angle=FishModel.instance.getAngleByTwoPoint(fishPos,batPos);
					this._fireAngle=angle;
					this._battery.rotation=angle+this._config.fangle;
					var distance=Math.sqrt(Math.pow(batPos.x-fish.lockPos.x,2)+Math.pow(batPos.y-fish.lockPos.y,2));
					this.setlockLineLengh(distance);
					fish.shotflag.visible=true;
					fish.shotflag.skin=this._config.linea;
					if(this._self){
						this.reqSend();
					}
					}else{
					fish.shotflag.visible=false;
					this.setlockLineLengh(0);
					this._lockFish_ID="";
					this.resetLock();
				}
				}else{
				this.setlockLineLengh(0);
				this._lockFish_ID="";
				this.resetLock();
			}
			}else{
			this.setlockLineLengh(0);
			this._lockFish_ID="";
		}
		if(!this._autoFire&&!this._autoLock){
			if(this._frameCount>=this._fireSpeed){
				this._frameCount=0;
				this._fire=true;
			}
		}
	}

	__proto.resetLock=function(){
		for(var i=0 in this._lock_fish_lst){
			var fish=this._lock_fish_lst[i];
			if(fish){
				if(fish.x <=FishConfig.GAME_WIDTH && fish.x >=0 && fish.y >=0 && fish.y <=FishConfig.GAME_HEIGHT){
					if(this._self){
						FishModel.instance.sendAutoLock(fish.fishID);
						this._lockFish_ID=fish.fishID;
					}
					return;
				}
			}
		}
	}

	__proto.reqSend=function(){
		if(this._frameCount>=this._fireSpeed){
			this._frameCount=0;
			FishModel.instance.sendBullet(Math.floor(this._fireAngle));
		}
	}

	__proto.come=function(){
		this._batteryNode.visible=true;
		this._wateEnter.visible=false;
	}

	__proto.reset=function(){
		if(this._userNick)this._userNick.text="";
		if(this._userScore)this._userScore.text="";
		if(this._userMul)this._userMul.text="";
		this._battery.rotation=this._config.bangle;
		this._fireAngle=this._config.fangle;
		this._wateEnter.visible=true;
		this._batteryNode.visible=false;
		var fish=FishManager.Instance.getfisheById(this._lockFish_ID);
		if(fish){
			fish.shotflag.visible=false;
		}
		this.setlockLineLengh(0);
		this._lockFish_ID="";
		this._autoLock=false;
		this._autoFire=false;
		this._fire=true;
		this.x=this._config.pos.x;
		this.y=this._config.pos.y;
	}

	__proto.newRotationBg=function(angle){
		if(this._batteryBg)this._batteryBg.rotation=angle;
		if(this._batteryInfo)this._batteryInfo.rotation=angle;
		if(this._wateEnter)this._wateEnter.rotation=angle;
	}

	__proto.newRotationMul=function(angle){
		if(this._userMul)this._userMul.rotation=angle;
	}

	__proto.newRotationPosX=function(posX){
		this.x=this._config.pos.x+posX;
	}

	//自动锁定
	__getset(0,__proto,'autoLock',function(){
		return this._autoLock;
		},function(lock){
		this._autoLock=lock;
	});

	//当前炮消耗分数
	__getset(0,__proto,'multiple',null,function(multiple){
		this._multiple=multiple;
		this.updateView();
	});

	//当前分数
	__getset(0,__proto,'score',null,function(score){
		if(this._userScore){
			this._userScore.text=score/GlobalConfig.goldrate+"";
			if(this._self){
				GlobalModel.instance.self.gold=score;
			}
		}
	});

	//发射速度
	__getset(0,__proto,'speed',null,function(speed){
		this._fireSpeed=speed*1000;
	});

	//昵称
	__getset(0,__proto,'name',null,function(name){
		if(this._userNick){
			this._userNick.text=name+"";
		}
	});

	//椅子id
	//椅子id
	__getset(0,__proto,'chairdID',function(){
		return this._chaird_ID;
		},function(chairdID){
		this._chaird_ID=chairdID;
	});

	//自己炮台
	__getset(0,__proto,'self',function(){
		return this._self;
		},function(self){
		this._self=self;
		if(!this._self){
			this._cut.visible=false;
			this._add.visible=false;
		}
	});

	//自动发射
	__getset(0,__proto,'autoFire',function(){
		return this._autoFire;
		},function(auto){
		this._autoFire=auto;
	});

	//锁定鱼id
	//锁定鱼id
	__getset(0,__proto,'lockFish',function(){
		return this._lockFish_ID;
		},function(fishID){
		var fish=FishManager.Instance.getfisheById(this._lockFish_ID);
		if(fish){
			fish.shotflag.visible=false;
		}
		this.setlockLineLengh(0);
		this._lockFish_ID=fishID;
	});

	//
	__getset(0,__proto,'playerId',function(){
		return this._playerID;
		},function(playerId){
		this._playerID=playerId;
	});

	__getset(0,__proto,'curAngle',function(){
		return this._fireAngle;
	});

	__getset(0,__proto,'lockList',null,function(list){
		this._lock_fish_lst=list;
	});

	return Battery;
})(Sprite)


//class game.module.fish.vo.Bullet extends laya.display.Sprite
var Bullet=(function(_super){
	function Bullet(bInfo){
		//死亡标识
		this._life=true;
		/*1 底边
		*2 右边
		*3 顶边
		*4 左边
		*/
		this._side=3;
		//计时 毫秒 一边到另一边的时间
		this._run_time=NaN;
		//速度
		this._run_speed=0;
		//增量
		this._run_pos=null;
		//初始坐标（每次反弹后需要重置）
		this._start_pos=null;
		this._bonding_box=null;
		//子弹ID
		this._b_ID="";
		//玩家ID
		this._p_ID="";
		//锁定的鱼
		this._lockFish_ID="";
		this._multiple=0;
		this._net=null;
		this._ani=null;
		Bullet.__super.call(this);
		this._run_time=14;
		this._side=3;
		this._b_ID=bInfo.bulletId;
		this._p_ID=bInfo.playerId;
		this._run_pos={x:0,y:0};
		this._bonding_box=[{a:0,b:0,r:16}];
		this._multiple=bInfo.mul;
		this._lockFish_ID=bInfo.lockfish;
		this.x=bInfo.spos.x;
		this.y=bInfo.spos.y;
		this._start_pos={x:this.x,y:this.y};
		this._run_speed=10;
		this._net=new Animation();
		this._net.loadAnimation(FishConfig.fishNetUrl);
		this._net.interval=30;
		this._net.play(0,false,this.getNRes());
		this.addChild(this._net);
		this._net.visible=false;
		this._net.stop();
		this._ani=new Sprite();
		this.addChild(this._ani);
		var num=FishConfig.getBulletNum(this._multiple);
		if(num==1){
			var ani=new Animation();
			ani.loadAnimation(FishConfig.bulletUrl);
			ani.interval=30;
			ani.rotation=90;
			ani.play(0,true,this.getBRes());
			this._ani.addChild(ani);
			}else if(num==2){
			var ani1=new Animation();
			ani1.loadAnimation(FishConfig.bulletUrl);
			ani1.interval=30;
			ani1.rotation=90;
			ani1.y=-40;
			ani1.play(0,true,this.getBRes());
			this._ani.addChild(ani1);
			var ani2=new Animation();
			ani2.loadAnimation(FishConfig.bulletUrl);
			ani2.interval=30;
			ani2.rotation=90;
			ani2.y=40;
			ani2.play(0,true,this.getBRes());
			this._ani.addChild(ani2);
		}
		else if(num==3){
			var ani3=new Animation();
			ani3.loadAnimation(FishConfig.bulletUrl);
			ani3.interval=30;
			ani3.rotation=90;
			ani3.y=-50;
			ani3.play(0,true,this.getBRes());
			this._ani.addChild(ani3);
			var ani4=new Animation();
			ani4.loadAnimation(FishConfig.bulletUrl);
			ani4.interval=30;
			ani4.rotation=90;
			ani4.play(0,true,this.getBRes());
			this._ani.addChild(ani4);
			var ani5=new Animation();
			ani5.loadAnimation(FishConfig.bulletUrl);
			ani5.interval=30;
			ani5.rotation=90;
			ani5.y=50;
			ani5.play(0,true,this.getBRes());
			this._ani.addChild(ani5);
		}
		this.setRotation(bInfo.angle);
		if(3==this._side){
			if(this.rotation>180){
				this._side=1;
			}
		}
	}

	__class(Bullet,'game.module.fish.vo.Bullet',_super);
	var __proto=Bullet.prototype;
	__proto.setRotation=function(angle){
		this.rotation=angle;
	}

	//
	__proto.update=function(){
		if(this.check()){
			var side=this.getSide();
			this.setRotation(this.getAngle(side));
			this._side=side;
			this._run_time=0;
			this._start_pos.x=this._start_pos.x+this._run_pos.x;
			this._start_pos.y=this._start_pos.y+this._run_pos.y;
			this._run_pos.x=0;
			this._run_pos.y=0;
		};
		var bat=BatteryManager.Instance.getbattery(this._p_ID);
		if(this._p_ID!=""&&this._lockFish_ID!=""&&bat&&bat.lockFish!=""&&bat.lockFish==this._lockFish_ID){
			if(bat.curAngle<=180){
				this.setRotation(bat.curAngle);
			}
		}
		this._run_time=this._run_time+1;
		var dis=this._run_time*this._run_speed;
		this._run_pos.x=dis*Math.cos((this.rotation/180)*Math.PI);
		this._run_pos.y=dis*Math.sin((this.rotation/180)*Math.PI);
		this.x=this._start_pos.x+this._run_pos.x;
		this.y=this._start_pos.y+this._run_pos.y;
	}

	//边界判断
	__proto.check=function(){
		var t_x=this._start_pos.x+this._run_pos.x;
		var t_y=this._start_pos.y+this._run_pos.y;
		for(var index=0;index<this._bonding_box.length;index++){
			var bod=this._bonding_box[index];
			if(bod){
				t_x=t_x+bod.a;
				t_y=t_y+bod.b;
				if(t_x<bod.r||FishConfig.GAME_WIDTH-t_x<bod.r||t_y<bod.r||FishConfig.GAME_HEIGHT-t_y<bod.r){
					return true;
				}
			}
		}
		return false;
	}

	//获取一边到另一边的角度
	__proto.getAngle=function(next_side){
		var angle=this.rotation;
		if(angle==90||angle==270){
			return 360-angle;
			}else if(angle==0||angle==360){
			return 180;
			}else if(angle==180){
			return 0;
		}
		if(this._side==1&&next_side==2){
			if(angle<90){
				return 180-angle;
			}
			return 360-angle+180;
			}else if(this._side==1&&next_side==3){
			if(angle>90){
				return 180-angle+180;
			}
			return 360-angle;
			}else if(this._side==1&&next_side==4){
			if(angle>180){
				return 360-(angle-180);
			}
			return 180-angle;
			}else if(this._side==3&&next_side==2){
			if(angle>270){
				return 360-angle+180;
			}
			return 180-angle;
			}else if(this._side==3&&next_side==4){
			if(angle>180){
				return 360-(angle-180);
			}
			return 180-angle;
			}else if(this._side==3&&next_side==1){
			if(angle>90){
				return 180+(180-angle);
			}
			return 360-angle;
			}else if(this._side==4&&next_side==3){
			return 360-angle;
			}else if(this._side==4&&next_side==1){
			return 360-angle;
			}else if(this._side==4&&next_side==2){
			if(angle<90){
				return 180-angle;
			}
			return 360-angle+180;
			}else if(this._side==2&&next_side==3){
			if(angle>180){
				return 180-(angle-180);
			}
			return 180-angle+180;
			}else if(this._side==2&&next_side==1){
			if(angle>90){
				return 180-angle+180;
			}
			return 360-angle;
			}else if(this._side==2&&next_side==4){
			if(angle>180){
				return 360-(angle-180);
			}
		}
		return 180-angle;
	}

	//*******子弹在四条边的哪个边******
	__proto.getSide=function(){
		var pos={x:this._start_pos.x+this._run_pos.x,y:this._start_pos.y+this._run_pos.y};
		var side=0;
		if ((pos.x < FishConfig.GAME_WIDTH/2 && pos.y > FishConfig.GAME_HEIGHT/2)&& (pos.x <=FishConfig.GAME_HEIGHT-pos.y)){
			side=4;
			}else if ((pos.x < FishConfig.GAME_WIDTH/2 && pos.y > FishConfig.GAME_HEIGHT/2)&& (pos.x > FishConfig.GAME_HEIGHT-pos.y)){
			side=1;
			}else if ((pos.x < FishConfig.GAME_WIDTH/2 && pos.y < FishConfig.GAME_HEIGHT/2)&& (pos.x <=pos.y)){
			side=4;
			}else if ((pos.x < FishConfig.GAME_WIDTH/2 && pos.y < FishConfig.GAME_HEIGHT/2)&& (pos.x > pos.y)){
			side=3;
			}else if ((pos.x > FishConfig.GAME_WIDTH/2 && pos.y > FishConfig.GAME_HEIGHT/2)&& (FishConfig.GAME_WIDTH-pos.x <=FishConfig.GAME_HEIGHT-pos.y)){
			side=2;
			}else if ((pos.x > FishConfig.GAME_WIDTH/2 && pos.y > FishConfig.GAME_HEIGHT/2)&& (FishConfig.GAME_WIDTH-pos.x > FishConfig.GAME_HEIGHT-pos.y)){
			side=1;
			}else if ((pos.x > FishConfig.GAME_WIDTH/2 && pos.y < FishConfig.GAME_HEIGHT/2)&& (FishConfig.GAME_WIDTH-pos.x <=pos.y)){
			side=2;
			}else if ((pos.x > FishConfig.GAME_WIDTH/2 && pos.y < FishConfig.GAME_HEIGHT/2)&& (FishConfig.GAME_WIDTH-pos.x > pos.y)){
			side=3;
		};
		return side
	}

	__proto.getBRes=function(){
		var str=FishConfig.getBulletName(this._multiple);
		return str;
	}

	__proto.getBImage=function(){
		return "res/fish/bullet/bul1_1.png";
	}

	__proto.getNRes=function(){
		var str=FishConfig.getFishNetName(this._multiple);
		return str;
	}

	__proto.shotSomething=function(){
		var _$this=this;
		this._life=true;
		this._side=3;
		this._run_time=0;
		this._run_pos={x:0,y:0};
		this._lockFish_ID="";
		this._ani.visible=false;
		this._ani.removeSelf();
		this._ani=null;
		this._net.visible=true;
		this._net.play(0,false,this.getNRes());
		this._net.on("complete",this,function(){
			_$this._net.stop();
			_$this._net.visible=false;
			_$this._net.removeSelf();
			_$this.removeSelf();
		});
	}

	__getset(0,__proto,'lockFish',function(){
		return this._lockFish_ID;
	});

	__getset(0,__proto,'bulletID',function(){
		return this._b_ID;
	});

	__getset(0,__proto,'playerID',function(){
		return this._p_ID;
	});

	__getset(0,__proto,'BBX',function(){
		var point=new Point(0,0);
		var bbx=[];
		for(var i=0 in this._bonding_box){
			var bod=this._bonding_box[i];
			if(bod){
				point.x=bod.a;
				point.y=bod.b;
				this.localToGlobal(point);
				if(FishModel.instance.sceneRotation){
					point.x=FishConfig.GAME_WIDTH-point.x;
					point.y=FishConfig.GAME_HEIGHT-point.y;
				};
				var t={a:point.x,b:point.y,r:bod.r};
				bbx.push(t);
			}
		}
		return bbx;
	});

	__getset(0,__proto,'life',function(){
		return this._life;
		},function(life){
		this._life=life;
	});

	return Bullet;
})(Sprite)


//class game.module.fish.vo.Fish extends laya.display.Sprite
var Fish=(function(_super){
	function Fish(fInfo){
		this._MUIL=1000;
		//死亡标识
		this._life=true;
		//鱼id
		this._fishID="";
		//鱼类型
		this._fishType=1;
		//鱼配置
		this._fishConfig=null;
		//
		this._bonding_box=null;
		//鱼动画
		this._ani=null;
		//冰冻动画
		this._aniIce=null;
		//鱼游动次数
		this._run_count=0;
		//鱼游动时间
		this._run_time=10;
		//路径列表
		this._curve_lst=[];
		//-1负方向 1正方向
		this._curve_way=1;
		//鱼初始角度
		this._curve_angle=0;
		//鱼初始坐标
		this._start_pos={x:0,y:0};
		//鱼
		this._drawbbx=false;
		//鱼最新角度
		this._cur_angle=0;
		//鱼被锁定准星
		this._shot_flag=null;
		//鱼分数
		this._fish_score=0;
		//鱼分数动画的中点坐标
		this._fish_score_ani=null;
		this._fish_score_ani_pos={x:0,y:0};
		//鱼暂停
		this._fish_pause=false;
		this._fish_pause_frame_index=0;
		Fish.__super.call(this);
		this._fishID=fInfo.id;
		this.x=this._start_pos.x=fInfo.x;
		this.y=this._start_pos.y=fInfo.y;
		this._fishType=fInfo.type;
		if(this._fishType>23||this._fishType<=0){
			this._fishType=1;
		}
		this._cur_angle=fInfo.angle;
		this.rotation=fInfo.angle;
		this._curve_angle=fInfo.angle;
		this._fishConfig=FishConfig.FISH_CONFIG[this._fishType];
		this._bonding_box=this._fishConfig.bonding_box;
		this.createItems();
		for(var i=0;i<fInfo.curve.length;i++){
			this.addCurve(fInfo.curve[i]);
		}
		this._run_time=fInfo.runTime<10?10:fInfo.runTime;
	}

	__class(Fish,'game.module.fish.vo.Fish',_super);
	var __proto=Fish.prototype;
	//trace("   _curve_lst:"+JSON.stringify(_curve_lst));
	__proto.createItems=function(){
		this._ani=new Animation();
		this._ani.loadAnimation(this._fishConfig.res);
		this._ani.interval=this._fishConfig.aani.interval;
		this._ani.play(0,true,this._fishConfig.aani.key);
		this.addChild(this._ani);
		this._shot_flag=new Image(FishConfig.BATTERY_CONFIG[1].linea);
		this._shot_flag.anchorX=0.5;
		this._shot_flag.anchorY=0.5;
		this._shot_flag.x=0;
		this._shot_flag.y=0;
		this.addChild(this._shot_flag);
		this._shot_flag.visible=false;
		this._aniIce=new Animation();
		this._aniIce.loadAnimation(FishConfig.propAction);
		this._aniIce.interval=24;
		this._aniIce.play(0,true,"ice");
		this._aniIce.scale(this._fishConfig.ice,this._fishConfig.ice);
		this._aniIce.visible=false;
		this.addChild(this._aniIce);
		if(this._drawbbx){
			var bbx=this._bonding_box;
			for(var i=0 in bbx){
				var bbxinfo=bbx[i];
				if(bbxinfo){
					this.graphics.drawCircle(bbxinfo.a,bbxinfo.b,bbxinfo.r,"#000000","#ff0400",5)
				}
			}
		}
	}

	// }
	__proto.addCurve=function(cveinfo){
		if(cveinfo){
			var item={
				time:cveinfo.t*this._MUIL,
				speed:cveinfo.speed,
				ftype:cveinfo.ftype,
				fparam:cveinfo.fparam,
				t1:0,
				t2:0
			};
			if(this._curve_lst.length<=0){
				item.t1=0;
				item.t2=item.t1+item.time;
				this._curve_lst.push(item);
				}else{
				var temp=this._curve_lst[this._curve_lst.length-1];
				item.t1=temp.t2;
				item.t2=item.t1+item.time;
				this._curve_lst.push(item);
			}
		}
	}

	__proto.update=function(){
		if(this._fish_pause==true){
			this._ani.stop();
			this._aniIce.visible=true;
			return;
		}
		else{
			this._aniIce.visible=false;
		};
		var pos=this.getPostionByTime(this._run_time);
		this.x=pos.x;
		this.y=pos.y;
		this.getNewAngle(pos);
		this.rotation=this._cur_angle;
		this._run_time=this._run_time+10;
	}

	//计算角度
	__proto.getNewAngle=function(pos){
		var angle=0;
		var pos1=this.getPostionByTime(this._run_time+10);
		if(this._curve_angle!=0){
			if(pos.x>=pos1.x){
				this._curve_way=-1;
				}else{
				this._curve_way=1;
			}
		};
		var temp_x=pos1.x-pos.x;
		var temp_y=pos1.y-pos.y;
		if(Math.abs(temp_x)<=0.0000001){
			if(this._curve_angle!=0){
				if(pos.y<pos1.y){
					this._curve_way=-1;
					}else{
					this._curve_way=1;
				}
			}
			if(this._curve_way==-1){
				angle=90;
				}else{
				angle=270;
			}
			}else{
			if(this._curve_way==-1){
				angle=(360-Math.atan(temp_y/temp_x)*180/Math.PI);
				}else{
				angle=(180-Math.atan(temp_y/temp_x)*180/Math.PI);
			}
		}
		this._cur_angle=180-angle;
	}

	//计算坐标
	__proto.getPostionByTime=function(dt){
		var pos={x:0,y:0};
		if(this._curve_lst.length<=0){
			return pos;
		}
		this._run_count++;
		var last_item=this._curve_lst[this._curve_lst.length-1];
		var time=0.0;
		var curve_v=0.0;
		if(dt>=last_item.t2){
			this._life=false;
			this.visible=false;
			}else{
			for(var i=0;i<this._curve_lst.length;i++){
				var item=this._curve_lst[i];
				if(dt>=item.t1&&dt<item.t2){
					time=(dt-item.t1);
					curve_v=item.speed*(time/this._MUIL);
					var temp_pos1=this.getNewPos(item.ftype,{a:item.fparam.a,b:item.fparam.b,c:item.fparam.c,way:item.fparam.way,r:item.fparam.r,k:item.fparam.k,x:curve_v});
					if(temp_pos1.x<0.0000000001){
						this._curve_way=-1;
						}else{
						this._curve_way=1;
					}
					pos.x=pos.x+temp_pos1.x;
					pos.y=pos.y+temp_pos1.y;
					break ;
					}else{
					time=item.time;
					curve_v=item.speed*(time/this._MUIL);
					var temp_pos2=this.getNewPos(item.ftype,{a:item.fparam.a,b:item.fparam.b,c:item.fparam.c,way:item.fparam.way,r:item.fparam.r,k:item.fparam.k,x:curve_v});
					pos.x=pos.x+temp_pos2.x;
					pos.y=pos.y+temp_pos2.y;
				}
			}
		}
		if(this._curve_angle!=0){
			pos.x=pos.x*Math.cos((this._curve_angle/180)*Math.PI)+pos.y*Math.sin((this._curve_angle/180)*Math.PI);
			pos.y=pos.y*Math.cos((this._curve_angle/180)*Math.PI)-pos.x*Math.sin((this._curve_angle/180)*Math.PI);
		}
		pos.x=pos.x+this._start_pos.x;
		pos.y=pos.y+this._start_pos.y;
		return pos;
	}

	//去浮点
	__proto.updateNumber=function(pos){
		var x_s=pos.x+"";
		var x_y=pos.y+"";
		return {x:parseInt(x_s),y:parseInt(x_y)};
	}

	//通用公式
	__proto.getNewPos=function(type,param){
		var pos={x:param.x,y:0};
		switch(type){
			case 1:{
					pos.y=param.a *Math.pow(param.x,2)+param.b *param.x+param.c;
				}break ;
			case 2:{
					pos.y=param.a *Math.pow(param.x,3);
				}break ;
			case 3:{
					pos.y=Math.pow(param.a,param.x);
				}break ;
			case 4:{
					pos.y=param.a*Math.log(param.x);
				}break ;
			case 5:{
					pos.y=param.a*Math.sin(param.b*param.x);
				}break ;
			case 6:{
					pos.y=param.a *Math.cos(param.b *param.x);
				}break ;
			case 7:{
					if(param.way==1){
						pos.y=Math.sqrt(Math.pow(param.r,2)-Math.pow(param.x+param.a,2))-param.b;
						}else{
						pos.y=-Math.sqrt(Math.pow(param.r,2)-Math.pow(param.x+param.a,2))-param.b;
					}
				}break ;
			case 8:{
					pos.y=param.k *param.x;
				}break ;
			default :{
					pos.y=0;
				}break ;
			}
		return pos;
	}

	__proto.death=function(){
		var _$this=this;
		if(this._shot_flag){
			this._shot_flag.visible=false;
			this._shot_flag.removeSelf();
		}
		if(this._ani){
			this._ani.stop();
			this._ani.interval=this._fishConfig.dani.interval;
			var count=0;
			this._ani.play(0,true,this._fishConfig.dani.key);
			this._ani.on("complete",this,function(){
				count++;
				if(_$this._fishConfig.dani.loop>count){
					_$this._ani.play(0,false,_$this._fishConfig.dani.key);
					}else{
					_$this._ani.visible=false;
					_$this._ani.removeSelf();
					_$this._ani=null;
				}
			});
		}
		this.runScoreAni();
	}

	__proto.runScoreAni=function(){
		var _$this=this;
		var parent=this.parent;
		var golds=[];
		var count=this.get_length(this._fish_score);
		for(var index=1;index<=5;index++){
			var img=new Animation();
			img.loadAnimation("Ani/aniGold.ani");
			img.x=this.x+90*index-count*45;
			img.y=this.y+70*2;
			img.interval=24;
			img.play(0,true,"ani1");
			parent.addChild(img);
			golds.push(img);
		};
		var label=new FontClip(FishConfig.getNumPic("gold"),"+-0123456789");
		label.value=this._fish_score+"";
		label.anchorX=0.5;
		label.anchorY=0.5;
		label.x=this.x;
		label.y=this.y+100*2;
		parent.addChild(label);
		if(FishModel.instance.sceneRotation){
			label.rotation=180;
		}
		this.frameOnce(70,this,function(){
			label.visible=false;
			label.removeSelf();
			if(null!=_$this._ani){
				_$this._ani.stop();
				_$this._ani.removeSelf();
			};
			var time=0;
			for(var i=0 in golds){
				var gold=golds[i];
				if(gold){
					time=i*50+500;
					Tween.to(gold,{x:_$this._fish_score_ani_pos.x,y:_$this._fish_score_ani_pos.y},time);
				}
			}
			_$this.timerOnce(time,this,function(){
				for(var m=0 in golds){
					var goldm=golds[m];
					if(goldm){
						goldm.removeSelf();
					}
				}
				_$this.removeSelf();
			});
		});
		FishSound.effect("fly.mp3");
	}

	//获得整数的位数
	__proto.get_length=function(num){
		var leng=5;
		return leng;
	}

	__proto.isCatched=function(bbx){
		var point=new Point(0,0);
		for(var i=0 in bbx){
			var bbxI=bbx[i];
			if(bbxI){
				for(var x=0 in this._bonding_box){
					var fbbx=this._bonding_box[x];
					if(fbbx){
						point.x=fbbx.a;
						point.y=fbbx.b;
						this.localToGlobal(point);
						if(FishModel.instance.sceneRotation){
							point.x=FishConfig.GAME_WIDTH-point.x;
							point.y=FishConfig.GAME_HEIGHT-point.y;
						};
						var dis=Math.floor(Math.sqrt(Math.pow(point.x-bbxI.a,2)+Math.pow(point.y-bbxI.b,2)));
						if(bbxI.r+fbbx.r>=dis){
							this.beenShot();
							return true;
						}
					}
				}
			}
		}
		return false;
	}

	__proto.beenShot=function(){
		this.makeRedApe();
		this.frameOnce(10,this,function(){
			this.filters=[];
		})
	}

	__proto.pauseAni=function(){
		this._ani.stop();
		this._fish_pause_frame_index=this._ani.index;
	}

	__proto.resumeAni=function(){
		this._ani.play(this._fish_pause_frame_index,true,this._fishConfig.aani.key);
	}

	__proto.makeRedApe=function(){
		var redMat=
		[
		1,0,0,0,0,
		0,0,0,0,0,
		0,0,0,0,0,
		0,0,0,1,0,];
		var redFilter=new ColorFilter(redMat);
		this.filters=[redFilter];
	}

	__proto.clone=function(obj){
		var o;
		if (typeof obj=="object"){
			if (obj===null){
				o=null;
				}else {
				if (obj instanceof Array){
					o=[];
					for (var i=0,len=obj.length;i < len;i++){
						o.push(this.clone(obj[i]));
					}
					}else {
					o={};
					for (var j in obj){
						o[j]=this.clone(obj[j]);
					}
				}
			}
			}else {
			o=obj;
		}
		return o;
	}

	__getset(0,__proto,'BBX',function(){
		var point=new Point(0,0);
		var bbx=[];
		for(var i=0 in this._bonding_box){
			var bod=this._bonding_box[i];
			if(bod){
				var angle=this.rotation+180;
				point.x=bod.a;
				point.y=bod.b;
				this.localToGlobal(point);
				if(FishModel.instance.sceneRotation){
					point.x=FishConfig.GAME_WIDTH-point.x;
					point.y=FishConfig.GAME_HEIGHT-point.y;
				};
				var t={a:point.x,b:point.y,r:bod.r};
				bbx.push(t);
			}
		}
		return bbx;
	});

	__getset(0,__proto,'fishScoreAniPos',function(){
		return this._fish_score_ani_pos;
		},function(pos){
		this._fish_score_ani_pos=pos;
	});

	__getset(0,__proto,'fishScore',function(){
		return this._fish_score;
		},function(score){
		this._fish_score=score;
	});

	__getset(0,__proto,'shotflag',function(){
		return this._shot_flag;
	});

	__getset(0,__proto,'fishID',function(){
		return this._fishID;
	});

	__getset(0,__proto,'fishPause',function(){
		return this._fish_pause;
		},function(pause){
		if(true==pause){
			this.pauseAni();
		}
		if(true==this._fish_pause&&pause==false){
			this.resumeAni();
		}
		this._fish_pause=pause;
	});

	__getset(0,__proto,'fishType',function(){
		return this._fishType;
	});

	__getset(0,__proto,'lockPos',function(){
		var point=new Point(this._shot_flag.x,this._shot_flag.y);
		this.localToGlobal(point);
		if(FishModel.instance.sceneRotation){
			point.x=FishConfig.GAME_WIDTH-point.x;
			point.y=FishConfig.GAME_HEIGHT-point.y;
		}
		return {x:point.x,y:point.y};
	});

	return Fish;
})(Sprite)


//class game.module.fish.FishModule extends game.core.base.BaseModule
var FishModule=(function(_super){
	function FishModule(){
		FishModule.__super.call(this);
		PopupManager.reg("GAME_FISH","REWARD",FishReward);
		PopupManager.reg("GAME_FISH","HELP",FishHelp);
		PopupManager.reg("GAME_FISH","SETUP",FishSetting);
		SceneManager.reg("GAME_FISH","FISHHOME",FishHome);
		var res=FishConfig.INIT_SKINS;
		res=res.concat(FishSound.initSounds);
		this.init(res);
	}

	__class(FishModule,'game.module.fish.FishModule',_super);
	var __proto=FishModule.prototype;
	__proto.onInit=function(){
		_super.prototype.onInit.call(this);
		FishModel.instance.once("START",this,this.start);
		FishModel.instance.init(this.dataSource);
	}

	__proto.start=function(){
		SceneManager.enter("GAME_FISH","FISHHOME");
		this.initComplete();
	}

	__proto.enter=function(data){
		_super.prototype.enter.call(this,data);
	}

	__proto.remove=function(){
		_super.prototype.remove.call(this);
	}

	__proto.destroy=function(destroyChild){
		(destroyChild===void 0)&& (destroyChild=true);
		laya.display.Sprite.prototype.destroy.call(this,destroyChild);
		FishModel.instance.destroy();
	}

	return FishModule;
})(BaseModule)


//class game.module.fish.scene.FishHome extends laya.ui.View
var FishHome=(function(_super){
	function FishHome(){
		this._layer=null;
		this.classList=[RoomView,FishView];
		this.viewList=[];
		FishHome.__super.call(this);
		this._layer=new Sprite();
		this.addChild(this._layer);
		var roomView=new RoomView();
		this._layer.addChild(roomView);
		roomView.visible=true;
		this.viewList.push(roomView);
		var fishView=new FishView();
		this._layer.addChild(fishView);
		fishView.visible=false;
		this.viewList.push(fishView);
		FishModel.instance.on("FISHVIEW",this,this.showScene);
		FishModel.instance.on("ROOMVIEW",this,this.showDesktop);
	}

	__class(FishHome,'game.module.fish.scene.FishHome',_super);
	var __proto=FishHome.prototype;
	__proto.showDesktop=function(obj){
		this.showView(0);
	}

	__proto.showScene=function(obj){
		this.showView(1);
	}

	__proto.showView=function(index){
		for(var i=0 in this.viewList){
			var view=this.viewList[i];
			if(view){
				view.hide();
			}
		}
		if(this.viewList[index])this.viewList[index].show();
	}

	__proto.destroy=function(destroyChild){
		(destroyChild===void 0)&& (destroyChild=true);
		_super.prototype.destroy.call(this,destroyChild);
		this.viewList=null;
		this.classList=null;
	}

	return FishHome;
})(View)


/**
*chenyuan
*/
//class game.module.fish.scene.FishView extends ui.fish.scene.FishSceneUI
var FishView=(function(_super){
	function FishView(){
		this.step=0;
		this._runLight=null;
		this._shopAni=null;
		this._waterWave=[];
		FishView.__super.call(this);
		FishManager.Instance.init(this.fishPanel);
		BulletManager.Instance.init(this.bulletPanel);
		BatteryManager.Instance.init(this.batteryPanel);
		PropManager.Instance.init(this.propPanel);
		CoolingManager.Instance.init({"by01":{prop:this.iceProp,effect:this.iceEffect,timer:this.iceTimer},
			"by02":{prop:this.fireProp,effect:this.fireEffect,timer:this.fireTimer},
			"by03":{prop:this.flashProp,effect:this.flashEffect,timer:this.flashTimer}});
		FishModel.instance.on("ALLFISH",this,this.allFish);
		FishModel.instance.on("ALLUSER",this,this.allUser);
		FishModel.instance.on("CURSCENE",this,this.curScene);
		FishModel.instance.on("NEWSCENE",this,this.newScene);
		FishModel.instance.on("NEWUSER",this,this.userEnter);
		FishModel.instance.on("NEWFISH",this,this.newFish);
		FishModel.instance.on("NEWBULLET",this,this.newBullet);
		FishModel.instance.on("NEWBATTERY",this,this.newBattery);
		FishModel.instance.on("LOCKFISH",this,this.lockFish);
		FishModel.instance.on("QLOCKFISH",this,this.qLockFish);
		FishModel.instance.on("OFFLINE",this,this.offLine);
		FishModel.instance.on("ENTERFINISHED",this,this.enterFinished);
		FishModel.instance.on("REWARD",this,this.runRewardTips);
		this.iceProp.on("click",this,this.propIceCallback);
		this.fireProp.on("click",this,this.propFireCallback);
		this.flashProp.on("click",this,this.propflashCallback);
		this.btnVisible1.on("click",this,this.btnRight1Callback);
		this.btnVisible2.on("click",this,this.btnRight2Callback);
		this.gameset.on("click",this,this.setCallback);
		this.gamehelp.on("click",this,this.helpCallback);
		this.gameexit.on("click",this,this.exitCallback);
		this.autoLock.on("click",this,this.lockCallback);
		this.autoFire.on("click",this,this.fireCallback);
		this.btnshop.on("click",this,this.btnshopCallback);
		this.bulletPanel.on("mousedown",this,this.batteryCallback);
		this.timerLoop(16,this,this.timeUpdate,null,false);
		this.frameLoop(1,this,this.update,null,false);
		Laya.stage.on("visibilitychange",this,function(){
			if(FishModel.instance._gameVisible){
				FishModel.instance._gameVisible=false;
				FishManager.Instance.clearFishes();
				BulletManager.Instance.clearBullets();
				}else{
				FishModel.instance.enter();
				FishModel.instance._gameVisible=true;
			}
		});
		Browser.window.onunload=function (){}
		this.closeBtn.on("click",this,this.closeBtnsCallback);
	}

	__class(FishView,'game.module.fish.scene.FishView',_super);
	var __proto=FishView.prototype;
	__proto.show=function(){
		this.visible=true;
		this.onLoadingFinished();
	}

	__proto.hide=function(){
		this.visible=false;
		FishManager.Instance.clearFishes();
		BulletManager.Instance.clearBullets();
		BatteryManager.Instance.destroybattery(GlobalModel.instance.self.userId);
		CoolingManager.Instance.reset();
		this.runLight(this.autoFire,false);
		this.runLight(this.autoLock,false);
	}

	//
	__proto.closeBtnsCallback=function(e){
		this.scaleBtns(true);
	}

	__proto.btnRight1Callback=function(e){
		this.scaleBtns(false);
	}

	__proto.btnRight2Callback=function(e){
		this.scaleBtns(true);
	}

	__proto.scaleBtns=function(scale){
		if(scale){
			Tween.to(this.btnsbg,{scaleY:0 },30);
			this.btnVisible1.visible=true;
			this.btnVisible2.visible=false;
			this.closeBtn.visible=false;
			}else{
			Tween.to(this.btnsbg,{scaleY:1 },100);
			this.btnVisible1.visible=false;
			this.btnVisible2.visible=true;
			this.closeBtn.visible=true;
		}
	}

	__proto.onLoadingFinished=function(){
		this.mengbanbg.on("click",this,function(){
		});
		this.mengbanbg.visible=true;
		this.mengban.visible=true;
		this.visible=true;
	}

	__proto.btnshopCallback=function(e){
		GlobalPopup.openShop(true);
	}

	__proto.propFireCallback=function(e){
		FishModel.instance.sendProp(PropManager.Instance.BOM);
	}

	__proto.propIceCallback=function(e){
		FishModel.instance.sendProp(PropManager.Instance.ICE);
	}

	__proto.propflashCallback=function(e){
		FishModel.instance.sendProp(PropManager.Instance.ELE);
	}

	__proto.setCallback=function(e){
		PopupManager.open("GAME_FISH","SETUP");
	}

	__proto.helpCallback=function(e){
		PopupManager.open("GAME_FISH","HELP");
	}

	__proto.lockCallback=function(e){
		if(FishModel.instance.autoLock){
			FishModel.instance.autoLock=false;
			FishModel.instance.sendQAutoLock();
			}else{
			FishModel.instance.autoLock=true;
			if(FishModel.instance.autoFire){
				FishModel.instance.autoFire=false;
				BatteryManager.Instance.autoFire(FishModel.instance.autoFire);
			}
		}
		BatteryManager.Instance.autoLock(FishModel.instance.autoLock);
		this.runLight(this.autoFire,false);
		this.runLight(this.autoLock,FishModel.instance.autoLock);
	}

	__proto.fireCallback=function(e){
		if(FishModel.instance.autoFire){
			FishModel.instance.autoFire=false;
			}else{
			FishModel.instance.autoFire=true;
			if(FishModel.instance.autoLock){
				FishModel.instance.autoLock=false;
				FishModel.instance.sendQAutoLock();
				BatteryManager.Instance.autoLock(FishModel.instance.autoLock);
			}
		}
		BatteryManager.Instance.autoFire(FishModel.instance.autoFire);
		this.runLight(this.autoLock,false);
		this.runLight(this.autoFire,FishModel.instance.autoFire);
	}

	__proto.exitCallback=function(e){
		FishModel.instance.roomId=0;
		FishModel.instance.exit();
	}

	__proto.batteryCallback=function(e){
		var point=new Point(e.stageX,e.stageY);
		this.localToGlobal(point);
		var pos={x:e.stageX,y:e.stageY}
		if(FishModel.instance.sceneRotation){
			pos.x=FishConfig.GAME_WIDTH-pos.x;
			pos.y=FishConfig.GAME_HEIGHT-pos.y;
		}
		if(FishModel.instance.autoLock){
			var user=FishModel.instance.getSelfInfo();
			if(user){
				var fish=FishManager.Instance.catchFishByPos(pos);
				if(fish){
					BatteryManager.Instance.lockFish(user.index,fish.fishID);
					FishModel.instance.sendAutoLock(fish.fishID);
				}
			}
			}else{
			BatteryManager.Instance.reqbatteryFire(pos);
		}
	}

	__proto.update=function(){
		var countF=FishManager.Instance.update();
		if(countF){
			this.fishNum.text="";
		}
		BatteryManager.Instance.update();
		var countB=BulletManager.Instance.update();
		if(this.bulNum){
			this.bulNum.text="";
		}
		this.step++;
		if(this.step>=6){
			this.step=0;
			var countC=CollideManager.Instance.update();
			if(this.coNum){
				this.coNum.text="";
			}
		}
	}

	__proto.timeUpdate=function(){
		CoolingManager.Instance.updateTime();
		PropManager.Instance.updateTime();
	}

	//创建鱼
	__proto.newFish=function(data){
		var fishData={id :data.id ,runTime:data.runTime,type:data.type,x:data.start_x,y:data.start_y,angle:data.angle,curve:data.curve};
		FishManager.Instance.createFish(fishData);
	}

	//发射子弹
	__proto.newBullet=function(data){
		BatteryManager.Instance.batteryFire({angle:data.angle,bulletId:data.bullet.bulletId,playerId:data.bullet.playerId,chairID:data.seatIndex,score:data.leftGold});
	}

	//切换炮台
	__proto.newBattery=function(data){
		BatteryManager.Instance.newBattery(data.batteryLevel,data.seatIndex);
	}

	//重现所有鱼
	__proto.allFish=function(){
		var fishes=FishModel.instance.enterfishes;
		for(var index=0;index<fishes.length;index++){
			var fishinfo=fishes[index];
			var fishData={id :fishinfo.id ,runTime:fishinfo.runTime,type:fishinfo.type,x:fishinfo.start_x,y:fishinfo.start_y,angle:fishinfo.angle,curve:fishinfo.curve};
			FishManager.Instance.createFish(fishData);
		}
	}

	//玩家进入
	__proto.userEnter=function(){
		var selfIndex=this.updatePlayerView(false);
		if(selfIndex!=-1)BatteryManager.Instance.newRotation(selfIndex);
	}

	//所有玩家
	__proto.allUser=function(){
		BatteryManager.Instance.destroyAllBattery();
		var selfIndex=this.updatePlayerView(true);
		if(selfIndex<=1&&selfIndex!=-1){
			this.rotationScene();
		}
		if(selfIndex>-1)BatteryManager.Instance.newRotation(selfIndex);
		this.runShopAni();
		this.runWaterWave();
	}

	__proto.rotationScene=function(){
		this.gamebg.rotation=180;
		this.fishPanel.rotation=180;
		this.bulletPanel.rotation=180;
		this.batteryPanel.rotation=180;
		FishModel.instance.sceneRotation=true;
	}

	__proto.updatePlayerView=function(enter){
		var selfIndex=-1;
		var players=FishModel.instance.players;
		for(var index=0;index<players.length;index++){
			var info=players[index];
			if(info){
				var self=false;
				if(GlobalModel.instance.self.userId==info.playerId){
					selfIndex=info.index;
					self=true;
					if(enter){
						this.runTips(info.index);
					}
				}
				BatteryManager.Instance.createBattery({isSat:true,id:info.playerId,name:info.playerName,score:info.playerGold,chairid:info.index,isSelf:self});
				BatteryManager.Instance.newBattery(info.batteryLevel,info.index);
			}
		}
		return selfIndex;
	}

	//当前场景
	__proto.curScene=function(){
		var cur=FishModel.instance.sceneid;
		var config=FishConfig.SCENE_CONFIG[cur];
		var res=config.res;
		res=res.replace(/%d/,config.id);
		this.gamebg.skin=res;
		if(FishModel.instance.sceneRotation){
			this.gamebg.rotation=180;
		}
	}

	//切换场景
	__proto.newScene=function(data){
		var _$this=this;
		FishModel.instance.changing=true;
		var cur=FishModel.instance.sceneid;
		var config=FishConfig.SCENE_CONFIG[cur];
		var res=config.res;
		res=res.replace(/%d/,config.id);
		var img=new Image(res);
		img.x=FishConfig.GAME_WIDTH;
		this.gamebg.addChild(img);
		if(cur>=1&&cur<=8){
			FishSound.init(cur);
		}
		else{
			console.log("error:"+cur);
		};
		var ani=new Animation();
		ani.loadAnimation(FishConfig.sceneAni);
		ani.y=FishConfig.GAME_HEIGHT/2;
		ani.interval=60;
		ani.play(0,true,"ani3");
		img.addChild(ani);
		FishSound.effect("weave.wav");
		Tween.to(img,{x:0 },2500);
		ani.timerOnce(2500,this,function(){
			Tween.to(ani,{x:-FishConfig.GAME_WIDTH*2 },1000);
			_$this.gamebg.skin=res;
		});
		this.timerOnce(3000,this,function(){
			ani.stop();
			ani.removeSelf();
			img.removeSelf();
			FishModel.instance.changing=false;
		});
	}

	//锁定鱼
	__proto.lockFish=function(data){
		BatteryManager.Instance.lockFish(data.seatIndex,data.fishId);
	}

	//取消锁定鱼
	__proto.qLockFish=function(data){
		BatteryManager.Instance.lockFish(data.seatIndex);
	}

	//玩家离开
	__proto.offLine=function(data){
		var user=FishModel.instance.getUserInfoByChairId(data.index);
		if(user){
			FishModel.instance.deletUserInfoByChairId(data.index);
			BatteryManager.Instance.destroybattery(user.playerId);
			if(GlobalModel.instance.self.userId==user.playerId){
				FishModel.instance.event("ROOMVIEW");
			}
		}
	}

	//
	__proto.enterFinished=function(){}
	//提示动画
	__proto.runTips=function(index){
		var _$this=this;
		var config=null;
		if(index==0||index==3){
			config=FishConfig.BATTERY_CONFIG[4];
			}else{
			config=FishConfig.BATTERY_CONFIG[3];
		};
		var ani=new Animation();
		ani.loadAnimation(FishConfig.sceneAni);
		ani.x=config.pos.x;
		ani.y=config.pos.y-300;
		ani.interval=48;
		ani.play(0,true,"ani1");
		this.mengbanbg.addChild(ani);
		var temp=function (){
			_$this.mengbanbg.visible=false;
			_$this.mengban.visible=false;
			ani.stop();
			ani.removeSelf();
			ani=null;
			Laya.timer.clear(_$this,temp);
		}
		Laya.timer.loop(2500,this,temp);
	}

	//自动射击和自动锁定按钮的动画
	__proto.runLight=function(node,enable){
		if(node){
			if(!this._runLight){
				this._runLight=new Animation();
				this._runLight.loadAnimation(FishConfig.runLight);
				this._runLight.interval=30;
				this._runLight.play(0,true,"ani1");
				node.parent.addChild(this._runLight);
			}
			this._runLight.visible=enable;
			if(enable){
				this._runLight.x=node.x-30;
				this._runLight.y=node.y-30;
			}
		}
	}

	//商店动画
	__proto.runShopAni=function(){
		var _$this=this;
		if(!this._shopAni){
			EffectManager.getSkeleton(FishConfig.getSpineAni(0),Handler.create(this,function(sk){
				_$this._shopAni=sk;
				sk.x=_$this.btnshop.x;
				sk.y=_$this.btnshop.y;
				_$this.btnshop.parent.addChild(sk);
			}));
		}
	}

	//中奖提示
	__proto.runRewardTips=function(data){
		var ani_index=0;
		if(data.index>=9&&data.index<=14){
			ani_index=1;
		}
		else if(data.index>=15&&data.index<=18){
			ani_index=2;
		}
		else if(data.index>=19&&data.index<=21){
			ani_index=3;
		}
		else if(data.index==22){
			ani_index=4;
		}
		if(ani_index!=0){
			var url=FishConfig.getSpineAni(ani_index);
			PopupManager.open("GAME_FISH","REWARD",{url:url,score:data.score},true,false);
		}
	}

	__proto.runWaterWave=function(){
		if(this._waterWave.length<=0){
			var pos=[
			{x :192,y :192},{x :576,y :192},{x :960,y :192},{x :1334,y :192},{x :1728,y :192},
			{x :192,y :576},{x :576,y :576},{x :960,y :576},{x :1334,y :576},{x :1728,y :576},
			{x :192,y :960},{x :576,y :960},{x :960,y :960},{x :1334,y :960},{x :1728,y :960},];
			for(var index=0 in pos){
				var item=pos[index];
				if(item){
					var ani=new Animation();
					ani.loadAnimation(FishConfig.waterWave);
					ani.x=item.x;
					ani.y=item.y;
					ani.interval=60;
					ani.play(0,true,"ani1");
					this.waterPanel.addChild(ani);
					this._waterWave.push(ani);
				}
			}
		}
	}

	__proto.destroy=function(destroyChild){
		(destroyChild===void 0)&& (destroyChild=true);
		FishManager.Instance.destroy();
		BulletManager.Instance.destroy();
		BatteryManager.Instance.destroy();
		laya.ui.View.prototype.destroy.call(this,destroyChild);
	}

	return FishView;
})(FishSceneUI)


/**
*chenyuan
*/
//class game.module.fish.scene.RoomView extends ui.fish.scene.RoomViewUI
var RoomView=(function(_super){
	function RoomView(){
		var _$this=this;
		RoomView.__super.call(this);
		this.roomList.array=[];
		FishModel.instance.on("ROOMLIST",this,function(data){
			_$this.roomList.array=[];
			var index=0;
			for (var key in data.data){
				var roomInfo=data.data[key];
				if(roomInfo&&0==roomInfo.state){
					_$this.roomList.array.push({
						icon:{skin:FishConfig.getRoomIconUrl(index+1)},
						num:{skin:FishConfig.getRoomNameUrl(index+1)},
						roomId:roomInfo.roomid,
						roomMul:roomInfo.roomMul,
						bulletSpeed:roomInfo.bulletSpeed,
						min:{text:"准入: "+roomInfo.moneyrangemin+".00",strokeColor:FishConfig.getRoomStrokeColor(index)}
					});
				}
				index++;
			}
			for (var j=0;j < _$this.roomList.array.length;j++){
				var boxI=_$this.roomList.getCell(j);
				if(boxI){
					boxI.scaleX=0;
					boxI.scaleY=0;
					Tween.to(boxI,{scaleX:1.2,scaleY:1.2,complete:Handler.create(boxI,function(caller){
							Tween.to(caller,{scaleX:1,scaleY:1},100);
					},[boxI])},(j+1)*200);
				}
			}
		});
		this.roomList.vScrollBarSkin=null;
		this.roomList.selectEnable=false;
		this.roomList.mouseHandler=Handler.create(this,this.onRoomList,null,false);
		FishModel.instance.getRoomInfo();
		Signal.on("SELF_INFO",this,this.onUpdateSelfInfo);
		this.onUpdateSelfInfo();
		this.back.on("click",this,this.onBack);
	}

	__class(RoomView,'game.module.fish.scene.RoomView',_super);
	var __proto=RoomView.prototype;
	__proto.resetIcon=function(){
		for (var j=0;j < this.roomList.array.length;j++){
			var boxI=this.roomList.getCell(j);
			if(boxI){
				Tween.to(boxI,{scaleX:1,scaleY:1},1);
			}
		}
	}

	__proto.show=function(){
		this.visible=true;
		this.onUpdateSelfInfo();
	}

	__proto.hide=function(){
		this.visible=false;
	}

	__proto.onUpdateSelfInfo=function(){
		this.userHead.skin=GlobalModel.instance.self.avatar;
		this.userHead.scaleX=1.3;
		this.userHead.scaleY=1.3;
		var cMask=new Sprite();
		cMask.graphics.drawCircle(0,0,38,"#ff0000");
		cMask.pos(40,40);
		this.userHead.mask=cMask;
		this.userName.text=GlobalModel.instance.self.nickname;
		this.userScore.text=GlobalModel.instance.self.gold/GlobalConfig.goldrate+"";
	}

	__proto.onBack=function(){
		Redirect.hall();
	}

	__proto.onRoomList=function(e,index){
		if(e.type=="click"){
			FishModel.instance.roomId=this.roomList.array[index].roomId;
			FishModel.instance.roomMul=this.roomList.array[index].roomMul;
			FishModel.instance.bulletSpeed=this.roomList.array[index].bulletSpeed;
			FishModel.instance.enter();
		}
	}

	__proto.destroy=function(destroyChild){
		(destroyChild===void 0)&& (destroyChild=true);
		laya.ui.View.prototype.destroy.call(this,destroyChild);
	}

	return RoomView;
})(RoomViewUI)


/**
*chenyuan
*/
//class game.module.fish.popup.FishHelp extends ui.fish.popup.FishHelpUI
var FishHelp=(function(_super){
	function FishHelp(){
		FishHelp.__super.call(this);
	}

	__class(FishHelp,'game.module.fish.popup.FishHelp',_super);
	return FishHelp;
})(FishHelpUI)


//class game.module.fish.popup.FishReward extends ui.fish.popup.RewardUI
var FishReward=(function(_super){
	function FishReward(){
		this._skAni=null;
		FishReward.__super.call(this);
		this.score.value="";
	}

	__class(FishReward,'game.module.fish.popup.FishReward',_super);
	var __proto=FishReward.prototype;
	__proto.onClosed=function(type){
		laya.ui.Dialog.prototype.onClosed.call(this,type);
	}

	// scaleY=1;
	__getset(0,__proto,'dataSource',_super.prototype._$get_dataSource,function(data){
		var _$this=this;
		if(this._skAni)this._skAni.removeSelf();
		this.score.value=data.score+"";
		EffectManager.getSkeleton(data.url,Handler.create(this,function(sk){
			_$this._skAni=sk;
			_$this.aniNode.addChild(sk);
			FishSound.effect("reward.mp3");
		}));
		this.frameOnce(120,this,function(){
			if(_$this._skAni)_$this._skAni.removeSelf();
			PopupManager.close("GAME_FISH","REWARD");
		});
	});

	return FishReward;
})(RewardUI)


/**
*liuhe
*/
//class game.module.fish.popup.FishSetting extends ui.fish.popup.SettingUI
var FishSetting=(function(_super){
	function FishSetting(){
		this._status=null;
		this._data=null;
		FishSetting.__super.call(this);
		this.musicNum.changeHandler=Handler.create(this,this.onMusicNums,null,false);
		this.effectNum.changeHandler=Handler.create(this,this.onEffectNum,null,false);
		this.btnMusic.on("click",this,this.onMusic);
		this.btnEffect.on("click",this,this.onEffect);
	}

	__class(FishSetting,'game.module.fish.popup.FishSetting',_super);
	var __proto=FishSetting.prototype;
	__proto.onOpened=function(){
		this._data=AudioManager.data;
		this._status=JSON.stringify(this._data);
		this.musicNum.value=this._data.musicVolume;
		this.effectNum.value=this._data.soundVolume;
		this.btnMusic.selected=this._data.musicOff;
		this.btnEffect.selected=this._data.soundOff;
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

	return FishSetting;
})(SettingUI)


	Laya.__init([CoolingManager,BatteryManager,PropManager,FishManager,BulletManager,CollideManager]);
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