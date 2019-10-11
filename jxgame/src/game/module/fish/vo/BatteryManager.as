package game.module.fish.vo{
	import laya.display.Animation;
	import game.module.fish.FishConfig;
	import game.module.fish.vo.Battery;
	import game.module.fish.FishModel;
	public class BatteryManager{

		private static var _instance:BatteryManager = null;
		private var _panel:Object = null;

		private var _object:Array = [];

		public var _batPos:Array = [];
		//炮台单例对象管理器 控制炮台和屏幕内炮台刷新
		public function BatteryManager(enforcer:SingletonEnforcer){
			if(!enforcer)throw new trace("Singleton Error");
		};

		public static function get Instance():BatteryManager
		{
			if(!_instance)_instance = new BatteryManager(new SingletonEnforcer());
			return _instance;
		}

		public function destroy():void{
			_instance = null;
		}

		public function init(panel:Object):void{
			_panel = panel;
			if(_panel){
				//trace("BatteryManager init success");
			}else{
				//trace("BatteryManager init failed");
				return;
			}

			//提前创建对应炮台 
			for(var battery_config:Object in FishConfig.BATTERY_CONFIG ){
				var config:Object = FishConfig.BATTERY_CONFIG[battery_config];
				if(config){
					var battery:Battery = new Battery(config);
					_panel.addChild(battery);
					_object.push(battery);
				}
			}
		};
		//显示对应位置炮台
		public function createBattery(bInfo:Object):void{
			//
			var battery:Battery = _object[parseInt(bInfo.chairid)];
			if(battery){
				battery.come();
				battery.self=bInfo.isSelf;
				battery.name=bInfo.name;
				battery.score=bInfo.score;
				battery.playerId=bInfo.id;

				if(battery.self){
					battery.runTips();
				}
			}
		};
		//切换炮台
		public function newBattery(batteryMultiple:int,chairID:int):void{
			var bat:Battery = _object[chairID];
			if(bat){
				bat.multiple = batteryMultiple;
				bat.speed = FishModel.instance.bulletSpeed;
				bat.chairdID = chairID;
			}
		};
		//
		public function newRotation(selfIndex:int):void{
			for(var i:uint=0;i<_object.length;i++){ 
				var bat:Battery = _object[i];
				if(bat){
					if(selfIndex<=1){
						bat.newRotationBg(180);
					}
					else {
						bat.newRotationBg(0);
					}

					if(selfIndex<=1){
						if(i>1){
							bat.newRotationMul(180);
						}else{
							bat.newRotationMul(0);
						}
					}else{
						if(i>1){
							bat.newRotationMul(0);
						}else{
							bat.newRotationMul(180);
						}
					}

					if(selfIndex<=1){
						//3左移
						if(i==3){
							bat.newRotationPosX(125);
						}
					}else{
						//0左移
						if(i==0){
							bat.newRotationPosX(-125);
						}
					}
				}
			}
		};
		//
		public function autoFire(enable:Boolean):void{
			for(var i:uint=0;i<_object.length;i++){ 
				var bat:Battery = _object[i];
				if(bat&&bat.self){
					bat.autoFire = enable;
					return;
				}
			} 
		};
		public function autoLock(enable:Boolean):void{
			for(var i:uint=0;i<_object.length;i++){ 
				var bat:Battery = _object[i];
				if(bat&&bat.self){
					bat.autoLock = enable;
					if(!enable)bat.setQlockFish();
					return;
				}
			} 
		};
		public function set lockList(list:Array):void{
			for(var i:uint=0;i<_object.length;i++){ 
				var bat:Battery = _object[i];
				if(bat){
					bat.lockList = list;
				}
			} 
		};
		public function lockFish(chirdId:int,fishId:String=""):void{
			var bat:Battery = _object[chirdId];
			if(bat){
				bat.lockFish = fishId;
				if(""!=fishId)
				{
					bat.autoLock = true;
				}
				else{
					bat.autoLock = false;
				}
			}
		};
		//提示动画
		public function runTips():void{
			for(var i:uint=0;i<_object.length;i++){ 
				var bat:Battery = _object[i];
				if(bat&&bat.self){
					bat.runTips();
					return;
				}
			} 
		};
		//自己开炮发射子弹
		public function reqbatteryFire(pos:Object):void{

			for(var i:uint=0;i<_object.length;i++){ 
				var bat:Battery = _object[i];
				if(bat&&bat.self&&FishModel.instance.changing==false){
					bat.reqfire(pos);
					return;
				}
			} 
		};
		//其他人开炮发射子弹
		public function batteryFire(bInfo:Object):void{
			var bat:Battery = _object[parseInt(bInfo.chairID)];
			if(bat){
				bat.fireAngle(bInfo);
				bat.score=bInfo.score;
			}
		};
		//获取炮台
		public function getbattery(playerId:String):Battery{
			for(var i:uint=0;i<_object.length;i++){ 
				var bat:Battery = _object[i];
				if(bat&&bat.playerId == playerId){
					return bat;
				}
			} 
			return null;
		};
		//获取炮台
		public function updateBatteryScore(playerId:String,score:String):void{
			for(var i:uint=0;i<_object.length;i++){ 
				var bat:Battery = _object[i];
				if(bat&&bat.playerId == playerId){
					bat.score = parseInt(score);
				}
			} 
		};
		public function destroyAllBattery():void{
			for(var i:uint=0;i<_object.length;i++){ 
				var bat:Battery = _object[i];
				if(bat){
					bat.reset();
				}
			} 
		};
		public function destroybattery(playerId:String):void{
			for(var i:uint=0;i<_object.length;i++){ 
				var bat:Battery = _object[i];
				if(bat&&bat.playerId == playerId){
					bat.reset();
				}
			} 
		};
		//炮台刷新
		public function update():void{
			for(var i:uint=0;i<_object.length;i++)
			{ 
				var bat:Battery = _object[i];
				if(bat&&bat._batteryNode.visible){
					bat.update();
				}
			} 
		};
	}
}
//
class SingletonEnforcer{}