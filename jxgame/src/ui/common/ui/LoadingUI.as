/**Created by the LayaAirIDE,do not modify.*/
package ui.common.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class LoadingUI extends View {
		public var bg:Sprite;
		public var ani:Animation;
		public var text:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1280,"mouseEnabled":true,"height":720},"child":[{"type":"Sprite","props":{"y":0,"x":0,"width":1280,"var":"bg","height":720,"alpha":0},"child":[{"type":"Rect","props":{"y":0,"x":0,"width":1280,"lineWidth":0,"height":720,"fillColor":"#000000"}}]},{"type":"Image","props":{"y":289,"x":291,"width":650,"skin":"res/common/ui/toast.png","sizeGrid":"10,250,10,250","height":140}},{"type":"Animation","props":{"y":308,"x":592,"width":48,"var":"ani","source":"res/common/ui/loading_01.png,res/common/ui/loading_02.png,res/common/ui/loading_03.png,res/common/ui/loading_04.png,res/common/ui/loading_05.png,res/common/ui/loading_06.png,res/common/ui/loading_07.png,res/common/ui/loading_08.png,res/common/ui/loading_09.png,res/common/ui/loading_10.png,res/common/ui/loading_11.png,res/common/ui/loading_12.png","interval":60,"height":48,"autoPlay":true}},{"type":"Label","props":{"y":374,"x":341,"width":550,"var":"text","height":33,"fontSize":24,"font":"Microsoft YaHei","color":"#eaeaea","align":"center"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}