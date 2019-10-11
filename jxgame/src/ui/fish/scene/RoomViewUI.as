/**Created by the LayaAirIDE,do not modify.*/
package ui.fish.scene {
	import laya.ui.*;
	import laya.display.*; 

	public class RoomViewUI extends View {
		public var back:Image;
		public var userHead:Image;
		public var roomList:List;
		public var userName:Label;
		public var userScore:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1920,"height":1080},"child":[{"type":"Image","props":{"y":540,"x":960,"skin":"res/fish/room/bj.png","anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":30,"x":31,"var":"back","skin":"res/fish/room/close.png"}},{"type":"Image","props":{"y":38.5,"x":1551,"skin":"res/fish/room/goldframe.png"}},{"type":"Image","props":{"y":50,"x":260,"skin":"res/fish/room/goldframe.png"}},{"type":"Image","props":{"y":38,"x":1551,"skin":"res/fish/room/gold.png"}},{"type":"Image","props":{"y":84,"x":262,"skin":"res/fish/room/headframe.png","anchorY":0.5,"anchorX":0.5},"child":[{"type":"Image","props":{"y":52,"x":52,"var":"userHead","anchorY":0.5,"anchorX":0.5}}]},{"type":"Image","props":{"y":84,"x":262,"skin":"res/fish/room/headframe1.png","anchorY":0.5,"anchorX":0.5}},{"type":"List","props":{"y":623,"x":991,"width":1740,"var":"roomList","spaceY":1000,"spaceX":-30,"height":800,"anchorY":0.5,"anchorX":0.5},"child":[{"type":"Box","props":{"y":409,"x":300,"width":600,"renderType":"render","height":631,"anchorY":0.5,"anchorX":0.5},"child":[{"type":"Image","props":{"y":578,"x":250,"skin":"res/fish/room/icon1.png","name":"icon","anchorY":1,"anchorX":0.5}},{"type":"Image","props":{"y":421,"x":265,"skin":"res/fish/room/num1.png","name":"num","anchorY":1,"anchorX":0.5}},{"type":"Label","props":{"y":484,"x":267,"text":"准入: 10","strokeColor":"#1c5914","stroke":5,"name":"min","fontSize":30,"font":"Microsoft YaHei","color":"#ffffff","anchorY":0.5,"anchorX":0.5,"align":"center"}}]}]},{"type":"Label","props":{"y":80,"x":321,"var":"userName","text":"XXXXXX","strokeColor":"#021b0c","fontSize":30,"font":"Microsoft YaHei","color":"#ffffff","anchorY":0.5,"anchorX":0,"align":"left"}},{"type":"Label","props":{"y":69,"x":1628,"var":"userScore","text":"8888888888","strokeColor":"#021b0c","fontSize":30,"font":"Microsoft YaHei","color":"#ffffff","anchorY":0.5,"anchorX":0,"align":"center"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}