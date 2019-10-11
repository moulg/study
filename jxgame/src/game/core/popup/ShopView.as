package game.core.popup{
	
	import game.core.enum.GlobalEnum;
	import game.core.enum.GlobalPopup;
	import game.core.enum.Module;
	import game.core.manager.PopupManager;
	import game.core.model.GlobalConfig;
	import game.core.model.GlobalModel;
	import game.core.utils.CoreHound;
	import game.core.utils.Signal;
	
	import laya.events.Event;
	import laya.utils.Handler;
	
	import ui.common.popup.ShopUI;
	
	/**
	 * liuhe
	 */
	public class ShopView extends ShopUI{
		
		private var shopData:Array=[{gold:100,price:100},{gold:200,price:200},{gold:300,price:300},{gold:400,price:400},{gold:500,price:500},{gold:600,price:600}];
		
		public function ShopView(){
			zOrder=9999;
			shopList.array=[];
			for (var i:int = 0; i < shopData.length; i++){
				shopList.array.push({
					gold:shopData[i].gold+"金币",
					img:"res/common/gold/gold"+(i+1)+".png",
					price:"￥"+shopData[i].price
				})
			}
			
			shopList.vScrollBarSkin=null;
			shopList.selectEnable=true;
			shopList.scrollBar.elasticBackTime = 150;
			shopList.scrollBar.elasticDistance = 200;
			shopList.mouseHandler = Handler.create(this,onShopList, null, false);
			
			Signal.on(GlobalEnum.SELF_INFO,this,onUpdateSelfInfo);
			btnClose.on(Event.CLICK,this,onClose);
			
		}
		override public function onOpened():void{
			onUpdateSelfInfo();
		}
		private function onShopList(e:Event,index:int):void{
			if(e.type=="click"){
				CoreHound.effect("button");
			}
		}
		
		private function onClose():void{
			CoreHound.effect("button");
			close();
		}
		
		override public function onClosed(type:String=null):void{
			super.onClosed(type);
			PopupManager.destroy(Module.COMMON,GlobalPopup.SHOP);
		}
		
		/**************个人信息*****************/
		private function onUpdateSelfInfo():void{
			gold.text = GlobalModel.instance.self.gold/GlobalConfig.goldrate+"";
		}
	}
}