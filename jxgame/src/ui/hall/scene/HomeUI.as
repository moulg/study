/**Created by the LayaAirIDE,do not modify.*/
package ui.hall.scene {
	import laya.ui.*;
	import laya.display.*; 

	public class HomeUI extends View {
		public var gameList:List;
		public var jinxiujiaose:Sprite;
		public var btnBack:Button;
		public var avatar:Image;
		public var name:Label;
		public var gold:Label;
		public var shanxian:Sprite;
		public var btnAdd:Button;
		public var btnSetUp:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1280,"height":720},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/hall/home/bg.png"}},{"type":"List","props":{"y":215,"x":323,"width":958,"var":"gameList","height":298},"child":[{"type":"Box","props":{"y":0,"x":0,"width":301,"renderType":"render","height":298},"child":[{"type":"Image","props":{"y":24,"x":37,"width":264,"name":"logo","height":274}},{"type":"Image","props":{"x":241,"width":25,"name":"hotSign","height":25}},{"type":"Image","props":{"y":17,"x":225,"skin":"res/hall/home/yun.png"}},{"type":"Animation","props":{"y":-69,"x":-91,"width":512,"source":"res/hall/xingdian/xingdian_0.png,res/hall/xingdian/xingdian_1.png,res/hall/xingdian/xingdian_10.png,res/hall/xingdian/xingdian_11.png,res/hall/xingdian/xingdian_12.png,res/hall/xingdian/xingdian_13.png,res/hall/xingdian/xingdian_14.png,res/hall/xingdian/xingdian_2.png,res/hall/xingdian/xingdian_3.png,res/hall/xingdian/xingdian_4.png,res/hall/xingdian/xingdian_5.png,res/hall/xingdian/xingdian_6.png,res/hall/xingdian/xingdian_7.png,res/hall/xingdian/xingdian_8.png,res/hall/xingdian/xingdian_9.png","skin":"res/hall/xingdian/xingdian_0.png","interval":150,"height":400,"autoPlay":true}}]}]},{"type":"Image","props":{"y":0,"x":0,"skin":"res/hall/home/cover.png"}},{"type":"Sprite","props":{"y":65,"x":0,"var":"jinxiujiaose","skin":"res/hb/select/text1.png"}},{"type":"Box","props":{"y":0,"x":0},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":68,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":136,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":204,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":272,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":340,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":408,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":476,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":544,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":612,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":680,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":748,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":816,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":884,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":952,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":1020,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":1088,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":1155,"skin":"res/common/public/head.png"}},{"type":"Image","props":{"y":0,"x":1223,"skin":"res/common/public/head.png"}}]},{"type":"Button","props":{"y":8,"x":17,"var":"btnBack","stateNum":1,"skin":"res/common/public/back.png"}},{"type":"Image","props":{"y":3,"x":96,"skin":"res/common/public/avatarBg.png"}},{"type":"Image","props":{"y":5,"x":98,"width":52,"var":"avatar","stateNum":1,"height":52}},{"type":"Label","props":{"y":21,"x":164,"width":181,"var":"name","text":"昵称长度八个字符","overflow":"hidden","height":22,"fontSize":22,"color":"#E4BC88"}},{"type":"Image","props":{"y":7,"x":879,"width":267,"skin":"res/common/public/radiusBg2.png","height":49,"sizeGrid":"16,18,17,12"}},{"type":"Label","props":{"y":15,"x":912,"width":203,"var":"gold","text":180002,"overflow":"hidden","fontSize":30,"color":"#E4BC88","align":"center"}},{"type":"Image","props":{"y":7,"x":856,"skin":"res/common/public/gold.png"}},{"type":"Sprite","props":{"y":7,"x":856,"var":"shanxian","skin":"res/common/public/gold.png"}},{"type":"Button","props":{"y":6,"x":1115,"var":"btnAdd","stateNum":1,"skin":"res/common/public/goldAdd.png"}},{"type":"Button","props":{"y":7,"x":1204,"var":"btnSetUp","stateNum":1,"skin":"res/common/public/setUp.png"}},{"type":"Image","props":{"y":64,"x":0,"width":1280,"skin":"res/common/public/head2.png","sizeGrid":"0,2,0,2"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}