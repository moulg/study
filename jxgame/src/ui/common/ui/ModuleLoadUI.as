/**Created by the LayaAirIDE,do not modify.*/
package ui.common.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class ModuleLoadUI extends View {
		public var load:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1280,"mouseEnabled":true,"height":720},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"res/common/ui/ModuleLoadBg.png"}},{"type":"Image","props":{"y":589,"x":160,"skin":"res/common/ui/ModuleLoad1.png"}},{"type":"Panel","props":{"y":580,"x":141,"width":954,"height":57},"child":[{"type":"Image","props":{"x":800,"var":"load","skin":"res/common/ui/ModuleLoad2.png"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}