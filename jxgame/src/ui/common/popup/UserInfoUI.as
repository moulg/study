/**Created by the LayaAirIDE,do not modify.*/
package ui.common.popup {
	import laya.ui.*;
	import laya.display.*; 

	public class UserInfoUI extends Dialog {
		public var btnClose:Button;
		public var avatar:Image;
		public var btnName:Button;
		public var nickname:TextInput;
		public var btnCopy:Button;
		public var userId:Label;
		public var gold:Label;
		public var jxGold:Label;
		public var passW:Box;
		public var password1:TextInput;
		public var password2:TextInput;
		public var btnPassworld:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1013,"height":600},"child":[{"type":"Image","props":{"y":-4,"x":0,"skin":"res/common/public/popBg3.png"}},{"type":"Image","props":{"y":52,"x":584,"skin":"res/common/public/long.png"}},{"type":"Image","props":{"y":24,"x":375,"skin":"res/common/public/title.png"}},{"type":"Image","props":{"y":31,"x":422,"skin":"res/common/public/userInfo.png"}},{"type":"Button","props":{"y":-1,"x":939,"var":"btnClose","stateNum":1,"skin":"res/common/public/close.png"}},{"type":"Image","props":{"y":1,"x":-11,"skin":"res/common/public/shop3.png"}},{"type":"Image","props":{"y":100,"x":72,"width":134,"var":"avatar","height":134}},{"type":"Image","props":{"y":98,"x":70,"width":138,"skin":"res/common/public/radiusBor2.png","height":138,"sizeGrid":"16,18,19,22"}},{"type":"Image","props":{"y":108,"x":232,"width":214,"skin":"res/common/public/radiusBor4.png","height":46,"sizeGrid":"7,7,7,7"}},{"type":"Button","props":{"y":108,"x":460,"var":"btnName","stateNum":1,"skin":"res/common/public/radiusBor3.png","labelSize":28,"labelPadding":"0,0,3,0","labelColors":"#491106","labelBold":true,"label":"修改"}},{"type":"TextInput","props":{"y":108,"x":232,"width":317,"var":"nickname","text":"玩家昵称六个字","maxChars":6,"height":46,"fontSize":28,"color":"#4e302b","bold":true}},{"type":"Label","props":{"y":117,"x":604,"text":"游戏ID:","fontSize":28,"color":"#72381f","bold":true}},{"type":"Button","props":{"y":108,"x":838,"var":"btnCopy","stateNum":1,"skin":"res/common/public/radiusBor3.png","labelSize":28,"labelPadding":"0,0,3,0","labelColors":"#491106","labelBold":true,"label":"复制"}},{"type":"Label","props":{"y":117,"x":707,"var":"userId","text":"26558700","fontSize":28,"color":"#72381f"}},{"type":"Image","props":{"y":178,"x":234,"skin":"res/common/public/gold.png"}},{"type":"Label","props":{"y":191,"x":300,"var":"gold","text":"8517","fontSize":28,"color":"#72381f"}},{"type":"Image","props":{"y":180,"x":609,"skin":"res/common/public/fjGold.png"}},{"type":"Label","props":{"y":191,"x":673,"var":"jxGold","text":"0","fontSize":28,"color":"#72381f"}},{"type":"Box","props":{"y":266,"x":57,"var":"passW"},"child":[{"type":"Image","props":{"width":886,"skin":"res/common/public/radiusBor1.png","height":257,"sizeGrid":"10,10,10,10"}},{"type":"Label","props":{"y":80,"x":267,"text":"新密码","fontSize":28,"color":"#72381f","bold":true}},{"type":"TextInput","props":{"y":71,"x":368,"width":306,"var":"password1","type":"password","skin":"res/common/public/radiusBor4.png","promptColor":"#b0906b","prompt":"账号密码6-12位英文+数字","height":46,"fontSize":24,"color":"#4e302b","bold":true,"align":"center","sizeGrid":"7,7,7,7"}},{"type":"Label","props":{"y":156,"x":209,"text":"重复新密码","fontSize":28,"color":"#72381f","bold":true}},{"type":"TextInput","props":{"y":147,"x":368,"width":306,"var":"password2","type":"password","skin":"res/common/public/radiusBor4.png","promptColor":"#b0906b","prompt":"账号密码6-12位英文+数字","height":46,"fontSize":24,"color":"#4e302b","bold":true,"align":"center","sizeGrid":"7,7,7,7"}},{"type":"Button","props":{"y":148,"x":686,"var":"btnPassworld","stateNum":1,"skin":"res/common/public/radiusBor3.png","labelSize":28,"labelPadding":"0,0,3,0","labelColors":"#491106","labelBold":true,"label":"确认"}}]},{"type":"Label","props":{"y":546,"x":291,"text":"温馨提示：修改昵称每次扣除金币50，首次免费!","fontSize":20,"color":"#8d6343","bold":true}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}