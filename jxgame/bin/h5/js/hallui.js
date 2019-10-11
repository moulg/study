
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Button=laya.ui.Button,CheckBox=laya.ui.CheckBox,Dialog=laya.ui.Dialog,HSlider=laya.ui.HSlider;
	var Image=laya.ui.Image,Label=laya.ui.Label,List=laya.ui.List,Sprite=laya.display.Sprite,View=laya.ui.View;
//class ui.hall.scene.HomeUI extends laya.ui.View
var HomeUI=(function(_super){
	function HomeUI(){
		this.gameList=null;
		this.jinxiujiaose=null;
		this.btnBack=null;
		this.avatar=null;
		this.name=null;
		this.gold=null;
		this.shanxian=null;
		this.btnAdd=null;
		this.btnSetUp=null;
		HomeUI.__super.call(this);
	}

	__class(HomeUI,'ui.hall.scene.HomeUI',_super);
	var __proto=HomeUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(HomeUI.uiView);
	}

	HomeUI.uiView={"type":"View","props":{"width":1280,"height":720},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/hall/home/bg.png"}},{"type":"List","props":{"y":215,"x":323,"width":958,"var":"gameList","height":298},"child":[{"type":"Box","props":{"y":0,"x":0,"width":301,"renderType":"render","height":298},"child":[{"type":"Image","props":{"y":24,"x":37,"width":264,"name":"logo","height":274}},{"type":"Image","props":{"x":241,"width":25,"name":"hotSign","height":25}},{"type":"Image","props":{"y":17,"x":225,"skin":"res/hall/home/yun.png"}},{"type":"Animation","props":{"y":-69,"x":-91,"width":512,"source":"res/hall/xingdian/xingdian_0.png,res/hall/xingdian/xingdian_1.png,res/hall/xingdian/xingdian_10.png,res/hall/xingdian/xingdian_11.png,res/hall/xingdian/xingdian_12.png,res/hall/xingdian/xingdian_13.png,res/hall/xingdian/xingdian_14.png,res/hall/xingdian/xingdian_2.png,res/hall/xingdian/xingdian_3.png,res/hall/xingdian/xingdian_4.png,res/hall/xingdian/xingdian_5.png,res/hall/xingdian/xingdian_6.png,res/hall/xingdian/xingdian_7.png,res/hall/xingdian/xingdian_8.png,res/hall/xingdian/xingdian_9.png","skin":"res/hall/xingdian/xingdian_0.png","interval":150,"height":400,"autoPlay":true}}]}]},{"type":"Image","props":{"y":0,"x":0,"skin":"res/hall/home/cover.png"}},{"type":"Sprite","props":{"y":65,"x":0,"var":"jinxiujiaose","skin":"res/hb/select/text1.png"}},{"type":"Box","props":{"y":0,"x":0},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":68,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":136,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":204,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":272,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":340,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":408,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":476,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":544,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":612,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":680,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":748,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":816,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":884,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":952,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":1020,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":1088,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":1155,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":1223,"skin":"res/common/public/head.png"}}]},{"type":"Button","props":{"y":8,"x":17,"var":"btnBack","stateNum":1,"skin":"res/common/public/back.png"}},{"type":"Image","props":{"y":3,"x":96,"skin":"res/common/public/avatarBg.png"}},{"type":"Image","props":{"y":5,"x":98,"width":52,"var":"avatar","stateNum":1,"height":52}},{"type":"Label","props":{"y":21,"x":164,"width":181,"var":"name","text":"昵称长度八个字符","overflow":"hidden","height":22,"fontSize":22,"color":"#E4BC88"}},{"type":"Image","props":{"y":7,"x":879,"width":267,"skin":"res/common/public/radiusBg2.png","height":49,"sizeGrid":"16,18,17,12"}},{"type":"Label","props":{"y":15,"x":912,"width":203,"var":"gold","text":180002,"overflow":"hidden","fontSize":30,"color":"#E4BC88","align":"center"}},{"type":"Image","props":{"y":7,"x":856,"skin":"res/common/public/gold.png"}},{"type":"Sprite","props":{"y":7,"x":856,"var":"shanxian","skin":"res/common/public/gold.png"}},{"type":"Button","props":{"y":6,"x":1115,"var":"btnAdd","stateNum":1,"skin":"res/common/public/goldAdd.png"}},{"type":"Button","props":{"y":7,"x":1204,"var":"btnSetUp","stateNum":1,"skin":"res/common/public/setUp.png"}},{"type":"Image","props":{"y":64,"x":0,"width":1280,"skin":"res/common/public/head2.png","sizeGrid":"0,2,0,2"}}]};
	return HomeUI;
})(View)


//class ui.hall.popup.HallSetUpUI extends laya.ui.Dialog
var HallSetUpUI=(function(_super){
	function HallSetUpUI(){
		this.btnClose=null;
		this.btnMusic=null;
		this.btnEffect=null;
		this.musicNum=null;
		this.effectNum=null;
		HallSetUpUI.__super.call(this);
	}

	__class(HallSetUpUI,'ui.hall.popup.HallSetUpUI',_super);
	var __proto=HallSetUpUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(HallSetUpUI.uiView);
	}

	HallSetUpUI.uiView={"type":"Dialog","props":{"width":1016,"height":608},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg3.png"}},{"type":"Image","props":{"y":28,"x":375,"skin":"res/common/public/title.png"}},{"type":"Image","props":{"y":37,"x":464,"skin":"res/common/public/setUp0.png"}},{"type":"Image","props":{"y":94,"x":56,"width":890,"skin":"res/common/public/radiusBor1.png","height":480,"sizeGrid":"10,10,10,10"}},{"type":"Button","props":{"y":3,"x":939,"var":"btnClose","stateNum":1,"skin":"res/common/public/close.png"}},{"type":"Label","props":{"y":151,"x":234,"text":"音乐开关","fontSize":36,"color":"#4E302B"}},{"type":"Label","props":{"y":151,"x":550,"text":"音效开关","fontSize":36,"color":"#4E302B"}},{"type":"CheckBox","props":{"y":216,"x":224,"var":"btnMusic","skin":"res/common/public/checkbox_switch.png"}},{"type":"CheckBox","props":{"y":216,"x":542,"var":"btnEffect","skin":"res/common/public/checkbox_switch.png"}},{"type":"Label","props":{"y":346,"x":137,"text":"音乐","fontSize":36,"color":"#4E302B"}},{"type":"Label","props":{"y":426,"x":137,"text":"音效","fontSize":36,"color":"#4E302B"}},{"type":"HSlider","props":{"y":350,"x":246,"width":555,"var":"musicNum","value":100,"skin":"res/common/public/hslider.png","showLabel":false,"height":60,"sizeGrid":"24,45,23,71"}},{"type":"HSlider","props":{"y":430,"x":246,"width":555,"var":"effectNum","value":100,"skin":"res/common/public/hslider.png","showLabel":false,"height":60,"sizeGrid":"24,45,23,71"}},{"type":"Image","props":{"y":5,"x":-11,"skin":"res/common/public/shop3.png"}}]};
	return HallSetUpUI;
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