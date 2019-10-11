/**Created by the LayaAirIDE,do not modify.*/
package ui.fish.scene {
	import laya.ui.*;
	import laya.display.*; 

	public class FishSceneUI extends View {
		public var gamebg:Image;
		public var fishPanel:Box;
		public var bulletPanel:Button;
		public var batteryPanel:Image;
		public var propPanel:Image;
		public var waterPanel:Image;
		public var btnpanel:Box;
		public var closeBtn:Image;
		public var autoFire:Button;
		public var autoLock:Button;
		public var btnsbg:Image;
		public var gamehelp:Button;
		public var gameexit:Button;
		public var gameset:Button;
		public var btnVisible1:Button;
		public var btnVisible2:Button;
		public var btnshop:Button;
		public var iceProp:Image;
		public var iceEffect:Sprite;
		public var iceTimer:Label;
		public var flashProp:Image;
		public var flashEffect:Sprite;
		public var flashTimer:Label;
		public var fireProp:Image;
		public var fireEffect:Sprite;
		public var fireTimer:Label;
		public var mengban:Sprite;
		public var mengbanbg:Image;
		public var bulNum:Label;
		public var fishNum:Label;
		public var coNum:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1920,"height":1080},"child":[{"type":"Image","props":{"y":540,"x":960,"width":1920,"var":"gamebg","skin":"res/fish/image/bg1.jpg","height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Box","props":{"y":540,"x":960,"width":1920,"var":"fishPanel","height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Button","props":{"y":540,"x":960,"width":1920,"var":"bulletPanel","height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":540,"x":960,"width":1920,"var":"batteryPanel","mouseThrough":true,"height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":540,"x":960,"width":1920,"var":"propPanel","mouseThrough":true,"height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":540,"x":960,"width":1920,"var":"waterPanel","mouseThrough":true,"height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Box","props":{"y":540,"x":960,"width":1920,"var":"btnpanel","mouseThrough":true,"height":1080,"anchorY":0.5,"anchorX":0.5},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1920,"var":"closeBtn","height":1080}},{"type":"Button","props":{"y":942,"x":823,"var":"autoFire","stateNum":1,"skin":"res/fish/textures/zidongfashe.png"}},{"type":"Button","props":{"y":944,"x":976,"var":"autoLock","stateNum":1,"skin":"res/fish/textures/zidongsuoding.png"}},{"type":"Image","props":{"y":11,"x":1755,"var":"btnsbg","skin":"res/fish/textures/btnvisiblebg.png","scaleY":1},"child":[{"type":"Button","props":{"y":393,"x":12,"var":"gamehelp","stateNum":1,"skin":"res/fish/textures/btnHelp.png"}},{"type":"Button","props":{"y":131,"x":12,"var":"gameexit","stateNum":1,"skin":"res/fish/textures/btnOut.png"}},{"type":"Button","props":{"y":262,"x":12,"var":"gameset","stateNum":1,"skin":"res/fish/textures/btnSetup.png"}}]},{"type":"Button","props":{"y":21,"x":1767,"visible":true,"var":"btnVisible1","stateNum":1,"skin":"res/fish/textures/btnvisible1.png"}},{"type":"Button","props":{"y":21,"x":1767,"visible":true,"var":"btnVisible2","stateNum":1,"skin":"res/fish/textures/btnvisible2.png"}},{"type":"Button","props":{"y":239,"x":116,"var":"btnshop","stateNum":1,"skin":"res/fish/textures/chongzhi.png","anchorY":0.5,"anchorX":0.5},"child":[{"type":"Label","props":{"y":80,"x":50,"name":"propIceTime","fontSize":30,"font":"Arial","color":"#000000","anchorY":0.5,"anchorX":0.5,"align":"center"}}]},{"type":"Sprite","props":{},"child":[{"type":"Image","props":{"y":718,"x":80,"var":"iceProp","skin":"res/fish/textures/prop2.png","anchorY":0.5,"anchorX":0.5}},{"type":"Sprite","props":{"y":0,"x":0},"child":[{"type":"Image","props":{"y":658,"x":22,"skin":"res/fish/textures/icon.png"}},{"type":"Sprite","props":{"y":654,"x":20,"width":122,"var":"iceEffect","renderType":"mask","height":126}}]},{"type":"Label","props":{"y":718,"x":80,"var":"iceTimer","fontSize":30,"color":"#000000","anchorY":0.5,"anchorX":0.5}}]},{"type":"Sprite","props":{"y":145,"x":2},"child":[{"type":"Image","props":{"y":718,"x":80,"var":"flashProp","skin":"res/fish/textures/prop3.png","anchorY":0.5,"anchorX":0.5}},{"type":"Sprite","props":{"y":0,"x":0},"child":[{"type":"Image","props":{"y":658,"x":22,"skin":"res/fish/textures/icon.png"}},{"type":"Sprite","props":{"y":654,"x":20,"width":122,"var":"flashEffect","renderType":"mask","height":126}}]},{"type":"Label","props":{"y":718,"x":80,"var":"flashTimer","fontSize":30,"color":"#000000","anchorY":0.5,"anchorX":0.5}}]},{"type":"Sprite","props":{"y":-149,"x":3},"child":[{"type":"Image","props":{"y":718,"x":80,"var":"fireProp","skin":"res/fish/textures/prop1.png","anchorY":0.5,"anchorX":0.5}},{"type":"Sprite","props":{"y":0,"x":0},"child":[{"type":"Image","props":{"y":658,"x":22,"skin":"res/fish/textures/icon.png"}},{"type":"Sprite","props":{"y":654,"x":20,"width":122,"var":"fireEffect","renderType":"mask","height":126}}]},{"type":"Label","props":{"y":718,"x":80,"var":"fireTimer","fontSize":30,"color":"#000000","anchorY":0.5,"anchorX":0.5}}]}]},{"type":"Sprite","props":{"y":0,"x":0,"width":1920,"var":"mengban","height":1080,"alpha":0.5},"child":[{"type":"Rect","props":{"y":0,"x":0,"width":1920,"lineWidth":1,"height":1080,"fillColor":"#000000"}}]},{"type":"Image","props":{"y":540,"x":960,"width":1920,"var":"mengbanbg","height":1080,"anchorY":0.5,"anchorX":0.5}},{"type":"Label","props":{"y":493,"x":871,"visible":false,"var":"bulNum","text":"8888","fontSize":70,"color":"#ff0400"}},{"type":"Label","props":{"y":582,"x":876,"visible":false,"var":"fishNum","text":"8888","fontSize":70,"color":"#ff0400"}},{"type":"Label","props":{"y":676,"x":876,"visible":false,"var":"coNum","text":"8888","fontSize":70,"color":"#ff0400"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}