/**Created by the LayaAirIDE,do not modify.*/
package ui.common.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class JinbiUI extends View {
		public var jinbiAni:Animation;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1280,"height":720},"child":[{"type":"Animation","props":{"y":0,"x":190,"wrapMode":"0","width":900,"var":"jinbiAni","source":"res/common/jinbi/jinbi1.png,res/common/jinbi/jinbi10.png,res/common/jinbi/jinbi11.png,res/common/jinbi/jinbi12.png,res/common/jinbi/jinbi13.png,res/common/jinbi/jinbi14.png,res/common/jinbi/jinbi15.png,res/common/jinbi/jinbi16.png,res/common/jinbi/jinbi17.png,res/common/jinbi/jinbi18.png,res/common/jinbi/jinbi19.png,res/common/jinbi/jinbi2.png,res/common/jinbi/jinbi20.png,res/common/jinbi/jinbi21.png,res/common/jinbi/jinbi22.png,res/common/jinbi/jinbi23.png,res/common/jinbi/jinbi24.png,res/common/jinbi/jinbi25.png,res/common/jinbi/jinbi3.png,res/common/jinbi/jinbi4.png,res/common/jinbi/jinbi5.png,res/common/jinbi/jinbi6.png,res/common/jinbi/jinbi7.png,res/common/jinbi/jinbi8.png,res/common/jinbi/jinbi9.png","skin":"res/common/jinbi/jinbi25.png","height":720}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}