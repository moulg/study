package game.core.model{
	
	import game.core.enum.GlobalEnum;
	import game.core.manager.ExternalManager;
	import game.core.ui.Alert;
	import game.core.ui.Payment;
	import game.core.ui.Toast;
	import game.core.utils.GlobalUtil;
	import game.core.utils.Lang;
	import game.core.utils.Signal;
	import game.core.utils.Storage;
	import game.core.utils.WS;
	import game.core.vo.SelfVo;
	
	import laya.utils.Handler;

	/**
	 * chenyuan
	 */
	public class GlobalModel{
		
		private var _isKick:Boolean;
		private var _isStart:Boolean;
		private var _self:SelfVo;
		private var _userId:String;
		private var _gameList:Array;
		private var _roundList:Array;
		private var _signData:Object;
		private var _noviceData:Object;
		private var _firstRecharge:Object;
		private var _bankCardlist:Array;
		private static var _instance:GlobalModel;

		public function GlobalModel(){
		}
		
		public function init():void{
			_isKick = false;
			_isStart = false;
			_self = new SelfVo();
			initWs();
		}
		
		private function initWs():void{
			Signal.on(GlobalEnum.WS_OPEN,this,onWsOpen);
			Signal.on(GlobalEnum.WS_CLOSE,this,onWsClose);
			Signal.on(GlobalEnum.WS_ERROR,this,onWsError);
			Signal.on(GlobalEnum.WS_MESSAGE,this,onWsMessage);
			Signal.on(GlobalEnum.APP_IOS_PAY,this,iosPay);
			WS.init(Storage.env.host,Storage.env.port);
		}
		
		private function onWsMessage(msg:Object):void{
			var type:String = msg.type;
			var data:Object = msg.data;
			if(type=="onUserInfo"){
				GlobalUtil.serialize(_self,data);
				_userId = _self.userId;
				_bankCardlist=data.bankCardlist ||[];
				Signal.event(GlobalEnum.SELF_INFO);
				if(!_isStart) moduleStart();
			}else if(type=="signData"){
				_signData = data;
			}else if(type=="kick"){
				onSystemKick(data);
			}else if(type=="onMsg"){
				
			}else if(type=="onData"){
				if(data.op=="chargeSuc"){
					Payment.complete();
				}else{
					Signal.event(GlobalEnum.MODULE_MESSAGE,data);
				}
			}else if(type=="onTip"){
				Alert.show("\n"+data.msg,null,true,true,true);
			}else if(type=="onUserGold"){
				updateSelf(data);
			}else if(type=="noviceInfo"){
				_noviceData=data;
			}else{
				console.error("----onWsMessage",type,data);
			}
		}

		private function login():void{
			var obj:Object = {"loginToken":Storage.env.token,"os":"h5"};
			WS.send("login",obj,function(data:Object):void{
				gameInfo();
			});
		}
		
		private function gameInfo():void{
			WS.send("data.gameInfo",{os:"h5"},function(data:Object):void{
				_gameList = data.gameList;
				_roundList = data.roundList;
				_firstRecharge = data.firstRecharge;
				moduleStart();
				enter();
			});
		}
		
		/**修改用户信息**/
		public function changeUserinfo(obj:Object,handler:Handler):void{
			WS.send("data.change_userinfo",obj,function(data:Object,code:int):void{
				handler.runWith(data);
			});
		}
		/**测试接口**/
		public function enter():void{
			WS.send("duobao.room.enter",null,function(data:Object,code:int):void{
				trace(data);
			});
		}
		/**修改密码**/
		public function chgpsw(obj:Object,handler:Handler):void{
			WS.send("data.chgpsw",obj,function(data:Object,code:int):void{
				handler.runWith(data);
			});
		}
		
		private function moduleStart():void{
			if(_userId&&_gameList){
				_isStart = true;
				Signal.event(GlobalEnum.MODULE_START);
			}
		}
		
		private function onSystemKick(data:Object):void{
			_isKick = true;
			var msg:String = "\n"+Lang.text("kick"+data.type);
			Alert.show(msg,Handler.create(this,function(isok:Boolean):void{
				ExternalManager.reload();
			}),false,false,true);
		}
		
		private function ping():void{
			WS.send("wsp");
		}
		
		private function onWsOpen(e:*):void{
			login();
			Laya.timer.loop(30000,this,ping);
		}
		
		private function onWsClose(e:*):void{
			console.error("onWsClose",e);
			wsClose();
		}
		
		private function onWsError(e:*):void{
			console.error("onWsError",e);
			wsClose();
		}
		
		
		/**
		 * 充值
		 * @param obj 接口参数
		 * @param handler 回调
		 * @param isFirst 是否首冲
		 */
		public function payment(obj:Object,handler:Handler,isFirst:Boolean):void{
			WS.send(isFirst?"data.shop.first_buyNew":"data.shop.ingot_buyNew",obj,function(data:Object):void{
				handler.runWith(data);
			});
		}
		
		/**
		 * 苹果支付
		 * @param str 支付参数
		 */
		public function iosPay(str:String):void{
			if(!str){
				Toast.error("支付失败请重试");
				return;
			}
			var obj:Object = JSON.parse(str);
			var receipt:String = obj.receipt;
			if(!receipt||receipt=="err3"){
				Toast.error("支付失败请重试");
				return;
			}
			if(receipt=="err1"){
				Toast.error("请设置允许程序内付费");
				return;
			}
			if(receipt=="err2"){
				Toast.error("没找到对应商品");
				return;
			}
			if(receipt=="err4"){
				Toast.error("已经购买过商品");
				return;
			}
			WS.send("data.recharge.iospay_checkNew",obj,function(data:Object):void{
				
			});
		}
		
		private function wsClose():void{
			if(_isKick) return;
			Alert.show(Lang.text("wsClose"),Handler.create(this,function(isok:Boolean):void{
				if(isok) ExternalManager.reload();
			}),false,false,true);
		}
		
		/**更新自己数据**/
		public function updateSelf(data:Object):void{
			GlobalUtil.serialize(_self,data);
			Signal.event(GlobalEnum.SELF_INFO);
		}
		
		/**
		 * 判断是否可进入游戏
		 * @param gameId
		 */
		public function hasEnterGame(gameId:int):Boolean{
			if(_gameList&&_gameList.length){
				for(var i:int=0;i<_gameList.length;i++){
					var obj:Object = _gameList[i];
					if(obj.gameId==gameId){
						if(self.gold<obj.conditions){
							return false;
						}
						break;
					}
				}
			}
			return true;
		}
		

		/**自己数据**/
		public function get self():SelfVo{
			return _self;
		}
		
		/**用户ID**/
		public function get userId():String{
			return _userId;
		}
		/**游戏列表**/
		public function get gameList():Array{
			return _gameList;
		}
		

		/**重置**/
		public function reset():void{
			_isKick = false;
			_isStart = false;
			_self = null;
			_userId = null;
			_gameList = null;
			_roundList = null;
			_signData = null;
			_bankCardlist=null;
			_noviceData=null;
			_firstRecharge = null;
			Signal.off(GlobalEnum.WS_OPEN,this,onWsOpen);
			Signal.off(GlobalEnum.WS_CLOSE,this,onWsClose);
			Signal.off(GlobalEnum.WS_ERROR,this,onWsError);
			Signal.off(GlobalEnum.WS_MESSAGE,this,onWsMessage);
			Signal.off(GlobalEnum.APP_IOS_PAY,this,iosPay);
			WS.reset();
		}
		
		/**单例**/
		public static function get instance():GlobalModel{
			if(!_instance) _instance=new GlobalModel();
			return _instance;
		}
	}
}