
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Alert=game.core.ui.Alert,Animation=laya.display.Animation,AudioManager=game.core.manager.AudioManager;
	var BaseModel=game.core.base.BaseModel,BaseModule=game.core.base.BaseModule,BetUI=ui.hb.ui.BetUI,Box=laya.ui.Box;
	var Button=laya.ui.Button,DesktopUI=ui.hb.scene.DesktopUI,EffectManager=game.core.manager.EffectManager,Event=laya.events.Event;
	var GameID=game.core.enum.GameID,GlobalConfig=game.core.model.GlobalConfig,GlobalEnum=game.core.enum.GlobalEnum;
	var GlobalModel=game.core.model.GlobalModel,GlobalPopup=game.core.enum.GlobalPopup,GoldUI=ui.hb.ui.GoldUI;
	var Handler=laya.utils.Handler,HbSetUpUI=ui.hb.popup.HbSetUpUI,HelpUI=ui.hb.popup.HelpUI,Jinbi=game.core.ui.Jinbi;
	var Loader=laya.net.Loader,MatchingUI=ui.hb.popup.MatchingUI,Module=game.core.enum.Module,PewUI=ui.hb.ui.PewUI;
	var PopupManager=game.core.manager.PopupManager,RecordUI=ui.hb.popup.RecordUI,Redirect=game.core.utils.Redirect;
	var RestUI=ui.hb.popup.RestUI,RuleAgreeUI=ui.hb.popup.RuleAgreeUI,RuleConfirmUI=ui.hb.popup.RuleConfirmUI;
	var RuleSelectUI=ui.hb.popup.RuleSelectUI,SceneManager=game.core.manager.SceneManager,SelectUI=ui.hb.scene.SelectUI;
	var SettingVo=game.core.vo.SettingVo,SievesUI=ui.hb.ui.SievesUI,Signal=game.core.utils.Signal,Skeleton=laya.ani.bone.Skeleton;
	var SlugMoneyUI=ui.hb.popup.SlugMoneyUI,Sprite=laya.display.Sprite,StartUI=ui.hb.popup.StartUI,StartUI$1=ui.hb.ui.StartUI;
	var Toast=game.core.ui.Toast,Tween=laya.utils.Tween,View=laya.ui.View;
/**
*liuhe
*/
//class game.module.hb.data.PlayerData
var PlayerData=(function(){
	function PlayerData(){
		this._playerList=[];
		this._ruleInfo=null;
		this._ruleI=0;
		this._ruleIsMy=false;
	}

	__class(PlayerData,'game.module.hb.data.PlayerData');
	var __proto=PlayerData.prototype;
	/**筛子结果处理**/
	__proto.sieveResults=function(data){
		for (var i=0;i < this._playerList.length;i++){
			if(this._playerList[i]){
				if(data.uid==this._playerList[i].uid){
					HbModel.instance.event("SIEVERESULTS",{i:i,point:data.point});
					break ;
				}
			}
		}
	}

	/**是否有可以开启的红包**/
	__proto.getMoney=function(data){
		for (var i=0;i < data.playerlist.length;i++){
			if(data.playerlist[i].id==GlobalModel.instance.self.userId){
				HbModel.instance.event("GETMONEY",{time:data.time,iswin:data.playerlist[i].iswin});
				break ;
			}
		}
	}

	/**退出游戏，删除原数据**/
	__proto.backDelete=function(){
		this._playerList=[];
	}

	/***设置规则胜出人位置*/
	__getset(0,__proto,'getRuleI',function(){
		return this._ruleI;
	});

	/**玩家参与选定规则**/
	__getset(0,__proto,'setPlayerGetrule',null,function(data){
		for (var i=0;i < this._playerList.length;i++){
			if(this._playerList[i]){
				if(this._playerList[i].uid==data.uid&&data.getrule==1){
					this._playerList[i].gold=data.gold;
					data.i=i;
					HbModel.instance.event("PLAYER_GETRULE",data);
					break ;
				}
			}
		}
	});

	/**玩家进入座位**/
	__getset(0,__proto,'playerJoin',null,function(data){
		for (var i=0;i <8;i++){
			if(!this._playerList[i]){
				if(data.uid==GlobalModel.instance.self.userId){
					i=7;
				}
				this._playerList[i]=data;
				HbModel.instance.event("PLAYER_JOIN",i);
				break ;
			}
		}
	});

	/**玩家信息列表**/
	__getset(0,__proto,'playerList',function(){
		return this._playerList;
	});

	/**玩家离开座位**/
	__getset(0,__proto,'playerLeave',null,function(data){
		for (var i=0;i < this._playerList.length;i++){
			if(this._playerList[i]){
				if(this._playerList[i].uid==data.uid){
					this._playerList[i]=null;
					HbModel.instance.event("PLAYER_LEAVE",i);
					break ;
				}
			}
		}
	});

	/**玩家下注**/
	__getset(0,__proto,'playerGold',null,function(data){
		for (var i=0;i < this._playerList.length;i++){
			if(this._playerList[i]){
				if(this._playerList[i].uid==data.uid){
					this._playerList[i].gold=data.gold;
					data.i=i;
					HbModel.instance.event("PLAYER_GOLD",data);
					break ;
				}
			}
		}
	});

	/***选择规则自己是否胜出*/
	__getset(0,__proto,'ruleIsMy',function(){
		return this._ruleIsMy;
	});

	/***设置规则胜出人信息*/
	__getset(0,__proto,'setRuleInfo',null,function(data){
		for (var i=0;i < this._playerList.length;i++){
			if(this._playerList[i]){
				if(this._playerList[i].uid==data.uid){
					this._ruleI=i;
					data.i=i;
					HbModel.instance.event("PLAYER_INFO",data);
					break ;
				}
			}
		}
		this._ruleInfo=data;
		this._ruleIsMy=(data.uid==GlobalModel.instance.self.userId);
	});

	/***规则胜出人信息*/
	__getset(0,__proto,'getRuleInfo',function(){
		return this._ruleInfo;
	});

	/**增加金币**/
	__getset(0,__proto,'addGold',null,function(data){
		for (var i=0;i < this._playerList.length;i++){
			if(this._playerList[i]){
				if(data.uid==this._playerList[i].uid){
					this._playerList[i].gold=data.gold;
					data.i=i;
					HbModel.instance.event("ADDGOLD",data);
					break ;
				}
			}
		}
	});

	return PlayerData;
})()


//class game.module.hb.data.RuleData
var RuleData=(function(){
	function RuleData(){
		/**
		*liuhe
		*/
		this._ruleList=[
		"投掷点数最小的玩家，获得红包全部金额",
		"投掷点数最大的玩家，获得红包全部金额",
		"所有投掷点数为小的玩家，每个人开启后获取金额随机",
		"所有投掷点数为大的玩家，每个人开启后获取金额随机"];
		this._rule=null;
		this._resultlist=[];
		this.resultI=0;
	}

	__class(RuleData,'game.module.hb.data.RuleData');
	var __proto=RuleData.prototype;
	/***规则列表***/
	__getset(0,__proto,'ruleList',function(){
		return this._ruleList;
	});

	/**设置最后的规则**/
	__getset(0,__proto,'setRule',null,function(index){
		this._rule=this._ruleList[index-1];
	});

	/**最后的规则**/
	__getset(0,__proto,'getRule',function(){
		return this._rule;
	});

	/**保存游戏记录**/
	__getset(0,__proto,'setResult',null,function(data){
		this._resultlist.push({
			index:this.resultI,
			number:data.point,
			profit:data.money/HbConfig.goldrate,
			rule:this._ruleList[data.ruleid-1]
		});
		this.resultI++;
	});

	/**游戏记录**/
	__getset(0,__proto,'getResult',function(){
		return this._resultlist||[];
	});

	return RuleData;
})()


/**
*chenyuan
*/
//class game.module.hb.enum.HbPopup
var HbPopup=(function(){
	function HbPopup(){}
	__class(HbPopup,'game.module.hb.enum.HbPopup');
	HbPopup.HELP="HELP";
	HbPopup.RECORD="RECORD";
	HbPopup.SETUP="SETUP";
	HbPopup.MATCHING="MATCHING";
	HbPopup.REST="REST";
	HbPopup.START="START";
	HbPopup.RULEAGREE="RULEAGREE";
	HbPopup.RULESELECT="RULESELECT";
	HbPopup.RULECONFIRM="RULECONFIRM";
	HbPopup.SLUGMONEY="SLUGMONEY";
	return HbPopup;
})()


/**
*chenyuan
*/
//class game.module.hb.enum.HbScene
var HbScene=(function(){
	function HbScene(){}
	__class(HbScene,'game.module.hb.enum.HbScene');
	HbScene.CONTROL="CONTROL";
	HbScene.SELECT="SELECT";
	HbScene.DESKTOP="DESKTOP";
	return HbScene;
})()


/**
*liuhe
*/
//class game.module.hb.enum.HbSignal
var HbSignal=(function(){
	function HbSignal(){}
	__class(HbSignal,'game.module.hb.enum.HbSignal');
	HbSignal.REST="REST";
	HbSignal.START="START";
	HbSignal.PLAYER_JOIN="PLAYER_JOIN";
	HbSignal.PLAYER_LEAVE="PLAYER_LEAVE";
	HbSignal.PLAYER_GOLD="PLAYER_GOLD";
	HbSignal.GETRULETIME="GETRULETIME";
	HbSignal.PLAYER_GETRULE="PLAYER_GETRULE";
	HbSignal.CAN_JOIN="CAN_JOIN";
	HbSignal.PLAYER_INFO="PLAYER_INFO";
	HbSignal.SETRULETIME="SETRULETIME";
	HbSignal.POINTTIME="POINTTIME";
	HbSignal.SIEVERESULTS="SIEVERESULTS";
	HbSignal.GETMONEY="GETMONEY";
	HbSignal.ADDGOLD="ADDGOLD";
	HbSignal.WAIT_TIME="WAIT_TIME";
	return HbSignal;
})()


/**
*chenyuan
*/
//class game.module.hb.HbConfig
var HbConfig=(function(){
	function HbConfig(){}
	__class(HbConfig,'game.module.hb.HbConfig');
	HbConfig.getAniUrl=function(name){
		return "res/hb/ani/"+name+".json";
	}

	HbConfig.getSoundUrl=function(name,isMusic){
		(isMusic===void 0)&& (isMusic=false);
		return "res/hb/sound/"+name+GlobalConfig.getSoundExt(isMusic);
	}

	HbConfig.goldrate=0;
	__static(HbConfig,
	['INIT_SKINS',function(){return this.INIT_SKINS=[
		{url:"res/hb/select.json",type:"atlas"},
		{url:"res/hb/desktop.json",type:"atlas"},
		{url:"res/hb/ui.json",type:"atlas"},
		{url:"res/hb/popup.json",type:"atlas"},
		{url:"res/hb/daojishi.json",type:"atlas"},
		{url:"res/hb/anniuguang.json",type:"atlas"},
		{url:"res/hb/ani/avatarAni.png",type:"image"},
		{url:"res/hb/ani/jiaose.png",type:"image"},
		{url:"res/hb/ani/saizi.png",type:"image"},
		{url:"res/hb/ani/youxikaishi.png",type:"image"},
		{url:"res/hb/ani/zzwnpp.png",type:"image"}];}
	]);
	return HbConfig;
})()


/**
*chenyuan
*/
//class game.module.hb.utils.HbSound
var HbSound=(function(){
	function HbSound(){}
	__class(HbSound,'game.module.hb.utils.HbSound');
	__getset(1,HbSound,'initSounds',function(){
		var list=[HbSound.getUrl("bg",true)];
		var arr=["start","sieves","gold","jinbi","win","lose","button"];
		while(arr&&arr.length){
			list.push(HbSound.getUrl(arr.shift()));
		}
		return list;
	});

	HbSound.init=function(){
		AudioManager.start(HbSound.getUrl("bg",true));
	}

	HbSound.effect=function(str){
		AudioManager.playSound(HbSound.getUrl(str));
	}

	HbSound.getUrl=function(name,isMusic){
		(isMusic===void 0)&& (isMusic=false);
		return HbConfig.getSoundUrl(name,isMusic);
	}

	return HbSound;
})()


/**
*chenyuan
*/
//class game.module.hb.HbModel extends game.core.base.BaseModel
var HbModel=(function(_super){
	function HbModel(){
		this._isFree=false;
		this._playerData=null;
		this._ruleData=null;
		HbModel.__super.call(this);
		this._playerData=new PlayerData();
		this._ruleData=new RuleData();
	}

	__class(HbModel,'game.module.hb.HbModel',_super);
	var __proto=HbModel.prototype;
	__proto.init=function(data){
		_super.prototype.init.call(this,data);
		this._isFree=Boolean(data);
		this.event("START");
	}

	__proto.onMessage=function(data){
		if(data.op=="playerJoin"){
			this._playerData.playerJoin=data;
			}else if(data.op=="playerLeave"){
			this._playerData.playerLeave=data;
			}else if(data.op=="beginTime"){
			this.event("REST",data.time);
			}else if(data.op=="playerGold"){
			this._playerData.playerGold=data;
			this.updateSelf(data);
			}else if(data.op=="getRuleTime"){
			this.event("GETRULETIME",data.time);
			}else if(data.op=="playerGetrule"){
			this._playerData.setPlayerGetrule=data;
			this.updateSelf(data);
			}else if(data.op=="getRule"){
			}else if(data.op=="setRuleTime"){
			this._playerData.setRuleInfo=data;
			this.event("SETRULETIME",data.time);
			}else if(data.op=="noOneGetrule"||data.op=="setRule"||data.op=="sysSetrule"){
			this._ruleData.setRule=data.ruleid;
			}else if(data.op=="pointTime"){
			this.event("POINTTIME",data.time);
			}else if(data.op=="open"){
			this._playerData.sieveResults(data);
			}else if(data.op=="getMoney"){
			this._playerData.getMoney(data);
			}else if(data.op=="show"){
			this._playerData.addGold=data;
			this.updateSelf(data);
			}else if(data.op=="waitTime"){
			this.event("WAIT_TIME");
			}else if(data.op=="resultlist"){
			this._ruleData.setResult=data;
		}
		else if(data.op=="kick"){
			this.onKick(data);
			}else{
			console.error("----qhb message",data);
		}
	}

	/**更新自己数据**/
	__proto.updateSelf=function(data){
		if(data.uid==GlobalModel.instance.self.userId){
			GlobalModel.instance.updateSelf(data);
		}
	}

	/**获取房间列表**/
	__proto.roomList=function(handler){
		this.send("hb.room.list",null,function(data){
			handler.runWith(data);
		});
	}

	/**进入房间**/
	__proto.roomEnter=function(obj,handler){
		this.send("hb.room.enter",obj,function(data){
			if(data.state){
				Toast.error(data.state);
				return;
			}
			handler.runWith(data);
		});
	}

	/**是否参与规则制定**/
	__proto.tableGetrule=function(obj){
		this.send("hb.table.getrule",obj);
	}

	/**选择规则**/
	__proto.tableSetrule=function(obj){
		this.send("hb.table.setrule",obj);
	}

	/**掷骰子**/
	__proto.tableOpen=function(){
		this.send("hb.table.open",null);
	}

	/**开启红包**/
	__proto.tableMoney=function(handler){
		this.send("hb.table.money",null,function(data){
			handler.runWith(data);
		});
	}

	/**离开房间**/
	__proto.tableLeave=function(handler){
		this.send("hb.table.leave",null,function(data){
			handler.runWith(data);
		});
	}

	__proto.onKick=function(data){
		var uid=data.uid;
		var type=data.type;
		if(type==1){
			Alert.show("\n您的金币余额不足！是否立即充值？",Handler.create(this,function(isok){
				if(isok)GlobalPopup.openShop();
				game.module.hb.HbModel.instance.event("SELECT");
			}));
			}else if(type==2){
			Alert.show("\n长时间未操作，回到游戏大厅！",Handler.create(this,function(isok){
				if(isok)game.module.hb.HbModel.instance.event("SELECT");
			}));
			}else{
			Alert.show("\n服务器维护，请稍后重试！",Handler.create(this,function(isok){
				if(isok)Redirect.game(101);
			}),false,false,true);
		}
	}

	__proto.destroy=function(){
		_super.prototype.destroy.call(this);
		HbModel._instance=null;
	}

	/**规则数据**/
	__getset(0,__proto,'ruleData',function(){
		return this._ruleData;
	});

	__getset(0,__proto,'isFree',function(){
		return this._isFree;
	});

	/**玩家数据**/
	__getset(0,__proto,'playerData',function(){
		return this._playerData;
	});

	__getset(1,HbModel,'instance',function(){
		if(!HbModel._instance)HbModel._instance=new HbModel();
		return HbModel._instance;
	},game.core.base.BaseModel._$SET_instance);

	HbModel._instance=null;
	return HbModel;
})(BaseModel)


//class game.module.hb.HbModule extends game.core.base.BaseModule
var HbModule=(function(_super){
	function HbModule(){
		HbModule.__super.call(this);
		PopupManager.reg("HB","HELP",HelpView);
		PopupManager.reg("HB","RECORD",RecordView);
		PopupManager.reg("HB","SETUP",HbSetUpView);
		PopupManager.reg("HB","MATCHING",MatchingView);
		PopupManager.reg("HB","START",StartView);
		PopupManager.reg("HB","REST",RestView);
		PopupManager.reg("HB","RULEAGREE",RuleAgreeView);
		PopupManager.reg("HB","RULESELECT",RuleSelectView);
		PopupManager.reg("HB","RULECONFIRM",RuleConfirmView);
		PopupManager.reg("HB","SLUGMONEY",SlugMoneyView);
		SceneManager.reg("HB","CONTROL",Control);
		var res=HbConfig.INIT_SKINS;
		res=res.concat(HbSound.initSounds);
		this.init(res);
	}

	__class(HbModule,'game.module.hb.HbModule',_super);
	var __proto=HbModule.prototype;
	__proto.onInit=function(){
		_super.prototype.onInit.call(this);
		HbModel.instance.once("START",this,this.start);
		HbModel.instance.init(this.dataSource);
	}

	__proto.start=function(){
		SceneManager.enter("HB","CONTROL");
		this.initComplete();
	}

	__proto.enter=function(data){
		_super.prototype.enter.call(this,data);
		HbSound.init();
	}

	__proto.remove=function(){
		_super.prototype.remove.call(this);
	}

	__proto.destroy=function(destroyChild){
		(destroyChild===void 0)&& (destroyChild=true);
		laya.display.Sprite.prototype.destroy.call(this,destroyChild);
		HbModel.instance.destroy();
	}

	return HbModule;
})(BaseModule)


//class game.module.hb.scene.Control extends laya.ui.View
var Control=(function(_super){
	function Control(){
		this._layer=null;
		this.classList=[SelectView,DesktopView];
		this.viewList=[];
		Control.__super.call(this);
		this._layer=new Sprite();
		this.addChild(this._layer);
		HbModel.instance.on("SELECT",this,this.showView,[0]);
		HbModel.instance.on("DESKTOP",this,this.showDesktop);
		this.showView(0);
	}

	__class(Control,'game.module.hb.scene.Control',_super);
	var __proto=Control.prototype;
	__proto.showDesktop=function(obj){
		this.showView(1);
		var store=this._layer.getChildAt(0);
		if(store)store.openDesktop(obj);
	}

	__proto.showView=function(index){
		this._layer.removeChildren();
		var view=this.viewList[index];
		if(!view){
			view=new this.classList[index]();
			view.scaleX=1280/view.width;
			view.scaleY=720/view.height;
			this.viewList[index]=view;
		}
		this._layer.addChild(view);
	}

	__proto.destroy=function(destroyChild){
		(destroyChild===void 0)&& (destroyChild=true);
		_super.prototype.destroy.call(this,destroyChild);
		this.viewList=null;
		this.classList=null;
	}

	return Control;
})(View)


/**
*liuhe
*/
//class game.module.hb.scene.DesktopView extends ui.hb.scene.DesktopUI
var DesktopView=(function(_super){
	function DesktopView(){
		/**房间信息**/
		this.roomInfo=null;
		/**座位**/
		this.pewArr=[];
		/**筛子**/
		this.sievesArr=[];
		/**金币**/
		this.goldBoxArr=[];
		/**开始**/
		this.startV=null;
		/**下注**/
		this.betV=null;
		/**是否在游戏中**/
		this.inTheGame=false;
		DesktopView.__super.call(this);
		this.btnBack.on("click",this,this.onBack);
		this.btnRecharge.on("click",this,this.onRecharge);
		this.btnColumn.on("click",this,this.onColumn);
		this.btnSetUp.on("click",this,this.onSetUp);
		this.btnRecord.on("click",this,this.onRecord);
		this.btnHelp.on("click",this,this.onHelp);
		for (var i=0;i < 8;i++){
			var pewBox=this.getChildByName("pew"+i);
			var pew=new Pew();
			this.pewArr.push(pew);
			pewBox.addChild(pew);
			var sievesBox=this.getChildByName("sieves"+i);
			var sieves=new Sieves();
			this.sievesArr.push(sieves);
			sievesBox.addChild(sieves);
			var goldBox=this.getChildByName("goldBox"+i);
			var goldV=new Gold();
			goldBox.addChild(goldV);
			this.goldBoxArr.push({box:goldBox,x:goldBox.x,y:goldBox.y,view:goldV});
		}
	}

	__class(DesktopView,'game.module.hb.scene.DesktopView',_super);
	var __proto=DesktopView.prototype;
	__proto.onAdd=function(){
		this.toSelect();
		HbModel.instance.on("PLAYER_JOIN",this,this.playerJoin);
		this.initialPlayer(HbModel.instance.playerData.playerList);
		HbModel.instance.on("PLAYER_GOLD",this,this.playerGold);
		HbModel.instance.on("PLAYER_LEAVE",this,this.playerLeave);
		HbModel.instance.on("CAN_JOIN",this,this.onCanJion);
		HbModel.instance.on("REST",this,this.onRest);
		HbModel.instance.on("GETRULETIME",this,this.onStart);
		HbModel.instance.on("PLAYER_GETRULE",this,this.onPlayerGetrule);
		HbModel.instance.on("PLAYER_INFO",this,this.onRuleInfo);
		HbModel.instance.on("SETRULETIME",this,this.onRuleSelect);
		HbModel.instance.on("POINTTIME",this,this.onRuleConfirm);
		HbModel.instance.on("SIEVERESULTS",this,this.sieveResults);
		HbModel.instance.on("GETMONEY",this,this.getMoney);
		HbModel.instance.on("ADDGOLD",this,this.addGold);
		HbModel.instance.on("WAIT_TIME",this,this.onMatching);
	}

	/**商城**/
	__proto.onRecharge=function(){
		HbSound.effect("button");
		GlobalPopup.openShop();
	}

	/**操作列表**/
	__proto.onColumn=function(){
		var _$this=this;
		HbSound.effect("button");
		this.column.visible=!this.column.visible;
		this.timerOnce(500,this,function(){
			_$this.column.visible&&Laya.stage.once("click",this,_$this.onColumn);
		});
	}

	/**设置**/
	__proto.onSetUp=function(){
		HbSound.effect("button");
		PopupManager.open("HB","SETUP");
	}

	/**牌局记录**/
	__proto.onRecord=function(){
		HbSound.effect("button");
		PopupManager.open("HB","RECORD");
	}

	/**帮助**/
	__proto.onHelp=function(){
		HbSound.effect("button");
		PopupManager.open("HB","HELP");
	}

	/**金币减少**/
	__proto.reduceGold=function(data){
		var _$this=this;
		this.pewArr[data.i].setChange(data,false);
		this.goldBoxArr[data.i].view.showGold(true);
		this.goldBoxArr[data.i].box.scaleX=1;
		this.goldBoxArr[data.i].box.scaleY=1;
		this.goldBoxArr[data.i].box.pos(this.goldBoxArr[data.i].x,this.goldBoxArr[data.i].y);
		Tween.to(this.goldBoxArr[data.i].box,{x:610,y:310,scaleX:2,scaleY:2},700,null,Handler.create(this,function(){
			_$this.goldBoxArr[data.i].view.showGold(false);
		}));
	}

	/**清除数据**/
	__proto.toSelect=function(){
		HbModel.instance.playerData.backDelete();
		for (var i=0;i < this.pewArr.length;i++){
			this.pewArr[i].closePew();
			this.pewArr[i].isRule();
		}
		this.deleteAll();
	}

	/**清除筛子 and 弹窗 and UI**/
	__proto.deleteAll=function(){
		PopupManager.closeByGroup("hbProcedure");
		this.schedule.removeChildren();
		for (var i=0;i < this.sievesArr.length;i++){
			this.sievesArr[i].deleteSieves();
		}
	}

	/***房间列表携带参数**/
	__proto.openDesktop=function(obj){
		this.roomInfo=obj;
		this.bets.text=this.roomInfo.bets;
		this.rulefee.text="定规费："+this.roomInfo.rulefee;
		this.onMatching();
	}

	/**初始玩家计算**/
	__proto.initialPlayer=function(arr){
		for (var i=0;i < arr.length;i++){
			arr[i]&&this.playerJoin(i);
		}
	}

	/**押注**/
	__proto.playerGold=function(data){
		var _$this=this;
		this.timerOnce(3000,this,function(){
			data.fee=_$this.roomInfo.antes;
			_$this.reduceGold(data);
		})
	}

	/**匹配**/
	__proto.onMatching=function(){
		PopupManager.closeByGroup("hbProcedure");
		PopupManager.open("HB","MATCHING",null,false,false);
	}

	/**玩家入座**/
	__proto.playerJoin=function(index){
		this.pewArr[index].setUpPew(HbModel.instance.playerData.playerList[index],index==7);
	}

	/**休息准备**/
	__proto.onRest=function(time){
		this.inTheGame=false;
		this.deleteAll();
		PopupManager.open("HB","REST",time,false,false);
		this.pewArr[7].closeArrow();
		HbModel.instance.playerData.getRuleI&&this.pewArr[HbModel.instance.playerData.getRuleI].isRule(false,false);
	}

	/**开始**/
	__proto.onStart=function(time){
		this.inTheGame=true;
		HbSound.effect("start");
		if(!this.startV){
			this.startV=new Start();
		}
		this.deleteAll();
		this.schedule.addChild(this.startV);
		this.startV.isPlay(true);
		this.timerOnce(2000,this,this.onBets,[time-2000]);
	}

	/**下注塞红包**/
	__proto.onBets=function(time){
		this.startV.isPlay(false);
		this.schedule.removeChildren();
		if(!this.betV){
			this.betV=new Bet();
		}
		this.schedule.addChild(this.betV);
		this.betV.onMoneyAni();
		this.timerOnce(3000,this,this.onRuleAgree,[time-3000]);
	}

	/**规则是否参与**/
	__proto.onRuleAgree=function(time){
		this.deleteAll();
		var data={time:time,rulefee:this.roomInfo.rulefee}
		PopupManager.open("HB","RULEAGREE",data,false,false);
		for (var i=0;i < this.pewArr.length;i++){
			this.pewArr[i].playDaojishi(time);
		}
	}

	/**不参与规则制定**/
	__proto.onCanJion=function(){
		this.deleteAll();
		this.pewArr[7].stopDaojishi();
	}

	/**参与制定规则的玩家**/
	__proto.onPlayerGetrule=function(data){
		this.reduceGold(data);
		this.pewArr[data.i].isRule(true,false);
		this.pewArr[data.i].stopDaojishi();
	}

	/**竞规成功**/
	__proto.onRuleInfo=function(data){
		for (var i=0;i < this.pewArr.length;i++){
			this.pewArr[i].isRule(false,false);
			this.pewArr[i].stopDaojishi();
		}
		this.pewArr[data.i].isRule(false,true);
		this.pewArr[data.i].playDaojishi(data.time);
	}

	/**规则选择**/
	__proto.onRuleSelect=function(index){
		this.deleteAll();
		if(HbModel.instance.playerData.ruleIsMy){
			PopupManager.open("HB","RULESELECT",index,false,false);
		}
	}

	/**规则确认**/
	__proto.onRuleConfirm=function(index){
		this.deleteAll();
		PopupManager.open("HB","RULECONFIRM",index,false,false);
		this.pewArr[HbModel.instance.playerData.getRuleI].stopDaojishi();
	}

	/**筛子结果展示**/
	__proto.sieveResults=function(data){
		this.sievesArr[data.i].onSieves(data.point);
		HbSound.effect("sieves");
	}

	/**红包**/
	__proto.getMoney=function(data){
		this.deleteAll();
		PopupManager.open("HB","SLUGMONEY",data,false,false);
	}

	/**拆红包**/
	__proto.addGold=function(data){
		var _$this=this;
		this.pewArr[data.i].setChange(data,true);
		this.goldBoxArr[data.i].view.showGold(true);
		this.goldBoxArr[data.i].box.scaleX=2;
		this.goldBoxArr[data.i].box.scaleY=2;
		this.goldBoxArr[data.i].box.pos(610,310);
		Tween.to(this.goldBoxArr[data.i].box,{x:this.goldBoxArr[data.i].x,y:this.goldBoxArr[data.i].y,scaleX:1,scaleY:1},700,null,Handler.create(this,function(){
			_$this.goldBoxArr[data.i].view.showGold(false);
		}));
	}

	/**玩家离开**/
	__proto.playerLeave=function(index){
		this.pewArr[index].closePew();
	}

	/**退出房间**/
	__proto.onBack=function(){
		var _$this=this;
		HbSound.effect("button");
		if(!this.inTheGame){
			HbModel.instance.tableLeave(Handler.create(this,function(data){
				_$this.toSelect();
				HbModel.instance.event("SELECT");
			}));
			return;
		}
		Alert.show("\n是否离开本局比赛，若离开本局会正常结算！",Handler.create(this,function(isok){
			if(isok){
				HbModel.instance.tableLeave(Handler.create(this,function(data){
					_$this.toSelect();
					HbModel.instance.event("SELECT");
				}));
				HbSound.effect("button");
			}
		}));
	}

	__proto.onRemov=function(){
		HbModel.instance.off("PLAYER_JOIN",this,this.playerJoin);
		HbModel.instance.off("PLAYER_GOLD",this,this.playerGold);
		HbModel.instance.off("PLAYER_LEAVE",this,this.playerLeave);
		HbModel.instance.off("CAN_JOIN",this,this.onCanJion);
		HbModel.instance.off("REST",this,this.onRest);
		HbModel.instance.off("GETRULETIME",this,this.onStart);
		HbModel.instance.off("PLAYER_GETRULE",this,this.onPlayerGetrule);
		HbModel.instance.off("PLAYER_INFO",this,this.onRuleInfo);
		HbModel.instance.off("SETRULETIME",this,this.onRuleSelect);
		HbModel.instance.off("POINTTIME",this,this.onRuleConfirm);
		HbModel.instance.off("SIEVERESULTS",this,this.sieveResults);
		HbModel.instance.off("GETMONEY",this,this.getMoney);
		HbModel.instance.off("ADDGOLD",this,this.addGold);
		HbModel.instance.off("WAIT_TIME",this,this.onMatching);
		PopupManager.closeByGroup("hbProcedure");
		this.clearTimer(this,this.onBets);
		this.clearTimer(this,this.onRuleAgree);
	}

	__proto.destroy=function(destroyChild){
		(destroyChild===void 0)&& (destroyChild=true);
		laya.ui.View.prototype.destroy.call(this,destroyChild);
	}

	return DesktopView;
})(DesktopUI)


/**
*liuhe
*/
//class game.module.hb.scene.SelectView extends ui.hb.scene.SelectUI
var SelectView=(function(_super){
	function SelectView(){
		this.listBox=null;
		SelectView.__super.call(this);
		var _$this=this;
		EffectManager.getSkeleton(HbConfig.getAniUrl("jiaose"),Handler.create(this,function(sk){
			sk.pos(180,660);
			_$this.jiaose.addChild(sk);
		}));
		EffectManager.getSkeleton(GlobalConfig.getAniUrl("shanxian"),Handler.create(this,function(sk){
			sk.pos(30,22);
			_$this.shanxian.addChild(sk);
		}));
		this.btnBack.on("click",this,this.onBack);
		this.btnAdd.on("click",this,this.onAddGold);
		this.btnHelp.on("click",this,this.onHelp);
		this.avatar.on("click",this,this.onAvatar);
		Signal.on("SELF_INFO",this,this.onUpdateSelfInfo);
		this.onUpdateSelfInfo();
		this.roomList.hScrollBarSkin=null;
		this.roomList.selectEnable=true;
		this.roomList.mouseHandler=Handler.create(this,this.onRoomList,null,false);
		this.timerLoop(4000,this,this.onAni);
	}

	__class(SelectView,'game.module.hb.scene.SelectView',_super);
	var __proto=SelectView.prototype;
	/**************个人信息*****************/
	__proto.onUpdateSelfInfo=function(){
		this.name.text=GlobalModel.instance.self.nickname;
		this.avatar.skin=GlobalModel.instance.self.avatar;
		this.gold.text=GlobalModel.instance.self.gold/HbConfig.goldrate+"";
	}

	__proto.onAdd=function(){
		var _$this=this;
		this.roomList.visible=false;
		HbModel.instance.roomList(Handler.create(this,function(data){
			_$this.roomData(data.roomList);
		}));
	}

	/**房间数据and动画**/
	__proto.roomData=function(arr){
		var roomArr=[];
		for (var i=0;i < arr.length;i++){
			HbConfig.goldrate=arr[i].goldrate;
			roomArr.push({
				roomImg1:"res/hb/select/room"+i+"-1.png",
				roomImg2:"res/hb/select/room"+i+"-2.png",
				bets:"底注："+arr[i].antes/arr[i].goldrate,
				roomchipmin:"准入："+arr[i].roomchipmin/arr[i].goldrate,
				id:arr[i].id,
				rulefee:arr[i].rulefee/arr[i].goldrate,
				antes:arr[i].antes,
				into:arr[i].roomchipmin/arr[i].goldrate,
				btnRoom:{disabled:!arr[i].isopen}
			})
		}
		this.onUpdateSelfInfo();
		this.roomList.array=roomArr;
		this.roomList.visible=true;
		this.listBox=[];
		for (var j=0;j < this.roomList.array.length;j++){
			var boxI=this.roomList.getCell(j);
			this.listBox.push(boxI);
		}
		this.AniListBox();
		this.onAni();
	}

	/***********设置游戏列表初始值和执行帧动画*****************/
	__proto.AniListBox=function(){
		for (var i=0;i <this.listBox.length;i++){
			this.listBox[i].y=-700;
		}
		this.frameLoop(1,this,this.onListBox);
	}

	__proto.onListBox=function(){
		for (var i=0;i < this.listBox.length;i++){
			if(i==0||(i>0&&this.listBox[i-1].y>=-350)){
				if(this.listBox[i].y>=0){
					this.listBox[i].y=0;
					i==this.listBox.length-1&&this.clearTimer(this,this.onListBox);
					}else{
					this.listBox[i].y+=35;
				}
			}
		}
	}

	/**按钮闪光**/
	__proto.onAni=function(){
		for (var i=0;i < this.listBox.length;i++){
			var ani=this.listBox[i].getChildByName("ani");
			ani.play(0,false);
			ani.interval=100;
		}
	}

	__proto.onAvatar=function(){
		HbSound.effect("button");
		GlobalPopup.openUserInfo();
	}

	/**后退**/
	__proto.onBack=function(){
		HbSound.effect("button");
		Redirect.hall();
	}

	__proto.onAddGold=function(){
		HbSound.effect("button");
		GlobalPopup.openShop();
	}

	__proto.onHelp=function(){
		HbSound.effect("button");
		PopupManager.open("HB","HELP");
	}

	__proto.onRoomList=function(e,index){
		var _$this=this;
		if(e.type=="click"&& ((e.target)instanceof laya.ui.Button )){
			HbSound.effect("button");
			if(this.roomList.array[index].into>GlobalModel.instance.self.gold/HbConfig.goldrate){
				Alert.show("\n您的金币余额不足！是否立即充值？",Handler.create(this,function(isok){
					if(isok)GlobalPopup.openShop();
				}));
				return;
			}
			HbModel.instance.roomEnter({id:this.roomList.array[index].id},Handler.create(this,function(data){
				HbModel.instance.event("DESKTOP",_$this.roomList.array[index]);
				for (var i=0;i < data.playerList.length;i++){
					HbModel.instance.playerData.playerJoin=data.playerList[i];
				}
			}));
		}
	}

	return SelectView;
})(SelectUI)


/**
*liuhe
*/
//class game.module.hb.ui.Bet extends ui.hb.ui.BetUI
var Bet=(function(_super){
	function Bet(){
		Bet.__super.call(this);
	}

	__class(Bet,'game.module.hb.ui.Bet',_super);
	var __proto=Bet.prototype;
	/**红包播放动画**/
	__proto.onMoneyAni=function(){
		var _$this=this;
		this.timerOnce(1300,this,function(){
			_$this.moneyAni.visible=true;
			_$this.moneyAni.interval=100;
			_$this.moneyAni.play();
			_$this.timerOnce(500,this,function(){
				_$this.moneyAni.visible=false;
				_$this.moneyAni.stop();
			})
		})
	}

	return Bet;
})(BetUI)


/**
*liuhe
*/
//class game.module.hb.ui.Gold extends ui.hb.ui.GoldUI
var Gold=(function(_super){
	function Gold(){
		Gold.__super.call(this);
	}

	__class(Gold,'game.module.hb.ui.Gold',_super);
	var __proto=Gold.prototype;
	__proto.showGold=function(isShow){
		this.golds.visible=isShow;
	}

	return Gold;
})(GoldUI)


/**
*liuhe
*/
//class game.module.hb.ui.Pew extends ui.hb.ui.PewUI
var Pew=(function(_super){
	function Pew(){
		this.num=0;
		this.direction=true;
		this.txAni=null;
		Pew.__super.call(this);
		var _$this=this;
		EffectManager.getSkeleton(HbConfig.getAniUrl("avatarAni"),Handler.create(this,function(sk){
			_$this.txAni=sk;
			_$this.txAni.pos(44,44);
			_$this.avatarAni.addChild(_$this.txAni);
			_$this.txAni.paused();
		}));
	}

	__class(Pew,'game.module.hb.ui.Pew',_super);
	var __proto=Pew.prototype;
	/**
	*设置座位
	*@param data 玩家数据
	*@param isMy 是否是自己（可选）默认为false
	*/
	__proto.setUpPew=function(data,isMy){
		(isMy===void 0)&& (isMy=false);
		this.pewBox.visible=true;
		this.avatar.skin=data.avatar || "";
		this.name.text=data.name ||data.nickname || "";
		this.gold.text=(data.gold/HbConfig.goldrate).toFixed(2)|| "";
		this.arrow.visible=isMy;
		isMy&&this.timerLoop(30,this,this.onArrow);
	}

	__proto.onArrow=function(){
		this.num++;
		if(this.num>=10){
			this.num=0;
			this.direction=!this.direction;
		}
		if(this.direction){
			this.arrow.y++;
			}else{
			this.arrow.y--;
		}
	}

	/**关闭是自己的动画**/
	__proto.closeArrow=function(){
		this.arrow.visible=false;
		this.clearTimer(this,this.onArrow);
	}

	/**隐藏座位**/
	__proto.closePew=function(){
		this.pewBox.visible=false;
	}

	/**
	*金币变化
	*@param str 变化数值
	*@param isAdd 是否为加金币
	*/
	__proto.setChange=function(data,isAdd){
		var _$this=this;
		HbSound.effect("gold");
		if(isAdd){
			this.change.text="+"+(data.addgold/HbConfig.goldrate).toFixed(2);
			this.change.color="#ffEa00";
			this.avatarAni.visible=true;
			this.txAni.resume();
			}else{
			this.change.text="-"+(data.fee/HbConfig.goldrate).toFixed(2);
			this.change.color="#b5b5b5";
		}
		this.gold.text=(data.gold/HbConfig.goldrate).toFixed(2)|| "";
		this.change.visible=true;
		Tween.to(this.change,{y:30},1500,null,Handler.create(this,function(){
			_$this.change.visible=false;
			_$this.change.y=70;
			_$this.txAni.paused();
			_$this.avatarAni.visible=false;
		}));
	}

	/**
	*局主竞规是否显示
	*@param is1 是否显示竞选（默认不显示）
	*@param is2 是否显示局选（默认不显示）
	*/
	__proto.isRule=function(is1,is2){
		(is1===void 0)&& (is1=false);
		(is2===void 0)&& (is2=false);
		this.ruleBox1.visible=is1;
		this.ruleBox2.visible=is2;
	}

	/**头像框倒计时**/
	__proto.playDaojishi=function(time){
		this.daojishi.visible=true;
		this.daojishi.interval=time/30;
		this.daojishi.play(0);
		this.timerOnce(time,this,this.stopDaojishi);
	}

	__proto.stopDaojishi=function(){
		this.daojishi.visible=false;
		this.daojishi.stop();
	}

	return Pew;
})(PewUI)


/**
*liuhe
*/
//class game.module.hb.ui.Sieves extends ui.hb.ui.SievesUI
var Sieves=(function(_super){
	function Sieves(){
		this.ani=null;
		Sieves.__super.call(this);
	}

	__class(Sieves,'game.module.hb.ui.Sieves',_super);
	var __proto=Sieves.prototype;
	/**
	*设置骰子点数
	*@param index 点数
	*/
	__proto.onSieves=function(index){
		var _$this=this;
		this.sievesImg.visible=false;
		this.saizi.visible=true;
		this.sievesImg.skin="res/hb/ui/sieves"+index+".png";
		EffectManager.getSkeleton(HbConfig.getAniUrl("saizi"),Handler.create(this,function(sk){
			_$this.ani=sk;
			_$this.ani.pos(30,35);
			_$this.saizi.addChild(_$this.ani);
		}));
		this.timerOnce(1000,this,this.onTimer);
	}

	__proto.onTimer=function(){
		this.sievesImg.visible=true;
		this.ani&&this.ani.destroy();
		this.saizi.visible=false;
	}

	/**隐藏骰子**/
	__proto.deleteSieves=function(){
		this.ani&&this.ani.destroy();
		this.sievesImg.visible=false;
		this.saizi.visible=false;
	}

	return Sieves;
})(SievesUI)


/**
*liuhe
*/
//class game.module.hb.ui.Start extends ui.hb.ui.StartUI
var Start=(function(_super){
	function Start(){
		this.ani=null;
		Start.__super.call(this);
	}

	__class(Start,'game.module.hb.ui.Start',_super);
	var __proto=Start.prototype;
	__proto.isPlay=function(isP){
		var _$this=this;
		if(isP){
			EffectManager.getSkeleton(HbConfig.getAniUrl("youxikaishi"),Handler.create(this,function(sk){
				_$this.ani=sk;
				_$this.ani.x=650;
				_$this.ani.y=360;
				_$this.addChild(_$this.ani);
			}));
			}else{
			this.ani.stop();
			this.ani.destroy();
		}
	}

	return Start;
})(StartUI$1)


/**
*liuhe
*/
//class game.module.hb.popup.HbSetUpView extends ui.hb.popup.HbSetUpUI
var HbSetUpView=(function(_super){
	function HbSetUpView(){
		this._status=null;
		this._data=null;
		HbSetUpView.__super.call(this);
		this.zOrder=9999;
		this.musicNum.changeHandler=Handler.create(this,this.onMusicNums,null,false);
		this.effectNum.changeHandler=Handler.create(this,this.onEffectNum,null,false);
		this.btnMusic.on("click",this,this.onMusic);
		this.btnEffect.on("click",this,this.onEffect);
	}

	__class(HbSetUpView,'game.module.hb.popup.HbSetUpView',_super);
	var __proto=HbSetUpView.prototype;
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

	return HbSetUpView;
})(HbSetUpUI)


/**
*liuhe
*/
//class game.module.hb.popup.HelpView extends ui.hb.popup.HelpUI
var HelpView=(function(_super){
	function HelpView(){
		HelpView.__super.call(this);
		this.zOrder=9999;
		this.btnClose.on("click",this,this.onClose);
	}

	__class(HelpView,'game.module.hb.popup.HelpView',_super);
	var __proto=HelpView.prototype;
	__proto.onClose=function(){
		HbSound.effect("button");
		this.close();
	}

	return HelpView;
})(HelpUI)


/**
*liuhe
*/
//class game.module.hb.popup.MatchingView extends ui.hb.popup.MatchingUI
var MatchingView=(function(_super){
	function MatchingView(){
		MatchingView.__super.call(this);
		var _$this=this;
		this.group="hbProcedure";
		EffectManager.getSkeleton(HbConfig.getAniUrl("zzwnpp"),Handler.create(this,function(sk){
			sk.x=180;
			sk.y=30;
			_$this.addChild(sk);
		}));
	}

	__class(MatchingView,'game.module.hb.popup.MatchingView',_super);
	return MatchingView;
})(MatchingUI)


/**
*liuhe
*/
//class game.module.hb.popup.RecordView extends ui.hb.popup.RecordUI
var RecordView=(function(_super){
	function RecordView(){
		RecordView.__super.call(this);
		this.zOrder=9999;
		this.recordList.vScrollBarSkin=null;
		this.recordList.selectEnable=true;
		this.recordList.scrollBar.elasticBackTime=150;
		this.recordList.scrollBar.elasticDistance=200;
		this.btnClose.on("click",this,this.onClose);
	}

	__class(RecordView,'game.module.hb.popup.RecordView',_super);
	var __proto=RecordView.prototype;
	__proto.onClose=function(){
		HbSound.effect("button");
		this.close();
	}

	__proto.onOpened=function(){
		this.recordList.array=HbModel.instance.ruleData.getResult;
	}

	return RecordView;
})(RecordUI)


/**
*liuhe
*/
//class game.module.hb.popup.RestView extends ui.hb.popup.RestUI
var RestView=(function(_super){
	function RestView(){
		this.time=0;
		RestView.__super.call(this);
		this.group="hbProcedure";
	}

	__class(RestView,'game.module.hb.popup.RestView',_super);
	var __proto=RestView.prototype;
	__proto.onTimer=function(){
		this.time--;
		if(this.time<10){
			this.timerNum.value="0"+this.time;
			}else{
			this.timerNum.value=""+this.time;
		}
		if(this.time<=0){
			this.close();
			this.clearTimer(this,this.onTimer);
		}
	}

	__getset(0,__proto,'dataSource',_super.prototype._$get_dataSource,function(value){
		this.time=value/1000;
		this.timerNum.value=this.time+"";
		this.timerLoop(1000,this,this.onTimer);
	});

	return RestView;
})(RestUI)


/**
*liuhe
*/
//class game.module.hb.popup.RuleAgreeView extends ui.hb.popup.RuleAgreeUI
var RuleAgreeView=(function(_super){
	function RuleAgreeView(){
		this.time=0;
		RuleAgreeView.__super.call(this);
		this.group="hbProcedure";
		this.btnJoin.on("click",this,this.onJoin);
		this.btnCanJoin.on("click",this,this.onCanJoin);
	}

	__class(RuleAgreeView,'game.module.hb.popup.RuleAgreeView',_super);
	var __proto=RuleAgreeView.prototype;
	__proto.onTimer=function(){
		this.time--;
		this.timeNum.text=this.time+"";
		if(this.time<=0){
			this.close();
			this.clearTimer(this,this.onTimer);
		}
	}

	__proto.onJoin=function(){
		this.tableGetrule(1);
	}

	__proto.onCanJoin=function(){
		this.tableGetrule(-1);
		HbModel.instance.event("CAN_JOIN");
	}

	__proto.tableGetrule=function(index){
		HbSound.effect("button");
		HbModel.instance.tableGetrule({getrule:index});
		this.close();
	}

	__getset(0,__proto,'dataSource',_super.prototype._$get_dataSource,function(data){
		this.time=data.time/1000;
		this.timeNum.text=this.time+"";
		this.rulefee.text="参与竞选需要支付"+data.rulefee+"金币...";
		this.timerLoop(1000,this,this.onTimer);
	});

	return RuleAgreeView;
})(RuleAgreeUI)


/**
*liuhe
*/
//class game.module.hb.popup.RuleConfirmView extends ui.hb.popup.RuleConfirmUI
var RuleConfirmView=(function(_super){
	function RuleConfirmView(){
		this.time=0;
		RuleConfirmView.__super.call(this);
		this.group="hbProcedure";
		this.btnBetting.on("click",this,this.onBetting);
	}

	__class(RuleConfirmView,'game.module.hb.popup.RuleConfirmView',_super);
	var __proto=RuleConfirmView.prototype;
	__proto.onTimer=function(){
		this.time--;
		this.timeNum.text=this.time+"";
		if(this.time<=0){
			this.close();
			this.clearTimer(this,this.onTimer);
		}
	}

	__proto.onBetting=function(){
		HbSound.effect("button");
		HbModel.instance.tableOpen();
		this.close();
	}

	__getset(0,__proto,'dataSource',_super.prototype._$get_dataSource,function(value){
		this.time=value/1000;
		this.timeNum.text=this.time+"";
		this.timerLoop(1000,this,this.onTimer);
		this.ruleText.text=HbModel.instance.ruleData.getRule;
	});

	return RuleConfirmView;
})(RuleConfirmUI)


/**
*liuhe
*/
//class game.module.hb.popup.RuleSelectView extends ui.hb.popup.RuleSelectUI
var RuleSelectView=(function(_super){
	function RuleSelectView(){
		this.time=0;
		RuleSelectView.__super.call(this);
		this.group="hbProcedure";
		var arr=HbModel.instance.ruleData.ruleList;
		this.ruleSelectList.array=[];
		for (var i=0;i < arr.length;i++){
			this.ruleSelectList.array.push({explain:arr[i]});
		}
		this.ruleSelectList.hScrollBarSkin=null;
		this.ruleSelectList.selectEnable=true;
		this.ruleSelectList.scrollBar.elasticBackTime=150;
		this.ruleSelectList.scrollBar.elasticDistance=200;
		this.ruleSelectList.mouseHandler=Handler.create(this,this.onRuleSelectList,null,false);
	}

	__class(RuleSelectView,'game.module.hb.popup.RuleSelectView',_super);
	var __proto=RuleSelectView.prototype;
	__proto.onRuleSelectList=function(e,index){
		if(e.type=="click"){
			HbSound.effect("button");
			HbModel.instance.tableSetrule({ruleid:index+1});
			HbModel.instance.event("CAN_JOIN");
			this.close();
		}
	}

	__proto.onTimer=function(){
		this.time--;
		this.timeNum.text=this.time+"";
		if(this.time<=0){
			this.close();
			this.clearTimer(this,this.onTimer);
		}
	}

	__getset(0,__proto,'dataSource',_super.prototype._$get_dataSource,function(value){
		this.time=value/1000;
		this.timeNum.text=this.time+"";
		this.timerLoop(1000,this,this.onTimer);
	});

	return RuleSelectView;
})(RuleSelectUI)


/**
*liuhe
*/
//class game.module.hb.popup.SlugMoneyView extends ui.hb.popup.SlugMoneyUI
var SlugMoneyView=(function(_super){
	function SlugMoneyView(){
		this.time=0;
		SlugMoneyView.__super.call(this);
		this.group="hbProcedure";
		this.btnOpen.on("click",this,this.onOpen);
	}

	__class(SlugMoneyView,'game.module.hb.popup.SlugMoneyView',_super);
	var __proto=SlugMoneyView.prototype;
	__proto.onTimer=function(){
		this.time--;
		this.openNum.text=this.time+"";
		if(this.time<=0){
			this.close();
			this.clearTimer(this,this.onTimer);
		}
	}

	__proto.onOpen=function(){
		var _$this=this;
		HbSound.effect("button");
		HbModel.instance.tableMoney(Handler.create(this,function(data){
			_$this.onJinbi();
		}));
	}

	__proto.onJinbi=function(){
		HbSound.effect("jinbi");
		Jinbi.aniPlay();
		this.close();
	}

	__getset(0,__proto,'dataSource',_super.prototype._$get_dataSource,function(data){
		this.time=data.time/1000;
		this.openNum.text=this.time+"";
		this.timerLoop(1000,this,this.onTimer);
		if(data.iswin==1){
			this.noOpen.visible=false;
			this.open.visible=true;
			HbSound.effect("win")
			this.timerOnce(1500,this,this.onJinbi);
			}else{
			this.noOpen.visible=true;
			this.open.visible=false;
			HbSound.effect("lose");
		}
	});

	return SlugMoneyView;
})(SlugMoneyUI)


/**
*liuhe
*/
//class game.module.hb.popup.StartView extends ui.hb.popup.StartUI
var StartView=(function(_super){
	function StartView(){
		StartView.__super.call(this);
		var _$this=this;
		this.group="hbProcedure";
		EffectManager.getSkeleton(HbConfig.getAniUrl("youxikaishi"),Handler.create(this,function(sk){
			sk.x=300;
			sk.y=200;
			_$this.addChild(sk);
		}));
	}

	__class(StartView,'game.module.hb.popup.StartView',_super);
	return StartView;
})(StartUI)



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