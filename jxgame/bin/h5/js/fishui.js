
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Box=laya.ui.Box,Button=laya.ui.Button,CheckBox=laya.ui.CheckBox,Dialog=laya.ui.Dialog,FontClip=laya.ui.FontClip;
	var HSlider=laya.ui.HSlider,Image=laya.ui.Image,Label=laya.ui.Label,List=laya.ui.List,Sprite=laya.display.Sprite;
	var Text=laya.display.Text,View=laya.ui.View;
//class ui.fish.scene.FishSceneUI extends laya.ui.View
var FishSceneUI=(function(_super){
	function FishSceneUI(){
		this.gamebg=null;
		this.fishPanel=null;
		this.bulletPanel=null;
		this.batteryPanel=null;
		this.propPanel=null;
		this.waterPanel=null;
		this.btnpanel=null;
		this.closeBtn=null;
		this.autoFire=null;
		this.autoLock=null;
		this.btnsbg=null;
		this.gamehelp=null;
		this.gameexit=null;
		this.gameset=null;
		this.btnVisible1=null;
		this.btnVisible2=null;
		this.btnshop=null;
		this.iceProp=null;
		this.iceEffect=null;
		this.iceTimer=null;
		this.flashProp=null;
		this.flashEffect=null;
		this.flashTimer=null;
		this.fireProp=null;
		this.fireEffect=null;
		this.fireTimer=null;
		this.mengban=null;
		this.mengbanbg=null;
		this.bulNum=null;
		this.fishNum=null;
		this.coNum=null;
		FishSceneUI.__super.call(this);
	}

	__class(FishSceneUI,'ui.fish.scene.FishSceneUI',_super);
	var __proto=FishSceneUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(FishSceneUI.uiView);
	}

	FishSceneUI.uiView={"type":"View","props":{"width":1920,"height":1080},"child":[{"type":"Image","props":{"y":540,"x":960,"width":1920,"var":"gamebg","skin":"res/fish/image/bg1.jpg","height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Box","props":{"y":540,"x":960,"width":1920,"var":"fishPanel","height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Button","props":{"y":540,"x":960,"width":1920,"var":"bulletPanel","height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":540,"x":960,"width":1920,"var":"batteryPanel","mouseThrough":true,"height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":540,"x":960,"width":1920,"var":"propPanel","mouseThrough":true,"height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":540,"x":960,"width":1920,"var":"waterPanel","mouseThrough":true,"height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Box","props":{"y":540,"x":960,"width":1920,"var":"btnpanel","mouseThrough":true,"height":1080,"anchorY":0.5,"anchorX":0.5},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1920,"var":"closeBtn","height":1080}},{"type":"Button","props":{"y":942,"x":823,"var":"autoFire","stateNum":1,"skin":"res/fish/textures/zidongfashe.png"}},{"type":"Button","props":{"y":944,"x":976,"var":"autoLock","stateNum":1,"skin":"res/fish/textures/zidongsuoding.png"}},{"type":"Image","props":{"y":11,"x":1755,"var":"btnsbg","skin":"res/fish/textures/btnvisiblebg.png","scaleY":1},"child":[{"type":"Button","props":{"y":393,"x":12,"var":"gamehelp","stateNum":1,"skin":"res/fish/textures/btnHelp.png"}},{"type":"Button","props":{"y":131,"x":12,"var":"gameexit","stateNum":1,"skin":"res/fish/textures/btnOut.png"}},{"type":"Button","props":{"y":262,"x":12,"var":"gameset","stateNum":1,"skin":"res/fish/textures/btnSetup.png"}}]},{"type":"Button","props":{"y":21,"x":1767,"visible":true,"var":"btnVisible1","stateNum":1,"skin":"res/fish/textures/btnvisible1.png"}},{"type":"Button","props":{"y":21,"x":1767,"visible":true,"var":"btnVisible2","stateNum":1,"skin":"res/fish/textures/btnvisible2.png"}},{"type":"Button","props":{"y":239,"x":116,"var":"btnshop","stateNum":1,"skin":"res/fish/textures/chongzhi.png","anchorY":0.5,"anchorX":0.5},"child":[{"type":"Label","props":{"y":80,"x":50,"name":"propIceTime","fontSize":30,"font":"Arial","color":"#000000","anchorY":0.5,"anchorX":0.5,"align":"center"}}]},{"type":"Sprite","props":{},"child":[{"type":"Image","props":{"y":718,"x":80,"var":"iceProp","skin":"res/fish/textures/prop2.png","anchorY":0.5,"anchorX":0.5}},{"type":"Sprite","props":{"y":0,"x":0},"child":[{"type":"Image","props":{"y":658,"x":22,"skin":"res/fish/textures/icon.png"}},{"type":"Sprite","props":{"y":654,"x":20,"width":122,"var":"iceEffect","renderType":"mask","height":126}}]},{"type":"Label","props":{"y":718,"x":80,"var":"iceTimer","fontSize":30,"color":"#000000","anchorY":0.5,"anchorX":0.5}}]},{"type":"Sprite","props":{"y":145,"x":2},"child":[{"type":"Image","props":{"y":718,"x":80,"var":"flashProp","skin":"res/fish/textures/prop3.png","anchorY":0.5,"anchorX":0.5}},{"type":"Sprite","props":{"y":0,"x":0},"child":[{"type":"Image","props":{"y":658,"x":22,"skin":"res/fish/textures/icon.png"}},{"type":"Sprite","props":{"y":654,"x":20,"width":122,"var":"flashEffect","renderType":"mask","height":126}}]},{"type":"Label","props":{"y":718,"x":80,"var":"flashTimer","fontSize":30,"color":"#000000","anchorY":0.5,"anchorX":0.5}}]},{"type":"Sprite","props":{"y":-149,"x":3},"child":[{"type":"Image","props":{"y":718,"x":80,"var":"fireProp","skin":"res/fish/textures/prop1.png","anchorY":0.5,"anchorX":0.5}},{"type":"Sprite","props":{"y":0,"x":0},"child":[{"type":"Image","props":{"y":658,"x":22,"skin":"res/fish/textures/icon.png"}},{"type":"Sprite","props":{"y":654,"x":20,"width":122,"var":"fireEffect","renderType":"mask","height":126}}]},{"type":"Label","props":{"y":718,"x":80,"var":"fireTimer","fontSize":30,"color":"#000000","anchorY":0.5,"anchorX":0.5}}]}]},{"type":"Sprite","props":{"y":0,"x":0,"width":1920,"var":"mengban","height":1080,"alpha":0.5},"child":[{"type":"Rect","props":{"y":0,"x":0,"width":1920,"lineWidth":1,"height":1080,"fillColor":"#000000"}}]},{"type":"Image","props":{"y":540,"x":960,"width":1920,"var":"mengbanbg","height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Label","props":{"y":493,"x":871,"visible":false,"var":"bulNum","text":"8888","fontSize":70,"color":"#ff0400"}},{"type":"Label","props":{"y":582,"x":876,"visible":false,"var":"fishNum","text":"8888","fontSize":70,"color":"#ff0400"}},{"type":"Label","props":{"y":676,"x":876,"visible":false,"var":"coNum","text":"8888","fontSize":70,"color":"#ff0400"}}]};
	return FishSceneUI;
})(View)


//class ui.fish.scene.RoomViewUI extends laya.ui.View
var RoomViewUI=(function(_super){
	function RoomViewUI(){
		this.back=null;
		this.userHead=null;
		this.roomList=null;
		this.userName=null;
		this.userScore=null;
		RoomViewUI.__super.call(this);
	}

	__class(RoomViewUI,'ui.fish.scene.RoomViewUI',_super);
	var __proto=RoomViewUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(RoomViewUI.uiView);
	}

	RoomViewUI.uiView={"type":"View","props":{"width":1920,"height":1080},"child":[{"type":"Image","props":{"y":540,"x":960,"skin":"res/fish/room/bj.png","anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":30,"x":31,"var":"back","skin":"res/fish/room/close.png"}},{"type":"Image","props":{"y":38.5,"x":1551,"skin":"res/fish/room/goldframe.png"}},{"type":"Image","props":{"y":50,"x":260,"skin":"res/fish/room/goldframe.png"}},{"type":"Image","props":{"y":38,"x":1551,"skin":"res/fish/room/gold.png"}},{"type":"Image","props":{"y":84,"x":262,"skin":"res/fish/room/headframe.png","anchorY":0.5,"anchorX":0.5},"child":[{"type":"Image","props":{"y":52,"x":52,"var":"userHead","anchorY":0.5,"anchorX":0.5}}]},{"type":"Image","props":{"y":84,"x":262,"skin":"res/fish/room/headframe1.png","anchorY":0.5,"anchorX":0.5}},{"type":"List","props":{"y":623,"x":991,"width":1740,"var":"roomList","spaceY":1000,"spaceX":-30,"height":800,"anchorY":0.5,"anchorX":0.5},"child":[{"type":"Box","props":{"y":409,"x":300,"width":600,"renderType":"render","height":631,"anchorY":0.5,"anchorX":0.5},"child":[{"type":"Image","props":{"y":578,"x":250,"skin":"res/fish/room/icon1.png","name":"icon","anchorY":1,"anchorX":0.5}},{"type":"Image","props":{"y":421,"x":265,"skin":"res/fish/room/num1.png","name":"num","anchorY":1,"anchorX":0.5}},{"type":"Label","props":{"y":484,"x":267,"text":"准入: 10","strokeColor":"#1c5914","stroke":5,"name":"min","fontSize":30,"font":"Microsoft YaHei","color":"#ffffff","anchorY":0.5,"anchorX":0.5,"align":"center"}}]}]},{"type":"Label","props":{"y":80,"x":321,"var":"userName","text":"XXXXXX","strokeColor":"#021b0c","fontSize":30,"font":"Microsoft YaHei","color":"#ffffff","anchorY":0.5,"anchorX":0,"align":"left"}},{"type":"Label","props":{"y":69,"x":1628,"var":"userScore","text":"8888888888","strokeColor":"#021b0c","fontSize":30,"font":"Microsoft YaHei","color":"#ffffff","anchorY":0.5,"anchorX":0,"align":"center"}}]};
	return RoomViewUI;
})(View)


//class ui.fish.popup.FishAlertUI extends laya.ui.View
var FishAlertUI=(function(_super){
	function FishAlertUI(){
		this.closeLayer=null;
		this.close=null;
		this.closeBtn=null;
		this.enterBtn=null;
		this.text=null;
		FishAlertUI.__super.call(this);
	}

	__class(FishAlertUI,'ui.fish.popup.FishAlertUI',_super);
	var __proto=FishAlertUI.prototype;
	__proto.createChildren=function(){
		View.regComponent("Text",Text);
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(FishAlertUI.uiView);
	}

	FishAlertUI.uiView={"type":"View","props":{"width":1920,"height":1080},"child":[{"type":"Image","props":{"y":0,"x":0,"visible":false,"skin":"res/fish/image/bg1.jpg"}},{"type":"Sprite","props":{"y":0,"x":0,"width":1920,"var":"closeLayer","height":1080}},{"type":"Image","props":{"y":222,"x":551,"width":813,"skin":"res/fish/textures/top.png","sizeGrid":"19,16,0,14","mouseEnabled":true,"height":102}},{"type":"Image","props":{"y":273,"x":1313,"var":"close","skin":"res/fish/textures/close.png","anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":237,"x":865,"skin":"res/fish/textures/titletip.png"}},{"type":"Image","props":{"y":322,"x":550,"width":815,"skin":"res/fish/textures/panel1.png","sizeGrid":"0,230,105,263","height":465}},{"type":"Image","props":{"y":336,"x":575,"width":760,"skin":"res/fish/textures/panel2.png","sizeGrid":"18,18,18,19","height":294}},{"type":"Image","props":{"y":698,"x":754,"var":"closeBtn","skin":"res/fish/textures/btncancel.png","anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":698,"x":1166,"var":"enterBtn","skin":"res/fish/textures/btnsure.png","anchorY":0.5,"anchorX":0.5}},{"type":"Text","props":{"y":371,"x":601,"wordWrap":true,"width":698,"var":"text","leading":20,"height":231,"fontSize":40,"font":"Microsoft YaHei","color":"#8dd0e1","align":"center"}}]};
	return FishAlertUI;
})(View)


//class ui.fish.popup.FishHelpUI extends laya.ui.Dialog
var FishHelpUI=(function(_super){
	function FishHelpUI(){
		FishHelpUI.__super.call(this);;
	}

	__class(FishHelpUI,'ui.fish.popup.FishHelpUI',_super);
	var __proto=FishHelpUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(FishHelpUI.uiView);
	}

	FishHelpUI.uiView={"type":"Dialog","props":{"width":1920,"height":1080},"child":[{"type":"Image","props":{"y":0,"x":0,"visible":false,"skin":"res/fish/image/bg1.jpg"}},{"type":"Image","props":{"y":179,"x":320,"width":1295,"skin":"res/fish/textures/panel1.png","sizeGrid":"0,127,106,127","height":795}},{"type":"Image","props":{"y":78,"x":323,"width":1290,"skin":"res/fish/textures/top.png","sizeGrid":"0,19,0,19","height":102}},{"type":"Image","props":{"y":97,"x":873,"skin":"res/fish/textures/titlehelp.png"}},{"type":"Image","props":{"y":191,"x":346,"skin":"res/fish/textures/panel3.png"}},{"type":"Button","props":{"y":78,"x":1509,"stateNum":1,"skin":"res/fish/textures/close.png","name":"close"}}]};
	return FishHelpUI;
})(Dialog)


//class ui.fish.popup.RewardUI extends laya.ui.Dialog
var RewardUI=(function(_super){
	function RewardUI(){
		this.aniNode=null;
		this.score=null;
		RewardUI.__super.call(this);
	}

	__class(RewardUI,'ui.fish.popup.RewardUI',_super);
	var __proto=RewardUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(RewardUI.uiView);
	}

	RewardUI.uiView={"type":"Dialog","props":{"width":1920,"mouseThrough":true,"height":1080},"child":[{"type":"Image","props":{"visible":false,"skin":"res/fish/image/bg1.jpg"}},{"type":"Image","props":{"y":540,"x":960,"var":"aniNode","mouseThrough":true}},{"type":"FontClip","props":{"y":620,"x":960,"var":"score","skin":"res/fish/textures/goldnum1.png","sheet":"0123456789","anchorY":0.5,"anchorX":0.5}}]};
	return RewardUI;
})(Dialog)


//class ui.fish.popup.SettingUI extends laya.ui.Dialog
var SettingUI=(function(_super){
	function SettingUI(){
		this.btnMusic=null;
		this.btnEffect=null;
		this.musicNum=null;
		this.effectNum=null;
		SettingUI.__super.call(this);
	}

	__class(SettingUI,'ui.fish.popup.SettingUI',_super);
	var __proto=SettingUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(SettingUI.uiView);
	}

	SettingUI.uiView={"type":"Dialog","props":{"width":1920,"height":1080},"child":[{"type":"Image","props":{"visible":false,"skin":"res/fish/image/bg1.jpg"}},{"type":"Image","props":{"y":216,"x":310,"width":1295,"skin":"res/fish/textures/panel1.png","sizeGrid":"0,127,106,127","height":736}},{"type":"Image","props":{"y":114,"x":313,"width":1290,"skin":"res/fish/textures/top.png","sizeGrid":"0,19,0,19","height":102}},{"type":"Image","props":{"y":135,"x":865,"skin":"res/fish/textures/titlesetting.png"}},{"type":"Button","props":{"y":114,"x":1500,"stateNum":1,"skin":"res/fish/textures/close.png","name":"close"}},{"type":"Image","props":{"y":325,"x":1199,"skin":"res/fish/textures/titleeffic1.png"}},{"type":"Image","props":{"y":322,"x":531,"skin":"res/fish/textures/titlemusic1.png"}},{"type":"CheckBox","props":{"y":407,"x":496,"var":"btnMusic","skin":"res/fish/textures/checkbox_switch.png.png"}},{"type":"CheckBox","props":{"y":407,"x":1146,"var":"btnEffect","skin":"res/fish/textures/checkbox_switch.png.png"}},{"type":"Image","props":{"y":639,"x":442,"skin":"res/fish/textures/titlemusic.png"}},{"type":"HSlider","props":{"y":629,"x":600,"width":952,"var":"musicNum","value":100,"skin":"res/fish/textures/hslider.png","sizeGrid":"0,68,0,34","showLabel":false,"height":75}},{"type":"Image","props":{"y":764,"x":442,"skin":"res/fish/textures/titleeffic.png"}},{"type":"HSlider","props":{"y":753,"x":598,"width":952,"var":"effectNum","value":100,"skin":"res/fish/textures/hslider.png","sizeGrid":"0,68,0,34","showLabel":false,"height":75}},{"type":"Image","props":{"y":563,"x":330,"skin":"res/fish/textures/settingline.png"},"child":[{"type":"Image","props":{"y":4,"x":1270,"skin":"res/fish/textures/settingline.png","rotation":180}}]}]};
	return SettingUI;
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