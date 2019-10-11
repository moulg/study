package game.module.fish.vo{
	import laya.display.Sprite;
	import game.module.fish.FishConfig;
	import game.module.fish.vo.BulletManager;
	import laya.ui.Button;
	import ui.fish.scene.BatteryViewUI;
	import laya.maths.Point;
	import laya.events.Event;
	import game.module.fish.FishModel;
	import laya.ui.Image;
	import game.module.fish.vo.FishManager;
	import laya.utils.Tween;
	import game.module.fish.vo.Battery;
	import laya.ui.Label;
	import game.core.model.GlobalModel;
	import game.core.model.GlobalConfig;
	import game.module.fish.utils.FishSound;

	public class Battery extends Sprite{
		//炮台
		public var _batteryNode:Sprite;
		public var _batteryBg:Image;
		public var _batteryInfo:Sprite;
		//等待进入
		private var _wateEnter:Image;
		//用户昵称
		private var _userNick:Label;
		//用户分数
		private var _userScore:Label;
		//用户倍数
		private var _userMul:Label;
		//加
		private var _add:Image;
		//减
		private var _cut:Image;
		//
		private var _battery:Image;
		private var _batteryPip:Image;
		//
		private var _self:Boolean;
		private var _multiple:int;
		private var _config:Object = null;
		private var _fireAngle:int = 0;
		private var _fireSpeed:int = 0;
		private var _frameCount:int = 0;

		//自动锁定
		private var _autoLock:Boolean = false;
		//自动发射
		private var _autoFire:Boolean = false;
		//炮台开关
		private var _fire:Boolean = true;
		private var _lockItem:Array = [];
		private var _lock_fish_lst:Array = [];
		//锁定的鱼
		private var _lockFish_ID:String = "";
		//椅子号
		private var _chaird_ID:int = 0;
		//玩家id
		private var _playerID:String = "";
		public function Battery(bInfo:Object){
			super();
			_config = bInfo;
		
			this.initData();
			this.initView();
		}
		private function initData():void{
			//
			this._self = false;

			//
			this._multiple = 1;
			this._fireSpeed = FishModel.instance.bulletSpeed*1000;
			//
			_playerID = _config.id;
			_fireAngle = _config.fangle;
		}
		private function initView():void{

			this.x = _config.pos.x;
			this.y = _config.pos.y;

			//炮台
			_batteryNode = new Sprite();
			this.addChild(_batteryNode);

			//炮座
			_batteryBg = new Image(_config.res[0]);
			_batteryBg.anchorX = 0.5;
			_batteryBg.anchorY = 0.5;
			_batteryBg.rotation = _config.bgangle;
			_batteryNode.addChild(_batteryBg);

			_batteryInfo = new Sprite();
			_batteryNode.addChild(_batteryInfo);
			//
			var flag:Image = new Image(_config.res[1]);
			flag.pos(-345,-20);
			_batteryInfo.addChild(flag);

			//分数
			_userScore = new Label("99999");
			_userScore.anchorX = 0.0;
			_userScore.anchorY = 0.5;
			_userScore.font = "Arial";
			_userScore.fontSize = 20;
			_userScore.color = "#ffffff";
			_userScore.align = "left";
			_userScore.pos(-300,0);
			_batteryInfo.addChild(_userScore);

			//昵称
			_userNick = new Label("ABCDEF");
			_userNick.anchorX = 0.0;
			_userNick.anchorY = 0.5;
			_userNick.font = "Arial";
			_userNick.fontSize = 20;
			_userNick.color = "#ffffff";
			_userNick.align = "left";
			_userNick.pos(180,0);
			_batteryInfo.addChild(_userNick);

			//增加倍率
			_add =  new Image(_config.res[3]);
			_add.pos(70,-35);
			_batteryInfo.addChild(_add);
			_add.on(Event.CLICK,this,this.addCallback);

			//减少倍率
			_cut =  new Image(_config.res[2]);
			_cut.pos(-140,-35);
			_batteryInfo.addChild(_cut);
			_cut.on(Event.CLICK,this,this.cutCallback);

			//炮
			_battery = new Image(FishConfig.getBatteryUrl(_multiple));
			_battery.anchorX = 0.5;
			_battery.anchorY = 0.5;
			_battery.rotation = _config.bangle;
			_batteryNode.addChild(_battery);

			//炮管
			_batteryPip = new Image(FishConfig.getBatteryPipUrl(_multiple));
			_batteryPip.pos(66,25);
			_batteryPip.anchorX = 0.5;
			_batteryPip.anchorY = 1;
			_battery.addChild(_batteryPip);

			//倍数
			_userMul = new Label("倍数");
			_userMul.anchorX = 0.5;
			_userMul.anchorY = 0.5;
			_userMul.font = "Arial";
			_userMul.fontSize = 16;
			_userMul.color = "#ffffff";
			_userMul.align = "center";
			_userMul.pos(67,73);
			_battery.addChild(_userMul);

			//等待加入
			_wateEnter = new Image(_config.res[4]);
			_wateEnter.anchorX = 0.5;
			_wateEnter.anchorY = 0.5;
			_wateEnter.visible = false;
			this.addChild(_wateEnter);

			for(var i:int=1;i<20;i++){
				var lineI:Image = new Image(_config.line);
				lineI.anchorX=0.5;
				lineI.anchorY=0.5;
				lineI.y=-100*i;
				lineI.x=66;
				lineI.visible = false;
				_battery.addChild(lineI);
				_lockItem.push(lineI);
			}
		}
		private function cutCallback():void{
			FishModel.instance.sendChangeBat(0);
		}
		private function addCallback():void{
			FishModel.instance.sendChangeBat(1);
		}
		//入场提示动画
		public function runTips():void{
	
		}
		//向某坐标点开火
		public function reqfire(pos:Object):void{
			var point:Point = new Point(_battery.x,_battery.y);
			localToGlobal(point);
			if(FishModel.instance.sceneRotation){
				point.x =FishConfig.GAME_WIDTH - point.x;
				point.y =FishConfig.GAME_HEIGHT - point.y;
			}

			var angle:int = FishModel.instance.getAngleByTwoPoint(pos,{x:point.x,y:point.y});

			if(FishModel.instance.sceneRotation){
				if(pos.y<point.y){
					angle = angle-180;
				}
			}

			_fireAngle = angle;
			_battery.rotation = angle+_config.fangle;
			if(_self&&_fire){
				FishModel.instance.sendBullet(Math.floor(_fireAngle));
				_fire = false;
			}
		}
		//向某角度点开火
		public function fireAngle(info:Object):void{
			if(!_self){
				_battery.rotation = info.angle+_config.fangle;
			}

			var point:Point = new Point(_battery.x,_battery.y);
			localToGlobal(point);
			if(FishModel.instance.sceneRotation){
				point.x =FishConfig.GAME_WIDTH - point.x;
				point.y =FishConfig.GAME_HEIGHT - point.y;
			}
			
			BulletManager.Instance.send({mul:_multiple,spos:{x:point.x,y:point.y},angle:info.angle,chairID:info.chairID,bulletId:info.bulletId,lockfish:_lockFish_ID,playerId:_playerID});

			Tween.to(_batteryPip, { scaleX : 1.15,scaleY:0.8 }, 0.2);
			frameOnce(2,this,function():void{
				Tween.to(_batteryPip, { scaleX : 1,scaleY:1 }, 0.4);
			});
			
			FishSound.effect(FishConfig.getBatterySound(_multiple));
		}
		//当前炮消耗分数
		public function set multiple(multiple:int):void{
			_multiple = multiple;
			updateView();
		}
		public function updateView():void{
			//当前炮倍数
			if(_userMul){
				var textMul:String = _multiple*FishModel.instance.roomMul+".00";
				_userMul.text = textMul;
			}
			//当前炮筒数
			if(_battery)_battery.skin = FishConfig.getBatteryUrl(_multiple);
			if(_batteryPip)_batteryPip.skin = FishConfig.getBatteryPipUrl(_multiple);
		}
		//当前分数
		public function set score(score:int):void{
			if(_userScore){
				_userScore.text = score/GlobalConfig.goldrate+"";

				if(_self){
					GlobalModel.instance.self.gold = score;
				}
			}
		}
		//发射速度
		public function set speed(speed:int):void{
			this._fireSpeed = speed*1000;
		}
		//昵称
		public function set name(name:String):void{
			if(_userNick){
				_userNick.text = name+"";
			}
		}
		//自己炮台
		public function set self(self:Boolean):void{
			_self = self;
			if(!_self){
				_cut.visible = false;
				_add.visible = false;
			}
		}
		public function get self():Boolean{
			return _self;
		}
		//自动发射
		public function set autoFire(auto:Boolean):void{
			_autoFire=auto;
		}
		public function get autoFire():Boolean{
			return _autoFire;
		}
		//自动锁定
		public function set autoLock(lock:Boolean):void{
			_autoLock=lock;
		}
		public function get autoLock():Boolean{
			return _autoLock;
		}
		//取消锁定鱼id
		public function setQlockFish():void{
			var fish:Object = FishManager.Instance.getfisheById(_lockFish_ID);
			if(fish){
				fish.shotflag.visible = false;
			}
			setlockLineLengh(0);
			_lockFish_ID="";
		}
		//锁定鱼id
		public function set lockFish(fishID:String):void{
			var fish:Object = FishManager.Instance.getfisheById(_lockFish_ID);
			if(fish){
				fish.shotflag.visible = false;
			}
			setlockLineLengh(0);
			_lockFish_ID=fishID;
		}
		//锁定鱼id
		public function get lockFish():String{
			return _lockFish_ID;
		}
		//椅子id
		public function get chairdID():int{
			return _chaird_ID;
		}
		//椅子id
		public function set chairdID(chairdID:int):void{
			_chaird_ID = chairdID;
		}
		//
		public function set playerId(playerId:String):void{
			_playerID = playerId;
		}
		public function get playerId():String{
			return _playerID;
		}
		public function get curAngle():int{
			return _fireAngle;
		}
		public function set lockList(list:Array):void{
			_lock_fish_lst = list;
		}
		public function setlockLineLengh(dis:Number):void{
			var count:int = dis / 88;
			for(var i:int=0;i<20;i++){
				var lineI:Image = _lockItem[i];
				if(lineI){
					if(i<count-4){
						lineI.visible = true;
					}else{
						lineI.visible = false;
					}
					if(count<=0){
						lineI.visible = false;
					}
				}
			}
		}
		public function update():void{
			_frameCount= _frameCount +16;
			if(_autoFire){
				reqSend();
				_fire = false;
			}
			if(_autoLock){
				_fire = false;
				var fish:Object = FishManager.Instance.getfisheById(_lockFish_ID);
				if(fish){
					var fishPos:Object = {x:fish.lockPos.x,y:fish.lockPos.y};
					// if(FishModel.instance.sceneRotation){
					// 	fishPos.x =FishConfig.GAME_WIDTH - fishPos.x;
					// 	fishPos.y =FishConfig.GAME_HEIGHT - fishPos.y;
					// }

					if(fishPos.x<FishConfig.GAME_WIDTH&&fishPos.x>0&&fishPos.y<FishConfig.GAME_HEIGHT&&fishPos.y>0){
						var batPos:Point = new Point(_battery.x,_battery.y);
						localToGlobal(batPos);

						if(FishModel.instance.sceneRotation){
							batPos.x =FishConfig.GAME_WIDTH - batPos.x;
							batPos.y =FishConfig.GAME_HEIGHT - batPos.y;
						}
						//角度
						var angle:int = FishModel.instance.getAngleByTwoPoint(fishPos,batPos);
						_fireAngle = angle;
						_battery.rotation = angle+_config.fangle;
						//距离
						var distance:Number = Math.sqrt( Math.pow(batPos.x - fish.lockPos.x,2) + Math.pow(batPos.y -fish.lockPos.y,2) );
						setlockLineLengh(distance);
						//准星
						fish.shotflag.visible = true;
						fish.shotflag.skin = _config.linea;
						if(_self){
							reqSend();
						}
					}else{
						fish.shotflag.visible = false;
						setlockLineLengh(0);
						_lockFish_ID = "";
						resetLock();
					}
				}else{
					setlockLineLengh(0);
					_lockFish_ID = "";
					resetLock();
				}
			}else{
				setlockLineLengh(0);
				_lockFish_ID = "";
			}

			if(!_autoFire&&!_autoLock){
				if(_frameCount>=_fireSpeed){
					_frameCount=0;
					_fire = true;
				}
			}
		}
		public function resetLock():void{
			//_lock_fish_lst.sort();
			for(var i:int in _lock_fish_lst){
				var fish:Object = _lock_fish_lst[i];
				if(fish){
					if(fish.x <= FishConfig.GAME_WIDTH && fish.x >= 0 && fish.y >= 0 && fish.y <= FishConfig.GAME_HEIGHT){
						if(_self){
							FishModel.instance.sendAutoLock(fish.fishID);
							_lockFish_ID = fish.fishID;
						}
						return;
					}
				} 
			}
		}
		public function reqSend():void{
			if(_frameCount>=_fireSpeed){
				_frameCount=0;
				FishModel.instance.sendBullet(Math.floor(_fireAngle));
			}
		}
		public function come():void{
			_batteryNode.visible = true;
			_wateEnter.visible = false;
		}
		public function reset():void{

			if(_userNick)_userNick.text = "";
			if(_userScore)_userScore.text = "";
			if(_userMul)_userMul.text = "";
			_battery.rotation = _config.bangle;
			_fireAngle = _config.fangle;
			_wateEnter.visible = true;
			_batteryNode.visible = false;

			var fish:Object = FishManager.Instance.getfisheById(_lockFish_ID);
			if(fish){
				fish.shotflag.visible = false;
			}

			setlockLineLengh(0);
			_lockFish_ID = "";

			//自动锁定
			_autoLock = false;
			//自动发射
			_autoFire = false;
			//炮台开关
			_fire = true;

			this.x = _config.pos.x;
			this.y = _config.pos.y;
		}
		public function newRotationBg(angle:int):void{
			//if(_battery)_battery.rotation = 270;
			 if(_batteryBg)_batteryBg.rotation = angle;
			if(_batteryInfo)_batteryInfo.rotation = angle;
			if(_wateEnter)_wateEnter.rotation = angle;
		}
		public function newRotationMul(angle:int):void{
			if(_userMul)_userMul.rotation = angle;
		}
		public function newRotationPosX(posX:int):void{
			this.x = _config.pos.x+posX;
		}
	}
}