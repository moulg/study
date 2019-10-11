package game.core.ui{
	
	import game.core.enum.GlobalPopup;
	import game.core.manager.ExternalManager;
	import game.core.model.GlobalConfig;
	import game.core.model.GlobalModel;
	import game.core.utils.App;
	import game.core.utils.GlobalUtil;
	import game.core.utils.Lang;
	import game.core.utils.Layer;
	import game.core.utils.Platform;
	import laya.events.Event;
	import laya.net.LocalStorage;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import ui.common.ui.PaymentUI;

	/**
	 * chenyuan
	 */
	public class Payment{
		
		private static var _ui:PaymentUI;
		public static var parameter:Object;
		
		/**
		 * 支付判断
		 * @param num 商品价格
		 * @param id 商品ID
		 * @param isFirst (可选)是否首冲 默认为false，不是首冲
		 * @param handler (可选)回调参数 默认为null
		 */	
		public static function judge(num:int,id:int,isFirst:Boolean=false,handler:Handler=null):void{
			if(App.isMiniGame)
			{
				Browser.window.wxPlay();
			}
			else if(!Platform.isJinShun){
				channel(id,isFirst,handler);
			}else{
				if(num<100){
					if(Browser.onWeiXin||Browser.onPC){
						scavenging(id,isFirst,handler);
					}else{
						WXPay(id,isFirst,handler);
					}
				}
			}
		}
		
		/**
		 * 微信支付
		 * @param id 商品ID
		 * @param isFirst 是否首冲
		 * @param handler (可选)回调参数 默认为null
		 */	
		public static function WXPay(id:int,isFirst:Boolean,handler:Handler):void{
			GlobalModel.instance.payment({goodsId:id,platform:100001},Handler.create(null,function(data:Object):void{
				LocalStorage.setItem("WXPay",data.orderNo);
				ExternalManager.webPay("微信支付","WXPay.html");
				handler&&handler.runWith(data);
			}),isFirst);
		}
		
		/**
		 * 银行卡支付
		 * @param id 商品ID
		 * @param cardno 银行卡号
		 * @param isFirst 是否首冲
		 * @param handler 回调参数
		 */	
		public static function bankCard(id:int,cardno:String,isFirst:Boolean,handler:Handler):void{
			GlobalModel.instance.payment({goodsId:id,platform:100000,cardno:cardno},Handler.create(null,function(data:Object):void{
				ExternalManager.webPay("银行卡支付",data.orderNo);
				handler&&handler.runWith(data);
			}),isFirst);
		}
		
		/**
		 * 微信扫码支付
		 * @param id 商品ID
		 * @param isFirst (可选)是否首冲，默认为false
		 * @param handler 回调参数
		 */	
		public static function scavenging(id:int,isFirst:Boolean,handler:Handler):void{
			GlobalModel.instance.payment({goodsId:id,platform:1},Handler.create(null,function(data:Object):void{
				if(Platform.isJinShunWeb){
					ExternalManager.webPay("请用微信扫码支付",data.codeUrl);
				}else{
					ExternalManager.openURL(data.orderNo);
				}
				handler&&handler.runWith(data);
			}),isFirst);
		}
		
		/**
		 * 渠道支付
		 * @param id 商品ID
		 * @param isFirst (可选)是否首冲，默认为false
		 * @param handler 回调参数
		 */	
		public static function channel(id:int,isFirst:Boolean,handler:Handler):void{
			var obj:Object = {goodsId:id,platform:1};
			if(App.isIosCheck){
				obj.platform = 0;
			}else if(Platform.isGuangDian){
				obj = GlobalUtil.mergeObject(obj,Payment.parameter);
			}
			GlobalModel.instance.payment(obj,Handler.create(null,function(data:Object):void{
				data.goodsId = id;
				pay(data);
				handler&&handler.runWith(data);
			}),isFirst);
		}
		
		/**扫码支付成功回调**/
		public static function pay(data:Object):*{
			var url:String;
			if(Platform.isGuangDian){
				Browser.window.OpenNewTab(data.orderNo);
				return;
			}else if(App.isIosCheck){
				url = data.orderNo;
				if(url&&url.length){
					var goodsId:int = data.goodsId;
					var ids:Array = [0,1,4,5,8,9,11];
					var idx:int = ids.indexOf(goodsId);
					if(idx>0){
						var obj:Object = {productId:idx*10,orderNo:url};
						var str:String = JSON.stringify(obj);
						ExternalManager.appPay(str);
						return;
					}
				}
			}else if(App.isApp){
				url = data.codeUrl;
				if(url&&url.length){
					showUI(url);
					return;
				}
			}else{
				url = data.orderNo;
				if(url&&url.length){
					if(Platform.isGGame){
						ExternalManager.webPay("购买",url);
					}else if(Platform.isSy){
						ExternalManager.webPay("购买",JSON.parse(url));
					}else{
						ExternalManager.openURL(url);
					}
					return;
				}
			}
			Toast.show(Lang.text("netError"));
		}
		
		public static function complete():void{
			if(App.isApp){
				close();
			}else{
				Browser.window.hidePay();
			}
			Toast.success("支付成功！");
		}
		
		private static function showUI(url:String):void{
			if(!_ui){
				_ui = new PaymentUI();
				_ui.close.on(Event.CLICK,null,close);
			}
			Layer.ui.addChild(_ui);
			var size:int = 500;
			var arr:Array = [url];
			var sw:Number = Browser.width/GlobalConfig.GAME_WIDTH;
			var sh:Number = Browser.height/GlobalConfig.GAME_HEIGHT;
			arr.push(Math.ceil((GlobalConfig.GAME_WIDTH-size)/2*sw));
			arr.push(Math.ceil((GlobalConfig.GAME_HEIGHT-size)/2*sh));
			arr.push(Math.ceil(size*sw));
			arr.push(Math.ceil(size*sh));
			ExternalManager.appPay(arr.join("|||"));
		}
		
		private static function close():void{
			ExternalManager.closePay();
			_ui&&_ui.removeSelf();
		}
	}
}