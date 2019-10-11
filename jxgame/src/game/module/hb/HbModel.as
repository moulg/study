package game.module.hb{
	
	import game.core.base.BaseModel;
	import game.core.enum.GameID;
	import game.core.enum.GlobalPopup;
	import game.core.model.GlobalModel;
	import game.core.ui.Alert;
	import game.core.ui.Toast;
	import game.core.utils.Redirect;
	import game.module.hb.data.PlayerData;
	import game.module.hb.data.RuleData;
	import game.module.hb.enum.HbScene;
	import game.module.hb.enum.HbSignal;
	
	import laya.utils.Handler;

	/**
	 * chenyuan
	 */
	public class HbModel extends BaseModel{
		
		private var _isFree:Boolean;
		private static var _instance:HbModel;
		private var _playerData:PlayerData;
		private var _ruleData:RuleData;
		public function HbModel(){
			_playerData= new PlayerData();
			_ruleData = new RuleData();
		}
		
		override public function init(data:*=null):void{
			super.init(data);
			_isFree = Boolean(data);
			event(HbSignal.START);
		}
		
		override protected function onMessage(data:Object):void{
			
			if(data.op=="playerJoin"){
				_playerData.playerJoin=data;
			}else if(data.op=="playerLeave"){
				_playerData.playerLeave=data;
			}else if(data.op=="beginTime"){
				event(HbSignal.REST,data.time);
			}else if(data.op=="playerGold"){
				_playerData.playerGold=data;
				updateSelf(data);
			}else if(data.op=="getRuleTime"){
				event(HbSignal.GETRULETIME,data.time);
			}else if(data.op=="playerGetrule"){
				_playerData.setPlayerGetrule=data;
				updateSelf(data);
			}else if(data.op=="getRule"){
//				_playerData.setRuleInfo=data;
			}else if(data.op=="setRuleTime"){
				_playerData.setRuleInfo=data;
				event(HbSignal.SETRULETIME,data.time);
			}else if(data.op=="noOneGetrule"||data.op=="setRule"||data.op=="sysSetrule"){
				_ruleData.setRule=data.ruleid;
			}else if(data.op=="pointTime"){
				event(HbSignal.POINTTIME,data.time);
			}else if(data.op=="open"){
				_playerData.sieveResults(data);
			}else if(data.op=="getMoney"){
				_playerData.getMoney(data);
			}else if(data.op=="show"){
				_playerData.addGold=data;
				updateSelf(data);
			}else if(data.op=="waitTime"){
				event(HbSignal.WAIT_TIME);
			}else if(data.op=="resultlist"){
				_ruleData.setResult=data;
			}
			else if(data.op=="kick"){
				onKick(data);	
			}else{
				console.error("----qhb message",data);
			}
			
		}
		
		/**更新自己数据**/
		private function updateSelf(data:Object):void{
			if(data.uid==GlobalModel.instance.self.userId){
				GlobalModel.instance.updateSelf(data);
			}
		}
		
		
		/**获取房间列表**/
		public function roomList(handler:Handler):void{
			send("hb.room.list",null,function(data:Object):void{
				handler.runWith(data);
			});
		}
		/**进入房间**/
		public function roomEnter(obj:Object,handler:Handler):void{
			send("hb.room.enter",obj,function(data:Object):void{
				if(data.state){
					Toast.error(data.state);
					return;
				}
				handler.runWith(data);
			});
		}
		/**是否参与规则制定**/
		public function tableGetrule(obj:Object):void{
			send("hb.table.getrule",obj);
		}
		/**选择规则**/
		public function tableSetrule(obj:Object):void{
			send("hb.table.setrule",obj);
		}
		/**掷骰子**/
		public function tableOpen():void{
			send("hb.table.open",null);
		}
		/**开启红包**/
		public function tableMoney(handler:Handler):void{
			send("hb.table.money",null,function(data:Object):void{
				handler.runWith(data);
			});
		}
		
		
		/**离开房间**/
		public function tableLeave(handler:Handler):void{
			send("hb.table.leave",null,function(data:Object):void{
				handler.runWith(data);
			});
		}
		
		private function onKick(data:Object):void{
			var uid:String = data.uid;
			var type:int = data.type;
			if(type==1){
				Alert.show("\n您的金币余额不足！是否立即充值？",Handler.create(this,function(isok:Boolean):void{
					if(isok)GlobalPopup.openShop();
					HbModel.instance.event(HbScene.SELECT);
				}));
			}else if(type==2){
				Alert.show("\n长时间未操作，回到游戏大厅！",Handler.create(this,function(isok:Boolean):void{
					if(isok) HbModel.instance.event(HbScene.SELECT);
				}));
			}else{
				Alert.show("\n服务器维护，请稍后重试！",Handler.create(this,function(isok:Boolean):void{
					if(isok) Redirect.game(GameID.LOGIN);
				}),false,false,true);
			}
		}
		
		
		public function get isFree():Boolean{
			return _isFree;
		}
		/**玩家数据**/
		public function get playerData():PlayerData{
			return _playerData;
		}
		/**规则数据**/
		public function get ruleData():RuleData{
			return _ruleData;
		}
		
		override public function destroy():void{
			super.destroy();
			_instance = null;
		}
		
		public static function get instance():HbModel{
			if(!_instance) _instance=new HbModel();
			return _instance;
		}
	}
}