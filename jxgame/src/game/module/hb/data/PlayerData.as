package game.module.hb.data{
	import game.core.model.GlobalModel;
	import game.module.hb.HbModel;
	import game.module.hb.enum.HbSignal;

	/**
	 * liuhe
	 */
	public class PlayerData{
		private var _playerList:Array=[];
		private var _ruleInfo:Object;
		private var _ruleI:int;
		private var _ruleIsMy:Boolean;
		public function PlayerData(){
			
		}
		/**玩家信息列表**/
		public function get playerList():Array{
			return _playerList;
		}
		/**玩家进入座位**/
		public function set playerJoin(data:Object):void{
			for (var i:int = 0; i <8; i++){
				if(!_playerList[i]){
					if(data.uid==GlobalModel.instance.self.userId){
						i=7;
					}
					_playerList[i]=data;
					HbModel.instance.event(HbSignal.PLAYER_JOIN,i);
					break;
				}
			}
			
		}
		
		/**玩家离开座位**/
		public function set playerLeave(data:Object):void{
			for (var i:int = 0; i < _playerList.length; i++){
				if(_playerList[i]){
					if(_playerList[i].uid==data.uid){
						_playerList[i]=null;
						HbModel.instance.event(HbSignal.PLAYER_LEAVE,i);
						break;
					}
				}
			}
			
		}
		/**玩家下注**/
		public function set playerGold(data:Object):void{
			for (var i:int = 0; i < _playerList.length; i++){
				if(_playerList[i]){
					if(_playerList[i].uid==data.uid){
						_playerList[i].gold=data.gold;
						data.i=i;
						HbModel.instance.event(HbSignal.PLAYER_GOLD,data);
						break;
					}
				}
			}
		}
		
		
		/**玩家参与选定规则**/
		public function set setPlayerGetrule(data:Object):void{
			for (var i:int = 0; i < _playerList.length; i++){
				if(_playerList[i]){
					if(_playerList[i].uid==data.uid&&data.getrule==1){
						_playerList[i].gold=data.gold;
						data.i=i;
						HbModel.instance.event(HbSignal.PLAYER_GETRULE,data);
						break;
					}
				}
			}
		}
		/***设置规则胜出人信息*/
		public function set setRuleInfo(data:Object):void{
			for (var i:int = 0; i < _playerList.length; i++){
				if(_playerList[i]){
					if(_playerList[i].uid==data.uid){
						_ruleI=i;
						data.i=i;
						HbModel.instance.event(HbSignal.PLAYER_INFO,data);
						break;
					}
				}
			}
			_ruleInfo=data;
			_ruleIsMy=(data.uid==GlobalModel.instance.self.userId);
		}
		
		/***设置规则胜出人位置*/
		public function get getRuleI():int{
			return _ruleI;
		}
		
		/***规则胜出人信息*/
		public function get getRuleInfo():Object{
			return _ruleInfo;
		}
		/***选择规则自己是否胜出*/
		public function get ruleIsMy():Boolean{
			return _ruleIsMy;
		}
		
		/**筛子结果处理**/
		public function sieveResults(data:Object):void{
			for (var i:int = 0; i < _playerList.length; i++){
				if(_playerList[i]){
					if(data.uid==_playerList[i].uid){
						HbModel.instance.event(HbSignal.SIEVERESULTS,{i:i,point:data.point});
						break;
					}
				}
			}
		}
		
		/**是否有可以开启的红包**/
		public function getMoney(data:Object):void{
			for (var i:int = 0; i < data.playerlist.length; i++){
				if(data.playerlist[i].id==GlobalModel.instance.self.userId){
					HbModel.instance.event(HbSignal.GETMONEY,{time:data.time,iswin:data.playerlist[i].iswin});
					break;
				}
			}
		}
		/**增加金币**/
		public function set addGold(data:Object):void{
			for (var i:int = 0; i < _playerList.length; i++){
				if(_playerList[i]){
					if(data.uid==_playerList[i].uid){
						_playerList[i].gold=data.gold;
						data.i=i;
						HbModel.instance.event(HbSignal.ADDGOLD,data);
						break;
					}
				}
			}
			
		}
		
		/**退出游戏，删除原数据**/
		public function backDelete():void{
			_playerList=[];
		}
		
	}
}