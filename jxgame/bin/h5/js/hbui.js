
(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;

	var Animation=laya.display.Animation,Box=laya.ui.Box,Button=laya.ui.Button,CheckBox=laya.ui.CheckBox;
	var Dialog=laya.ui.Dialog,FontClip=laya.ui.FontClip,HSlider=laya.ui.HSlider,Image=laya.ui.Image,Label=laya.ui.Label;
	var List=laya.ui.List,Sprite=laya.display.Sprite,View=laya.ui.View;
//class ui.hb.scene.DesktopUI extends laya.ui.View
var DesktopUI=(function(_super){
	function DesktopUI(){
		this.bets=null;
		this.rulefee=null;
		this.schedule=null;
		this.btnBack=null;
		this.btnRecharge=null;
		this.btnColumn=null;
		this.column=null;
		this.btnSetUp=null;
		this.btnRecord=null;
		this.btnHelp=null;
		DesktopUI.__super.call(this);
	}

	__class(DesktopUI,'ui.hb.scene.DesktopUI',_super);
	var __proto=DesktopUI.prototype;
	__proto.createChildren=function(){
		View.regComponent("ui.hb.ui.PewUI",PewUI);
		View.regComponent("ui.hb.ui.SievesUI",SievesUI);
		View.regComponent("ui.hb.ui.GoldUI",GoldUI);
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(DesktopUI.uiView);
	}

	DesktopUI.uiView={"type":"View","props":{"width":1280,"height":720},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/hb/desktop/Bg.png"}},{"type":"Label","props":{"y":410,"x":505,"var":"bets","fontSize":22,"color":"#457076"}},{"type":"Label","props":{"y":410,"x":659,"var":"rulefee","fontSize":22,"color":"#457076"}},{"type":"Image","props":{"y":270,"x":540,"skin":"res/hb/desktop/watermark.png"}},{"type":"Box","props":{"y":-47,"x":271,"name":"pew0"},"child":[{"type":"Pew","props":{"y":0,"x":0,"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":-47,"x":572,"name":"pew1"},"child":[{"type":"Pew","props":{"y":0,"x":0,"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":-47,"x":871,"name":"pew2"},"child":[{"type":"Pew","props":{"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":203,"x":25,"name":"pew3"},"child":[{"type":"Pew","props":{"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":203,"x":1109,"name":"pew4"},"child":[{"type":"Pew","props":{"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":487,"x":271,"name":"pew5"},"child":[{"type":"Pew","props":{"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":487,"x":572,"name":"pew7"},"child":[{"type":"Pew","props":{"y":0,"x":0,"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":487,"x":871,"name":"pew6"},"child":[{"type":"Pew","props":{"y":0,"x":0,"runtime":"ui.hb.ui.PewUI"}}]},{"type":"Box","props":{"y":175,"x":308,"name":"sieves0"},"child":[{"type":"Sieves","props":{"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":175,"x":609,"name":"sieves1"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":175,"x":908,"name":"sieves2"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":333,"x":165,"name":"sieves3"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":333,"x":1043,"name":"sieves4"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":480,"x":308,"name":"sieves5"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":480,"x":609,"name":"sieves7"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Box","props":{"y":480,"x":908,"name":"sieves6"},"child":[{"type":"Sieves","props":{"y":0,"x":0,"runtime":"ui.hb.ui.SievesUI"}}]},{"type":"Sprite","props":{"y":0,"x":0,"width":1280,"var":"schedule","stateNum":1,"skin":"res/hb/desktop/column.png","height":720}},{"type":"Box","props":{"y":12,"x":12},"child":[{"type":"Button","props":{"y":3,"var":"btnBack","stateNum":1,"skin":"res/common/public/back.png"}},{"type":"Button","props":{"y":1,"x":1110,"var":"btnRecharge","stateNum":1,"skin":"res/hb/desktop/recharge.png"}},{"type":"Button","props":{"x":1201,"var":"btnColumn","stateNum":1,"skin":"res/hb/desktop/column.png"}},{"type":"Box","props":{"y":64,"x":1123,"visible":false,"var":"column"},"child":[{"type":"Image","props":{"width":145,"skin":"res/hb/desktop/setUpBg.png","height":212,"sizeGrid":"15,13,13,17"}},{"type":"Image","props":{"y":18,"x":15,"skin":"res/common/public/setUp.png"}},{"type":"Label","props":{"y":26,"x":71,"text":"设置","fontSize":28,"color":"#FCE5A3"}},{"type":"Image","props":{"y":74,"x":10,"width":121,"skin":"res/hb/desktop/lateral.png","height":1}},{"type":"Image","props":{"y":90,"x":15,"skin":"res/hb/desktop/record.png"}},{"type":"Label","props":{"y":96,"x":71,"text":"记录","fontSize":28,"color":"#FCE5A3"}},{"type":"Image","props":{"y":144,"x":10,"width":121,"skin":"res/hb/desktop/lateral.png","height":1}},{"type":"Image","props":{"y":155,"x":15,"skin":"res/hb/desktop/help.png"}},{"type":"Label","props":{"y":165,"x":71,"text":"帮助","fontSize":28,"color":"#FCE5A3"}},{"type":"Button","props":{"y":11,"x":2,"width":142,"var":"btnSetUp","height":57}},{"type":"Button","props":{"y":81,"x":2,"width":142,"var":"btnRecord","height":57}},{"type":"Button","props":{"y":150,"x":2,"width":142,"var":"btnHelp","height":57}}]}]},{"type":"Box","props":{"y":112,"x":287,"name":"goldBox0"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":112,"x":588,"name":"goldBox1"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":112,"x":887,"name":"goldBox2"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":360,"x":41,"name":"goldBox3"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":360,"x":1125,"name":"goldBox4"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":642,"x":287,"name":"goldBox5"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":642,"x":887,"name":"goldBox6"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]},{"type":"Box","props":{"y":642,"x":588,"name":"goldBox7"},"child":[{"type":"Gold","props":{"runtime":"ui.hb.ui.GoldUI"}}]}]};
	return DesktopUI;
})(View)


//class ui.hb.scene.SelectUI extends laya.ui.View
var SelectUI=(function(_super){
	function SelectUI(){
		this.jiaose=null;
		this.roomList=null;
		this.btnBack=null;
		this.avatar=null;
		this.name=null;
		this.gold=null;
		this.shanxian=null;
		this.btnAdd=null;
		this.btnHelp=null;
		SelectUI.__super.call(this);
	}

	__class(SelectUI,'ui.hb.scene.SelectUI',_super);
	var __proto=SelectUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(SelectUI.uiView);
	}

	SelectUI.uiView={"type":"View","props":{"width":1280,"height":720},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/hb/select/Bg.png"}},{"type":"Image","props":{"y":80,"x":14,"skin":"res/hb/select/textBg.png"}},{"type":"Image","props":{"y":118,"x":24,"skin":"res/hb/select/text1.png"}},{"type":"Sprite","props":{"y":65,"x":0,"var":"jiaose","skin":"res/hb/select/text1.png"}},{"type":"List","props":{"y":54,"x":468,"width":772,"var":"roomList","height":564},"child":[{"type":"Box","props":{"y":0,"x":0,"width":189,"visible":true,"renderType":"render","height":570},"child":[{"type":"Image","props":{"skin":"res/hb/select/roomBg.png"}},{"type":"Image","props":{"y":110,"x":78,"skin":"res/hb/select/room0-1.png","name":"roomImg1"}},{"type":"Image","props":{"y":246,"x":47,"skin":"res/hb/select/room0-2.png","name":"roomImg2"}},{"type":"Label","props":{"y":309,"x":14,"width":160,"text":"底注：","overflow":"hidden","name":"bets","fontSize":20,"color":"#3D0000","align":"center"}},{"type":"Label","props":{"y":340,"x":14,"width":160,"text":"准入：","overflow":"hidden","name":"roomchipmin","fontSize":20,"color":"#3D0000","align":"center"}},{"type":"Button","props":{"y":374,"x":20,"width":149,"stateNum":1,"skin":"res/common/public/changeBor1.png","name":"btnRoom","labelSize":26,"labelPadding":"0,0,2,0","labelColors":"#511100","label":"进 入","height":50,"sizeGrid":"1,40,4,33"}},{"type":"Animation","props":{"y":374,"x":20,"width":149,"stateNum":1,"source":"res/hb/anniuguang/anniuguang0.png,res/hb/anniuguang/anniuguang1.png,res/hb/anniuguang/anniuguang2.png,res/hb/anniuguang/anniuguang3.png,res/hb/anniuguang/anniuguang4.png,res/hb/anniuguang/anniuguang5.png,res/hb/anniuguang/anniuguang6.png,res/hb/anniuguang/anniuguang7.png,res/hb/anniuguang/anniuguang8.png,res/hb/anniuguang/anniuguang9.png,res/hb/anniuguang/anniuguang10.png","skin":"res/common/public/changeBor1.png","name":"ani","mouseThrough":true,"labelSize":26,"labelPadding":"0,0,2,0","labelColors":"#511100","label":"进 入","height":50,"autoPlay":false}}]}]},{"type":"Box","props":{"y":0,"x":0},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":68,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":136,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":204,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":272,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":340,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":408,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":476,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":544,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":612,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":680,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":748,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":816,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":884,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":952,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":1020,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":1088,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":1155,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":1223,"skin":"res/common/public/head.png"}}]},{"type":"Button","props":{"y":8,"x":17,"var":"btnBack","stateNum":1,"skin":"res/hb/select/back.png"}},{"type":"Image","props":{"y":3,"x":96,"skin":"res/common/public/avatarBg.png"}},{"type":"Image","props":{"y":5,"x":98,"width":52,"var":"avatar","height":52}},{"type":"Label","props":{"y":21,"x":164,"width":181,"var":"name","text":"昵称长度八个字符","overflow":"hidden","height":22,"fontSize":22,"color":"#E4BC88"}},{"type":"Image","props":{"y":7,"x":879,"width":267,"skin":"res/common/public/radiusBg2.png","height":49,"sizeGrid":"16,18,17,12"}},{"type":"Label","props":{"y":15,"x":912,"width":203,"var":"gold","text":180002,"overflow":"hidden","fontSize":30,"color":"#E4BC88","align":"center"}},{"type":"Image","props":{"y":7,"x":856,"skin":"res/common/public/gold.png"}},{"type":"Sprite","props":{"y":7,"x":856,"var":"shanxian","skin":"res/common/public/gold.png"}},{"type":"Button","props":{"y":6,"x":1115,"var":"btnAdd","stateNum":1,"skin":"res/common/public/goldAdd.png"}},{"type":"Button","props":{"y":7,"x":1204,"var":"btnHelp","stateNum":1,"skin":"res/hb/select/help.png"}},{"type":"Image","props":{"y":64,"x":0,"width":1280,"skin":"res/common/public/head2.png","sizeGrid":"0,2,0,2"}}]};
	return SelectUI;
})(View)


//class ui.hb.ui.BetUI extends laya.ui.View
var BetUI=(function(_super){
	function BetUI(){
		this.wrap=null;
		this.moneyAni=null;
		BetUI.__super.call(this);
	}

	__class(BetUI,'ui.hb.ui.BetUI',_super);
	var __proto=BetUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(BetUI.uiView);
	}

	BetUI.uiView={"type":"View","props":{"width":1280,"height":720},"child":[{"type":"Image","props":{"y":181,"x":474,"var":"wrap","skin":"res/hb/ui/package.png"}},{"type":"Animation","props":{"y":181,"x":474,"width":331,"visible":false,"var":"moneyAni","source":"res/hb/ui/package.png,res/hb/ui/package2.png","skin":"res/hb/ui/package.png","height":358}},{"type":"Label","props":{"y":374,"x":520,"text":"所有玩家底注塞入红包","name":"roomchipmin","fontSize":24,"color":"#E0C076","align":"center"}},{"type":"Image","props":{"y":212,"x":570,"skin":"res/hb/ui/packageText.png"}}]};
	return BetUI;
})(View)


//class ui.hb.ui.GoldUI extends laya.ui.View
var GoldUI=(function(_super){
	function GoldUI(){
		this.golds=null;
		GoldUI.__super.call(this);
	}

	__class(GoldUI,'ui.hb.ui.GoldUI',_super);
	var __proto=GoldUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(GoldUI.uiView);
	}

	GoldUI.uiView={"type":"View","props":{"width":60,"height":60},"child":[{"type":"Box","props":{"y":0,"x":0,"visible":false,"var":"golds"},"child":[{"type":"Image","props":{"y":12,"x":5,"width":20,"skin":"res/common/public/gold.png","height":20}},{"type":"Image","props":{"y":14,"x":24,"width":20,"skin":"res/common/public/gold.png","height":20}},{"type":"Image","props":{"x":35,"width":20,"skin":"res/common/public/gold.png","height":20}},{"type":"Image","props":{"y":25,"x":22,"width":20,"skin":"res/common/public/gold.png","height":20}},{"type":"Image","props":{"y":36,"x":6,"width":20,"skin":"res/common/public/gold.png","height":20}}]}]};
	return GoldUI;
})(View)


//class ui.hb.ui.PewUI extends laya.ui.View
var PewUI=(function(_super){
	function PewUI(){
		this.pewBox=null;
		this.arrow=null;
		this.avatarAni=null;
		this.avatar=null;
		this.name=null;
		this.gold=null;
		this.ruleBox2=null;
		this.ruleImg2=null;
		this.ruleText2=null;
		this.daojishi=null;
		this.ruleBox1=null;
		this.ruleImg1=null;
		this.ruleText1=null;
		this.change=null;
		PewUI.__super.call(this);
	}

	__class(PewUI,'ui.hb.ui.PewUI',_super);
	var __proto=PewUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(PewUI.uiView);
	}

	PewUI.uiView={"type":"View","props":{"width":136,"height":210},"child":[{"type":"Box","props":{"y":16,"x":0,"visible":false,"var":"pewBox"},"child":[{"type":"Image","props":{"x":52,"visible":false,"var":"arrow","skin":"res/hb/desktop/arrow.png"}},{"type":"Sprite","props":{"y":61,"x":27,"visible":false,"var":"avatarAni","skin":"res/hb/desktop/avatarBg.png"}},{"type":"Image","props":{"y":61,"x":27,"skin":"res/hb/desktop/avatarBg.png"}},{"type":"Image","props":{"y":142,"skin":"res/hb/desktop/nameBg.png"}},{"type":"Image","props":{"y":64,"x":30,"width":74,"var":"avatar","height":74}},{"type":"Label","props":{"y":145,"x":2,"width":133,"var":"name","overflow":"hidden","height":18,"fontSize":18,"color":"#FFFFFF","align":"center"}},{"type":"Image","props":{"y":171,"x":16,"width":20,"skin":"res/common/public/gold.png","height":20}},{"type":"Label","props":{"y":171,"x":40,"width":96,"var":"gold","height":18,"fontSize":18,"color":"#F9C136","align":"left"}},{"type":"Box","props":{"y":36,"x":88,"visible":false,"var":"ruleBox2"},"child":[{"type":"Image","props":{"var":"ruleImg2","skin":"res/hb/ui/rule2.png"}},{"type":"Label","props":{"y":19,"x":7,"wordWrap":true,"width":20,"var":"ruleText2","text":"局主","strokeColor":"rgba(0, 0, 0, 0.6)","stroke":2,"fontSize":22,"color":"#EBD389"}}]},{"type":"Animation","props":{"y":40,"x":6,"width":120,"visible":false,"var":"daojishi","source":"res/hb/daojishi/daojishi_00.png,res/hb/daojishi/daojishi_01.png,res/hb/daojishi/daojishi_02.png,res/hb/daojishi/daojishi_03.png,res/hb/daojishi/daojishi_04.png,res/hb/daojishi/daojishi_05.png,res/hb/daojishi/daojishi_06.png,res/hb/daojishi/daojishi_07.png,res/hb/daojishi/daojishi_08.png,res/hb/daojishi/daojishi_09.png,res/hb/daojishi/daojishi_10.png,res/hb/daojishi/daojishi_11.png,res/hb/daojishi/daojishi_12.png,res/hb/daojishi/daojishi_13.png,res/hb/daojishi/daojishi_14.png,res/hb/daojishi/daojishi_15.png,res/hb/daojishi/daojishi_16.png,res/hb/daojishi/daojishi_17.png,res/hb/daojishi/daojishi_18.png,res/hb/daojishi/daojishi_19.png,res/hb/daojishi/daojishi_20.png,res/hb/daojishi/daojishi_21.png,res/hb/daojishi/daojishi_22.png,res/hb/daojishi/daojishi_23.png,res/hb/daojishi/daojishi_24.png,res/hb/daojishi/daojishi_25.png,res/hb/daojishi/daojishi_26.png,res/hb/daojishi/daojishi_27.png,res/hb/daojishi/daojishi_28.png,res/hb/daojishi/daojishi_29.png","skin":"res/hb/daojishi/daojishi_00.png","height":120}},{"type":"Box","props":{"y":36,"x":88,"visible":false,"var":"ruleBox1"},"child":[{"type":"Image","props":{"var":"ruleImg1","skin":"res/hb/ui/rule1.png"}},{"type":"Label","props":{"y":19,"x":7,"wordWrap":true,"width":20,"var":"ruleText1","text":"竞规","strokeColor":"rgba(0, 0, 0, 0.6)","stroke":2,"fontSize":22,"color":"#EBD389"}}]}]},{"type":"Label","props":{"y":86,"x":0,"width":136,"visible":false,"var":"change","text":"100","strokeColor":"rgba(0, 0, 0, 0.6)","stroke":4,"fontSize":30,"color":"#F9C136","bold":true,"align":"center"}}]};
	return PewUI;
})(View)


//class ui.hb.ui.SievesUI extends laya.ui.View
var SievesUI=(function(_super){
	function SievesUI(){
		this.sievesImg=null;
		this.saizi=null;
		SievesUI.__super.call(this);
	}

	__class(SievesUI,'ui.hb.ui.SievesUI',_super);
	var __proto=SievesUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(SievesUI.uiView);
	}

	SievesUI.uiView={"type":"View","props":{"width":62,"height":72},"child":[{"type":"Image","props":{"y":0,"x":0,"visible":false,"var":"sievesImg","skin":"res/hb/ui/sieves1.png"}},{"type":"Sprite","props":{"y":0,"x":0,"width":62,"var":"saizi","skin":"res/hb/ui/sieves1.png","height":72}}]};
	return SievesUI;
})(View)


//class ui.hb.ui.StartUI extends laya.ui.View
var StartUI$1=(function(_super){
	function StartUI(){
		StartUI.__super.call(this);;
	}

	__class(StartUI,'ui.hb.ui.StartUI',_super,'StartUI$1');
	var __proto=StartUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(StartUI.uiView);
	}

	StartUI.uiView={"type":"View","props":{"width":1280,"height":720}};
	return StartUI;
})(View)


//class ui.hb.popup.HbSetUpUI extends laya.ui.Dialog
var HbSetUpUI=(function(_super){
	function HbSetUpUI(){
		this.btnMusic=null;
		this.btnEffect=null;
		this.musicNum=null;
		this.effectNum=null;
		HbSetUpUI.__super.call(this);
	}

	__class(HbSetUpUI,'ui.hb.popup.HbSetUpUI',_super);
	var __proto=HbSetUpUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(HbSetUpUI.uiView);
	}

	HbSetUpUI.uiView={"type":"Dialog","props":{"width":1016,"height":608},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg3.png"}},{"type":"Image","props":{"y":28,"x":375,"skin":"res/common/public/title.png"}},{"type":"Image","props":{"y":37,"x":464,"skin":"res/common/public/setUp0.png"}},{"type":"Image","props":{"y":94,"x":56,"width":890,"skin":"res/common/public/radiusBor1.png","height":480,"sizeGrid":"10,10,10,10"}},{"type":"Button","props":{"y":3,"x":939,"stateNum":1,"skin":"res/common/public/close.png","name":"close"}},{"type":"Label","props":{"y":151,"x":234,"text":"音乐开关","fontSize":36,"color":"#4E302B"}},{"type":"Label","props":{"y":151,"x":550,"text":"音效开关","fontSize":36,"color":"#4E302B"}},{"type":"CheckBox","props":{"y":216,"x":224,"var":"btnMusic","skin":"res/common/public/checkbox_switch.png"}},{"type":"CheckBox","props":{"y":216,"x":542,"var":"btnEffect","skin":"res/common/public/checkbox_switch.png"}},{"type":"Label","props":{"y":346,"x":137,"text":"音乐","fontSize":36,"color":"#4E302B"}},{"type":"Label","props":{"y":426,"x":137,"text":"音效","fontSize":36,"color":"#4E302B"}},{"type":"HSlider","props":{"y":350,"x":246,"width":555,"var":"musicNum","value":100,"skin":"res/common/public/hslider.png","showLabel":false,"height":60,"sizeGrid":"24,45,23,71"}},{"type":"HSlider","props":{"y":430,"x":246,"width":555,"var":"effectNum","value":100,"skin":"res/common/public/hslider.png","showLabel":false,"height":60,"sizeGrid":"24,45,23,71"}},{"type":"Image","props":{"y":5,"x":-11,"skin":"res/common/public/shop3.png"}}]};
	return HbSetUpUI;
})(Dialog)


//class ui.hb.popup.HelpUI extends laya.ui.Dialog
var HelpUI=(function(_super){
	function HelpUI(){
		this.btnClose=null;
		HelpUI.__super.call(this);
	}

	__class(HelpUI,'ui.hb.popup.HelpUI',_super);
	var __proto=HelpUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(HelpUI.uiView);
	}

	HelpUI.uiView={"type":"Dialog","props":{"width":1016,"height":608},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg3.png"}},{"type":"Image","props":{"y":28,"x":375,"skin":"res/common/public/title.png"}},{"type":"Image","props":{"y":33,"x":464,"skin":"res/hb/popup/help0.png"}},{"type":"Image","props":{"y":94,"x":56,"width":890,"skin":"res/common/public/radiusBor1.png","height":480,"sizeGrid":"10,10,10,10"}},{"type":"Image","props":{"y":5,"x":-11,"skin":"res/common/public/shop3.png"}},{"type":"Button","props":{"y":3,"x":939,"var":"btnClose","stateNum":1,"skin":"res/common/public/close.png"}},{"type":"Label","props":{"y":102,"x":66,"text":"【玩法介绍】","fontSize":24,"color":"#4E302B"}},{"type":"Label","props":{"y":135,"x":112,"text":"准备阶段：","leading":5,"fontSize":24,"color":"#87361D"}},{"type":"Label","props":{"y":135,"x":226,"wordWrap":true,"width":700,"text":"游戏开始后，所有玩家需要享红包内塞入金币（房间底注），房间不同需要塞入的金额也不同。","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":197,"x":112,"text":"定规阶段：","leading":5,"fontSize":24,"color":"#87361D"}},{"type":"Label","props":{"y":197,"x":226,"wordWrap":true,"width":700,"text":"所有人塞完金币后，玩家开始选择是否竞选本局的规则制定者，参与竞选需要支付一定数额竞选费，房间不同竞选费不同。注：竞选费归系统所有，不参与红包金额派发。","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":288,"x":88,"text":"选出定规者：","leading":5,"fontSize":24,"color":"#87361D"}},{"type":"Label","props":{"y":288,"x":226,"wordWrap":true,"width":700,"text":"所有人塞完金币后，玩家开始选择是否竞选本局的规则制定者，参与竞选需要支付一定数额竞选费，房间不同竞选费不同。注：竞选费归系统所有，不参与红包金额派发。","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":379,"x":112,"text":"选定规则：","leading":5,"fontSize":24,"color":"#87361D"}},{"type":"Label","props":{"y":379,"x":226,"wordWrap":true,"width":700,"text":"规则制定者可以在以下四种规则中选择一种，作为本局游戏规则。","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":419,"x":66,"text":"【规则介绍】","fontSize":24,"color":"#4E302B"}},{"type":"Label","props":{"y":452,"x":112,"text":"◆ 投掷点数最小的玩家，获得红包全部金额","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":482,"x":112,"text":"◆ 投掷点数最大的玩家，获得红包全部金额","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":511,"x":112,"text":"◆ 所有投掷点数为小的玩家，每个人开启后获取金额随机","leading":5,"fontSize":24,"color":"#8D6343"}},{"type":"Label","props":{"y":541,"x":112,"text":"◆ 所有投掷点数为大的玩家，每个人开启后获取金额随机","leading":5,"fontSize":24,"color":"#8D6343"}}]};
	return HelpUI;
})(Dialog)


//class ui.hb.popup.MatchingUI extends laya.ui.Dialog
var MatchingUI=(function(_super){
	function MatchingUI(){
		MatchingUI.__super.call(this);;
	}

	__class(MatchingUI,'ui.hb.popup.MatchingUI',_super);
	var __proto=MatchingUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(MatchingUI.uiView);
	}

	MatchingUI.uiView={"type":"Dialog","props":{"width":380,"height":100}};
	return MatchingUI;
})(Dialog)


//class ui.hb.popup.RecordUI extends laya.ui.Dialog
var RecordUI=(function(_super){
	function RecordUI(){
		this.btnClose=null;
		this.recordList=null;
		RecordUI.__super.call(this);
	}

	__class(RecordUI,'ui.hb.popup.RecordUI',_super);
	var __proto=RecordUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(RecordUI.uiView);
	}

	RecordUI.uiView={"type":"Dialog","props":{"width":1016,"height":608},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg3.png"}},{"type":"Image","props":{"y":28,"x":375,"skin":"res/common/public/title.png"}},{"type":"Image","props":{"y":94,"x":56,"width":890,"skin":"res/common/public/radiusBor1.png","height":420,"sizeGrid":"10,10,10,10"}},{"type":"Image","props":{"y":34,"x":461,"skin":"res/hb/popup/record0.png"}},{"type":"Button","props":{"y":3,"x":939,"var":"btnClose","stateNum":1,"skin":"res/common/public/close.png"}},{"type":"Image","props":{"y":5,"x":-11,"skin":"res/common/public/shop3.png"}},{"type":"Image","props":{"y":98,"x":61,"width":880,"skin":"res/hb/popup/tabBg.png","height":63,"sizeGrid":"30,30,30,30"}},{"type":"Label","props":{"y":119,"x":92,"text":"序号","fontSize":24,"color":"#4E302B"}},{"type":"Image","props":{"y":109,"x":159,"skin":"res/hb/popup/division.png"}},{"type":"Label","props":{"y":119,"x":176,"text":"点数","fontSize":24,"color":"#4E302B"}},{"type":"Image","props":{"y":109,"x":241,"skin":"res/hb/popup/division.png"}},{"type":"Label","props":{"y":119,"x":622,"text":"规则","fontSize":24,"color":"#4E302B"}},{"type":"Label","props":{"y":119,"x":272,"text":"盈利","fontSize":24,"color":"#4E302B"}},{"type":"Image","props":{"y":109,"x":352,"skin":"res/hb/popup/division.png"}},{"type":"List","props":{"y":169,"x":75,"width":861,"var":"recordList","spaceY":10,"height":318},"child":[{"type":"Box","props":{"renderType":"render"},"child":[{"type":"Label","props":{"width":76,"text":"99999","name":"index","height":24,"fontSize":24,"color":"#87361D","align":"center"}},{"type":"Label","props":{"x":98,"width":48,"text":"10","name":"number","height":24,"fontSize":24,"color":"#87361D","align":"center"}},{"type":"Label","props":{"x":172,"width":99,"text":"8000","name":"profit","height":24,"fontSize":24,"color":"#87361D","align":"center"}},{"type":"Label","props":{"x":284,"width":577,"text":"所有投掷点数为大的玩家，每个人开启后获取金额随机","name":"rule","height":24,"fontSize":24,"color":"#87361D","align":"center"}}]}]}]};
	return RecordUI;
})(Dialog)


//class ui.hb.popup.RestUI extends laya.ui.Dialog
var RestUI=(function(_super){
	function RestUI(){
		this.timerNum=null;
		RestUI.__super.call(this);
	}

	__class(RestUI,'ui.hb.popup.RestUI',_super);
	var __proto=RestUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(RestUI.uiView);
	}

	RestUI.uiView={"type":"Dialog","props":{"width":150,"height":150},"child":[{"type":"Image","props":{"y":0,"x":14,"skin":"res/hb/ui/rest1.png"}},{"type":"Image","props":{"y":115,"x":13,"skin":"res/hb/ui/rest2.png"}},{"type":"FontClip","props":{"y":39,"x":38,"var":"timerNum","value":"09","skin":"res/hb/ui/FontClip.png","sheet":"0123456789"}}]};
	return RestUI;
})(Dialog)


//class ui.hb.popup.RuleAgreeUI extends laya.ui.Dialog
var RuleAgreeUI=(function(_super){
	function RuleAgreeUI(){
		this.rulefee=null;
		this.timeNum=null;
		this.btnJoin=null;
		this.btnCanJoin=null;
		RuleAgreeUI.__super.call(this);
	}

	__class(RuleAgreeUI,'ui.hb.popup.RuleAgreeUI',_super);
	var __proto=RuleAgreeUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(RuleAgreeUI.uiView);
	}

	RuleAgreeUI.uiView={"type":"Dialog","props":{"width":574,"height":220},"child":[{"type":"Image","props":{"y":18,"x":4,"width":566,"skin":"res/hb/ui/ruleBg1.png","height":116,"sizeGrid":"40,40,40,40"}},{"type":"Label","props":{"y":44,"x":123,"text":"是否选择参与该局规则制定？","overflow":"hidden","fontSize":26,"color":"#76362C"}},{"type":"Label","props":{"y":78,"x":123,"var":"rulefee","text":"参与竞选需要支付1金币...","overflow":"hidden","fontSize":26,"color":"#76362C"}},{"type":"Label","props":{"y":78,"x":430,"text":"(    )","overflow":"hidden","fontSize":26,"color":"#FF3700"}},{"type":"Label","props":{"y":81,"x":438,"width":32,"var":"timeNum","overflow":"hidden","height":26,"fontSize":26,"color":"#FF3700","align":"center"}},{"type":"Button","props":{"y":155,"x":325,"width":192,"var":"btnJoin","stateNum":1,"skin":"res/common/public/changeBor1.png","labelSize":30,"labelColors":"#511100","label":"参 与","height":65,"sizeGrid":"1,40,4,33"}},{"type":"Button","props":{"y":154,"x":56,"width":192,"var":"btnCanJoin","stateNum":1,"skin":"res/common/public/changeBor2.png","labelSize":30,"labelColors":"#083344","label":"不参与","height":65,"sizeGrid":"18,65,16,40"}},{"type":"Image","props":{"y":0,"x":0,"width":24,"skin":"res/hb/ui/reel1.png","height":152,"sizeGrid":"25,8,31,4"}},{"type":"Image","props":{"y":0,"x":550,"width":24,"skin":"res/hb/ui/reel2.png","height":150,"sizeGrid":"25,8,31,4"}}]};
	return RuleAgreeUI;
})(Dialog)


//class ui.hb.popup.RuleConfirmUI extends laya.ui.Dialog
var RuleConfirmUI=(function(_super){
	function RuleConfirmUI(){
		this.ruleText=null;
		this.timeNum=null;
		this.btnBetting=null;
		RuleConfirmUI.__super.call(this);
	}

	__class(RuleConfirmUI,'ui.hb.popup.RuleConfirmUI',_super);
	var __proto=RuleConfirmUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(RuleConfirmUI.uiView);
	}

	RuleConfirmUI.uiView={"type":"Dialog","props":{"width":741,"height":360},"child":[{"type":"Image","props":{"y":65,"x":16,"width":710,"skin":"res/hb/ui/ruleBg2.png","height":222,"sizeGrid":"20,20,20,20"}},{"type":"Image","props":{"y":124,"x":30,"width":680,"skin":"res/hb/ui/radiusBg.png","height":79,"sizeGrid":"18,18,18,18"}},{"type":"Label","props":{"y":81,"x":317,"text":"本局规则","fontSize":26,"color":"#76362C","bold":true}},{"type":"Label","props":{"y":151,"x":31,"width":679,"var":"ruleText","height":28,"fontSize":28,"color":"#FFFC00","align":"center"}},{"type":"Label","props":{"y":220,"x":203,"text":"请各位玩家投掷筛子...","fontSize":26,"color":"#76362C"}},{"type":"Label","props":{"y":217,"x":468,"text":"(    )","fontSize":26,"color":"#FF3700"}},{"type":"Label","props":{"y":219,"x":473,"width":35,"var":"timeNum","height":26,"fontSize":26,"color":"#FF3700","align":"center"}},{"type":"Button","props":{"y":295,"x":274,"width":192,"var":"btnBetting","stateNum":1,"skin":"res/common/public/changeBor1.png","labelSize":30,"labelColors":"#511100","label":"投 掷","height":65,"sizeGrid":"1,40,4,33"}},{"type":"Image","props":{"y":46,"x":0,"width":24,"skin":"res/hb/ui/reel1.png","height":259,"sizeGrid":"25,8,31,4"}},{"type":"Image","props":{"y":46,"x":717,"width":24,"skin":"res/hb/ui/reel2.png","height":259,"sizeGrid":"25,8,31,4"}}]};
	return RuleConfirmUI;
})(Dialog)


//class ui.hb.popup.RuleSelectUI extends laya.ui.Dialog
var RuleSelectUI=(function(_super){
	function RuleSelectUI(){
		this.timeNum=null;
		this.ruleSelectList=null;
		RuleSelectUI.__super.call(this);
	}

	__class(RuleSelectUI,'ui.hb.popup.RuleSelectUI',_super);
	var __proto=RuleSelectUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(RuleSelectUI.uiView);
	}

	RuleSelectUI.uiView={"type":"Dialog","props":{"width":640,"height":331},"child":[{"type":"Image","props":{"y":18,"x":15,"width":610,"skin":"res/hb/ui/ruleBg2.png","height":295,"sizeGrid":"20,20,20,20"}},{"type":"Image","props":{"y":73,"x":28,"width":584,"skin":"res/hb/ui/radiusBg.png","height":219,"sizeGrid":"18,18,18,18"}},{"type":"Label","props":{"y":34,"x":180,"text":"请选择本局游戏规则...","fontSize":26,"color":"#76362C"}},{"type":"Label","props":{"y":32,"x":434,"text":"(    )","fontSize":26,"color":"#FF3700"}},{"type":"Label","props":{"y":35,"x":442,"width":30,"var":"timeNum","height":26,"fontSize":26,"color":"#FF3700","align":"center"}},{"type":"List","props":{"y":83,"x":45,"width":555,"var":"ruleSelectList","spaceY":4,"height":202},"child":[{"type":"Box","props":{"renderType":"render"},"child":[{"type":"Image","props":{"width":555,"stateNum":1,"skin":"res/common/public/changeBor1.png","name":"btnRoom","labelSize":22,"labelColors":"#333333","labelBold":true,"label":"进 入","height":47,"sizeGrid":"1,40,4,33"}},{"type":"Label","props":{"y":10,"x":0,"width":555,"text":"投掷点数最小的玩家，获得红包全部金额","name":"explain","fontSize":22,"color":"#511100","align":"center"}}]}]},{"type":"Image","props":{"y":0,"x":0,"width":24,"skin":"res/hb/ui/reel1.png","height":331,"sizeGrid":"25,8,31,4"}},{"type":"Image","props":{"y":0,"x":617,"width":24,"skin":"res/hb/ui/reel2.png","height":331,"sizeGrid":"25,8,31,4"}}]};
	return RuleSelectUI;
})(Dialog)


//class ui.hb.popup.SlugMoneyUI extends laya.ui.Dialog
var SlugMoneyUI=(function(_super){
	function SlugMoneyUI(){
		this.noOpen=null;
		this.open=null;
		this.btnOpen=null;
		this.openNum=null;
		SlugMoneyUI.__super.call(this);
	}

	__class(SlugMoneyUI,'ui.hb.popup.SlugMoneyUI',_super);
	var __proto=SlugMoneyUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(SlugMoneyUI.uiView);
	}

	SlugMoneyUI.uiView={"type":"Dialog","props":{"width":721,"height":506},"child":[{"type":"Box","props":{"y":0,"x":0,"var":"noOpen"},"child":[{"type":"Image","props":{"y":74,"x":195,"skin":"res/hb/ui/colse2.png"}},{"type":"Image","props":{"y":126,"x":288,"stateNum":1,"skin":"res/hb/ui/colse.png"}},{"type":"Label","props":{"y":318,"x":226,"text":"您在本局不满足获奖条件 ","overflow":"hidden","fontSize":24,"color":"#A4A4A4"}},{"type":"Label","props":{"y":351,"x":293,"text":"不可开启红包","overflow":"hidden","fontSize":24,"color":"#A4A4A4"}},{"type":"Image","props":{"y":0,"x":0,"visible":true,"skin":"res/hb/ui/close1.png"}}]},{"type":"Box","props":{"y":18,"x":0,"var":"open"},"child":[{"type":"Image","props":{"y":56,"x":195,"skin":"res/hb/ui/package.png"}},{"type":"Button","props":{"y":108,"x":288,"var":"btnOpen","stateNum":1,"skin":"res/hb/ui/open.png"}},{"type":"Label","props":{"y":333,"x":457,"width":30,"var":"openNum","overflow":"hidden","height":24,"fontSize":24,"color":"#00FF2A","align":"center"}},{"type":"Image","props":{"skin":"res/hb/ui/open1.png"}},{"type":"Image","props":{"y":53,"x":109,"skin":"res/hb/ui/open2.png"}},{"type":"Label","props":{"y":297,"x":237,"visible":false,"text":"您在本局满足获奖条件 ","overflow":"hidden","fontSize":24,"color":"#E0C076"}},{"type":"Label","props":{"y":333,"x":228,"visible":false,"text":"请点击按钮开启红包","overflow":"hidden","fontSize":24,"color":"#E0C076"}},{"type":"Label","props":{"y":332,"x":450,"visible":false,"text":"(    )","overflow":"hidden","fontSize":24,"color":"#00FF2A"}}]}]};
	return SlugMoneyUI;
})(Dialog)


//class ui.hb.popup.StartUI extends laya.ui.Dialog
var StartUI=(function(_super){
	function StartUI(){
		StartUI.__super.call(this);;
	}

	__class(StartUI,'ui.hb.popup.StartUI',_super);
	var __proto=StartUI.prototype;
	__proto.createChildren=function(){
		laya.ui.Component.prototype.createChildren.call(this);
		this.createView(StartUI.uiView);
	}

	StartUI.uiView={"type":"Dialog","props":{"width":640,"mouseThrough":false,"height":360}};
	return StartUI;
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