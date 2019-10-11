/**Created by the LayaAirIDE,do not modify.*/
package ui.hb.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class BetUI extends View {
		public var wrap:Image;
		public var moneyAni:Animation;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1280,"height":720},"child":[{"type":"Image","props":{"y":181,"x":474,"var":"wrap","skin":"res/hb/ui/package.png"}},{"type":"Animation","props":{"y":181,"x":474,"width":331,"visible":false,"var":"moneyAni","source":"res/hb/ui/package.png,res/hb/ui/package2.png","skin":"res/hb/ui/package.png","height":358}},{"type":"Label","props":{"y":374,"x":520,"text":"所有玩家底注塞入红包","name":"roomchipmin","fontSize":24,"color":"#E0C076","align":"center"}},{"type":"Image","props":{"y":212,"x":570,"skin":"res/hb/ui/packageText.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}