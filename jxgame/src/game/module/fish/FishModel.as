package game.module.fish{
	
	import game.core.base.BaseModel;
	import game.module.fish.enum.FishSignal;
	import game.core.ui.Toast;
	import game.core.model.GlobalModel;
	import laya.utils.Handler;
	import game.module.fish.enum.FishScene;
	import game.module.fish.vo.BatteryManager;
	import game.module.fish.popup.FishAlert;
	import game.core.enum.GlobalPopup;
	import game.module.fish.vo.CoolingManager;
	import game.module.fish.vo.PropManager;
	import game.module.fish.vo.FishManager;
	import game.module.fish.utils.FishSound;
	
	/**
	 * chenyuan
	 */
	public class FishModel extends BaseModel{
		private static var _instance:FishModel;
		//房间号
		private var _roomId:int = 0;
		//房间倍率
		private var _roomMul:int = 0;
		//子弹速度
		private var _bulletSpeed:int = 0;
		//进入时所有鱼
		private var _enterfishes:Array =[];
		//所有玩家
		private var _players:Array =[];
		//场景id
		private var _sceneid:uint =1;
		//自动锁定
		private var _autoLock:Boolean = false;
		//自动发射
		private var _autoFire:Boolean = false;
		//暂停所有鱼
		private var _pauseFishes:Boolean = false;
		//玩家技能
		private var _playerCooling:Array = [];
		//生效道具
		private var _sceneRotation:Boolean = false;
		//
		public var _gameVisible:Boolean = true;
		//
		public var _sceneChange:Boolean = false;
		public function FishModel(){
			
		}
		override public function init(data:*=null):void{
			super.init(data);
			event(FishSignal.START);
			FishSound.init(_sceneid);
		}
		override protected function onMessage(data:Object):void{
			switch(data.op){
				case "newFish":{
					event(FishSignal.NEWFISH,data.data);
				}break;
				case "newScene":{
					_sceneid = data.sceneId;
					event(FishSignal.NEWSCENE,data);
				}break;
				case "newBullet":{
					event(FishSignal.NEWBULLET,data);
				}break;
				case "inTable":{
					userEnder(data.seat);
					event(FishSignal.NEWUSER);
				}break;
				case "newBulletType":{
					event(FishSignal.NEWBATTERY,data);
				}break;
				case "removeBullet":{

				}break;
				case "lock":{
					event(FishSignal.LOCKFISH,data);
				}break;
				case "unlock":{
					event(FishSignal.QLOCKFISH,data);
				}break;
				case "killFish":{
					if(data.deadType=="bulletHit"){
						fishDeath(data);
					}
				}break;
				case "spItemUsed":{
					useProp(data);
				}break;
				case "quit":{
					event(FishSignal.OFFLINE,data);
				}break;
				case "offline":{
					event(FishSignal.OFFLINE,data);
				}break;
				case "unFreeze":{
					PropManager.Instance.stopProp(data.id);
				}break;
				default:
					console.error("----fish message",data);
					break;
			}
		}
		
		public function enter():void{
			if(_roomId!=0){
				send("fish.enter",{roomId:_roomId},function(data:Object,code:int):void{
					if(code==0){
						getInfo();
					}
					if(code==500){
						FishAlert.show("\n"+data.errMsg,Handler.create(this,function(isok:Boolean):void{
							if(isok){
								GlobalPopup.openShop(true);
								FishModel.instance.event(FishScene.ROOMVIEW);
							}
						}));
						return;
					}
				});
			}else{
				FishModel.instance.event(FishScene.ROOMVIEW);
			}
		}

		/**捕鱼列表**/
		public function getRoomInfo():void{
			send("fish.roominfo",{},function(data:Array,code:int):void{
				event(FishSignal.ROOMLIST,data);
			});
		}
		
		public function getInfo():void{
			send("fish.tableinfo",{},function(data:Object):void{
				FishModel.instance.event(FishScene.FISHVIEW);
				var tableinfo:Object = data.data;
				//所有鱼
				_enterfishes = tableinfo.allFish;
				event(FishSignal.ALLFISH);
				_players =[];
				//所有玩家
				for(var indey:int=0;indey<tableinfo.allPlayer.length;indey++){
					var player:Object = tableinfo.allPlayer[indey];
					if(player.isSat){
						_players.push({
							playerId:player.playerId,
							playerName:player.playerName,
							playerGold:player.playerGold,
							playerAvatar:player.playerAvatar,
							index:player.index,
							tableId:player.tableId,
							roomId:player.roomId,
							batteryLevel:parseInt(player.batteryLevel),
							lockedFish:player.lockedFish});
					}
				}
				
				event(FishSignal.ALLUSER);
				//当前场景id
				_sceneid = tableinfo.curScen?tableinfo.curScen:_sceneid;
				event(FishSignal.CURSCENE);
				//道具信息
				PropManager.Instance.propInfo = tableinfo.propInfo;
				CoolingManager.Instance.propInfo = tableinfo.propInfo;
				event(FishSignal.ENTERFINISHED);
			});
		}
		public function userEnder(user:Object):void{
			var player:Object = getUserInfo(user.playerId);
			if(!player){
				_players.push({
							playerId:user.playerId,
							playerName:user.playerName,
							playerGold:user.playerGold,
							playerAvatar:user.playerAvatar,
							index:user.index,
							tableId:user.tableId,
							roomId:user.roomId,
							batteryLevel:parseInt(user.batteryLevel),
							lockedFish:user.lockedFish});
			}
		}
		public function getSelfInfo():Object{
			for(var index:int =0;index<_players.length;index++){
				var info:Object = _players[index];
				if( info&&GlobalModel.instance.self.userId==info.playerId){
					return info;
				}
			}
			return null;
		}
		public function getUserInfo(playerId:String):Object{
			for(var index:int =0;index<_players.length;index++){
				var info:Object = _players[index];
				if(info&&playerId==info.playerId){
					return info;
				}
			}
			return null;
		}
		public function getUserInfoByChairId(seatId:int):Object{
			for(var index:int =0;index<_players.length;index++){
				var info:Object = _players[index];
				if(info&&seatId==info.index){
					return info;
				}
			}
			return null;
		}
		//
		public function deletUserInfoByChairId(seatId:int):void{
			for(var index:int =0;index<_players.length;index++){
				var info:Object = _players[index];
				if(info&&seatId==info.index){
					delete _players[index];
					//trace("deletUserInfoByChairId=========="+JSON.stringify(_players));
					return;
				}
			}
		}
		public function get enterfishes():Array{
			return _enterfishes;
		}

		public function get players():Array{
			return _players;
		}
		public function get Cooling():Array{
			return _playerCooling;
		}
		public function get sceneid():uint{
			return _sceneid;
		}
		public function set sceneid(id:int):void{
			_sceneid = id;
		}
		public function set autoFire(auto:Boolean):void{
			_autoFire=auto;
		}
		public function get autoFire():Boolean{
			return _autoFire;
		}
		public function set autoLock(lock:Boolean):void{
			_autoLock=lock;
		}
		public function get autoLock():Boolean{
			return _autoLock;
		}
		public function set pauseFishes(pause:Boolean):void{
			_pauseFishes=pause;
		}
		public function get pauseFishes():Boolean{
			return _pauseFishes;
		}
		public function set sceneRotation(rotation:Boolean):void{
			_sceneRotation=rotation;
		}
		public function get sceneRotation():Boolean{
			return _sceneRotation;
		}
		public function set changing(enable:Boolean):void{
			_sceneChange=enable;
		}
		public function get changing():Boolean{
			return _sceneChange;
		}
		public function set roomId(roomId:int):void{
			 _roomId = roomId;
		}
		public function get roomId():int{
			return _roomId;
		}
		public function set roomMul(roomId:int):void{
			 _roomMul = roomId;
		}
		public function get roomMul():int{
			return _roomMul;
		}
		public function set bulletSpeed(speed:int):void{
			 _bulletSpeed = speed;
		}
		public function get bulletSpeed():int{
			return _bulletSpeed;
		}
		public function sendBullet(angle:Number):void{
			if(_sceneChange)return;
			send("fish.shot",{angle:angle},function(data:Object,code:int):void{
				// if(0==code){
				// 	trace("发射子弹=============="+data.data.leftGold);
				// }

				// if(500==code){
				// 	trace("发射子弹=============="+data.errMsg);
				// }
			});
		}

		public function sendChangeBat(type:int):void{
			send("fish.changebullet",{key:type},function(data:Object,code:int):void{
				var res:Object = data.data;
				for(var index:int =0;index<_players.length;index++){
					var info:Object = _players[index];
					if(info&&res.playerId==info.playerId){
						_players[index].batteryLevel= parseInt(res.currBatteryLevel);
						return;
					}
				}
			});
		}
		public function sendHitFish(bulletID:String,fishID:String,playerID:String):void{
			send("fish.hitfish",{bulletId:bulletID,fishId:fishID,playerId:playerID},function(data:Object,code:int):void{
				// if(data.isHit){
				// 	GlobalModel.instance.self.gold = data.playerMoney;
				// }
			});
		}
		public function sendAutoLock(fishId:String):void{
			send("fish.lock",{fishId:fishId},function(data:Object,code:int):void{
				//trace("==================锁鱼");

			});
		}
		public function sendQAutoLock():void{
			send("fish.unlock",{},function(data:Object,code:int):void{
				//trace("==================锁鱼");

			});
		}
		public function sendProp(propId:String):void{
			send("fish.spitem",{itemType:propId},function(data:Object):void{
				//trace("==================使用道具:"+propId);
			});
		}
		public function exit():void{
			send("fish.quit",{},function(data:Object):void{
				if(0==data.code){
					//trace("=========================推出成功");
				}
				FishModel.instance.event(FishScene.ROOMVIEW);
			});
		}
		//鱼死亡
		private function fishDeath(data:Object):void{
			//清理鱼
			for(var i:int in data.arr){
				var fishData:Object = data.arr[i];
				if(fishData){
					FishManager.Instance.removeFish(data.seatIndex,fishData.id,fishData.score,true);
				}
			}
			//更新玩家数据
			var player:Object = getUserInfo(data.playerId);
			if(player){
				player.playerGold = data.playerMoney;
				BatteryManager.Instance.updateBatteryScore(data.playerId,data.playerMoney);
			}
		}
		//使用道具
		private function useProp(data:Object):void{
			//技能冷却CD计时
			if(data.playerId == GlobalModel.instance.self.userId){
				//加入冷却
				CoolingManager.Instance.Cooling(data.id);
			}
			//生效道具
			PropManager.Instance.proping(data.id);

			//播放动画，动画结束后刷新分数
			PropManager.Instance.runAction(data);
		}

		public function getAngleByTwoPoint(pos1:Object,pos2:Object):int{

			var angle:Number = (180 / Math.PI)*Math.atan((pos1.y-pos2.y)/(pos1.x-pos2.x));
			if(pos1.x>pos2.x&&pos1.y>pos2.y){
				//
			}
			else if(pos1.x<pos2.x&&pos1.y>pos2.y){
				angle = 180+angle;
			}
			else if(pos1.x<pos2.x&&pos1.y<pos2.y){
				angle = 180+angle;
			}
			else if(pos1.x>pos2.x&&pos1.y<pos2.y){
				angle = 360+angle;
			}
			return angle;
		}
		override public function destroy():void{
			super.destroy();
			_instance = null;
		}
		
		public static function get instance():FishModel{
			if(!_instance) _instance=new FishModel();
			return _instance;
		}
	}
}