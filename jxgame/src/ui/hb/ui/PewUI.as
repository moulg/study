/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class PewUI extends View {
		public var pewBox:Box;
		public var arrow:Image;
		public var avatarAni:Sprite;
		public var avatar:Image;
		public var name:Label;
		public var gold:Label;
		public var ruleBox2:Box;
		public var ruleImg2:Image;
		public var ruleText2:Label;
		public var daojishi:Animation;
		public var ruleBox1:Box;
		public var ruleImg1:Image;
		public var ruleText1:Label;
		public var change:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":136,"height":210},"child":[{"type":"Box","props":{"y":16,"x":0,"visible":false,"var":"pewBox"},"child":[{"type":"Image","props":{"x":52,"visible":false,"var":"arrow","skin":"res/hb/desktop/arrow.png"}},{"type":"Sprite","props":{"y":61,"x":27,"visible":false,"var":"avatarAni","skin":"res/hb/desktop/avatarBg.png"}},{"type":"Image","props":{"y":61,"x":27,"skin":"res/hb/desktop/avatarBg.png"}},{"type":"Image","props":{"y":142,"skin":"res/hb/desktop/nameBg.png"}},{"type":"Image","props":{"y":64,"x":30,"width":74,"var":"avatar","height":74}},{"type":"Label","props":{"y":145,"x":2,"width":133,"var":"name","overflow":"hidden","height":18,"fontSize":18,"color":"#FFFFFF","align":"center"}},{"type":"Image","props":{"y":171,"x":16,"width":20,"skin":"res/common/public/gold.png","height":20}},{"type":"Label","props":{"y":171,"x":40,"width":96,"var":"gold","height":18,"fontSize":18,"color":"#F9C136","align":"left"}},{"type":"Box","props":{"y":36,"x":88,"visible":false,"var":"ruleBox2"},"child":[{"type":"Image","props":{"var":"ruleImg2","skin":"res/hb/ui/rule2.png"}},{"type":"Label","props":{"y":19,"x":7,"wordWrap":true,"width":20,"var":"ruleText2","text":"局主","strokeColor":"rgba(0, 0, 0, 0.6)","stroke":2,"fontSize":22,"color":"#EBD389"}}]},{"type":"Animation","props":{"y":40,"x":6,"width":120,"visible":false,"var":"daojishi","source":"res/hb/daojishi/daojishi_00.png,res/hb/daojishi/daojishi_01.png,res/hb/daojishi/daojishi_02.png,res/hb/daojishi/daojishi_03.png,res/hb/daojishi/daojishi_04.png,res/hb/daojishi/daojishi_05.png,res/hb/daojishi/daojishi_06.png,res/hb/daojishi/daojishi_07.png,res/hb/daojishi/daojishi_08.png,res/hb/daojishi/daojishi_09.png,res/hb/daojishi/daojishi_10.png,res/hb/daojishi/daojishi_11.png,res/hb/daojishi/daojishi_12.png,res/hb/daojishi/daojishi_13.png,res/hb/daojishi/daojishi_14.png,res/hb/daojishi/daojishi_15.png,res/hb/daojishi/daojishi_16.png,res/hb/daojishi/daojishi_17.png,res/hb/daojishi/daojishi_18.png,res/hb/daojishi/daojishi_19.png,res/hb/daojishi/daojishi_20.png,res/hb/daojishi/daojishi_21.png,res/hb/daojishi/daojishi_22.png,res/hb/daojishi/daojishi_23.png,res/hb/daojishi/daojishi_24.png,res/hb/daojishi/daojishi_25.png,res/hb/daojishi/daojishi_26.png,res/hb/daojishi/daojishi_27.png,res/hb/daojishi/daojishi_28.png,res/hb/daojishi/daojishi_29.png","skin":"res/hb/daojishi/daojishi_00.png","height":120}},{"type":"Box","props":{"y":36,"x":88,"visible":false,"var":"ruleBox1"},"child":[{"type":"Image","props":{"var":"ruleImg1","skin":"res/hb/ui/rule1.png"}},{"type":"Label","props":{"y":19,"x":7,"wordWrap":true,"width":20,"var":"ruleText1","text":"竞规","strokeColor":"rgba(0, 0, 0, 0.6)","stroke":2,"fontSize":22,"color":"#EBD389"}}]}]},{"type":"Label","props":{"y":86,"x":0,"width":136,"visible":false,"var":"change","text":"100","strokeColor":"rgba(0, 0, 0, 0.6)","stroke":4,"fontSize":30,"color":"#F9C136","bold":true,"align":"center"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}