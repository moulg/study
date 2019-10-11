package game.core.enum{
	import game.core.manager.PopupManager;
	import game.core.popup.ShopView;
	import game.core.popup.UserInfoView;
	
	import laya.net.Loader;
	
	import ui.common.popup.FishShopUI;
	import ui.common.popup.ShopUI;

	/**
	 * liuhe
	 */
	public class GlobalPopup{
		
		/**商城**/
		public static const SHOP:String = "SHOP";
		/**个人中心**/
		public static const USER_INFO:String = "USER_INFO";
		/**初始化公共弹窗**/
		public static function init():void{
			var atlas:Array;
			atlas=[{url:"res/common/popup/shop.json",type:Loader.ATLAS},{url:"res/common/popup/fishShop.json",type:Loader.ATLAS}];
			PopupManager.reg(Module.COMMON,SHOP,ShopView,atlas);
			PopupManager.reg(Module.COMMON,USER_INFO,UserInfoView);
		}
		
		/**打开商城**/		
		public static function openShop(isFish:Boolean=false):void{
			if(isFish){
				ShopUI["uiBak"] = ShopUI.uiView;
				ShopUI.uiView=FishShopUI.uiView;
			}else{
				if(ShopUI["uiBak"]){
					ShopUI.uiView=ShopUI["uiBak"];
				}
			}
			PopupManager.open(Module.COMMON,SHOP);
		}
		
		/**打开个人中心**/
		public static function openUserInfo():void{
			PopupManager.open(Module.COMMON,USER_INFO);
		}
		
	}
}