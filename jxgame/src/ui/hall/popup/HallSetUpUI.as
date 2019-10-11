/**Created by the LayaAirIDE,do not modify.*/
package ui.hall.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class HallSetUpUI extends Dialog {
		public var btnClose:Button;
		public var btnMusic:CheckBox;
		public var btnEffect:CheckBox;
		public var musicNum:HSlider;
		public var effectNum:HSlider;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1016,"height":608},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/public/popBg3.png"}},{"type":"Image","props":{"y":28,"x":375,"skin":"res/common/public/title.png"}},{"type":"Image","props":{"y":37,"x":464,"skin":"res/common/public/setUp0.png"}},{"type":"Image","props":{"y":94,"x":56,"width":890,"skin":"res/common/public/radiusBor1.png","height":480,"sizeGrid":"10,10,10,10"}},{"type":"Button","props":{"y":3,"x":939,"var":"btnClose","stateNum":1,"skin":"res/common/public/close.png"}},{"type":"Label","props":{"y":151,"x":234,"text":"音乐开关","fontSize":36,"color":"#4E302B"}},{"type":"Label","props":{"y":151,"x":550,"text":"音效开关","fontSize":36,"color":"#4E302B"}},{"type":"CheckBox","props":{"y":216,"x":224,"var":"btnMusic","skin":"res/common/public/checkbox_switch.png"}},{"type":"CheckBox","props":{"y":216,"x":542,"var":"btnEffect","skin":"res/common/public/checkbox_switch.png"}},{"type":"Label","props":{"y":346,"x":137,"text":"音乐","fontSize":36,"color":"#4E302B"}},{"type":"Label","props":{"y":426,"x":137,"text":"音效","fontSize":36,"color":"#4E302B"}},{"type":"HSlider","props":{"y":350,"x":246,"width":555,"var":"musicNum","value":100,"skin":"res/common/public/hslider.png","showLabel":false,"height":60,"sizeGrid":"24,45,23,71"}},{"type":"HSlider","props":{"y":430,"x":246,"width":555,"var":"effectNum","value":100,"skin":"res/common/public/hslider.png","showLabel":false,"height":60,"sizeGrid":"24,45,23,71"}},{"type":"Image","props":{"y":5,"x":-11,"skin":"res/common/public/shop3.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}