package game.module.fish.vo{
	import laya.display.Animation;
	import game.core.ui.Toast;
	import game.module.fish.FishConfig;
	import game.module.fish.vo.Fish;
	import game.module.fish.vo.BatteryManager;
	import game.module.fish.FishModel;
	import game.module.fish.enum.FishSignal;
	public class FishManager{

		private static var _instance:FishManager = null;

		private var _bbx:Array = [];
		private var _index:Array = [];
		private var _object:Array = [];
		private var _objectBBX:Array = [];
		private var _panel:Object = null;
		private var _switch:int = 0;
		//鱼单例对象管理器 控制 鱼的生死和屏幕内鱼刷新
		public function FishManager(enforcer:SingletonEnforcer){
			if(!enforcer)throw new trace("Singleton Error");
		};

		public static function get Instance():FishManager
		{
			if(!_instance)_instance = new FishManager(new SingletonEnforcer());
			return _instance;
		}

		public function destroy():void{
			_instance = null;
		}

		public function init(panel:Object):void{
			_panel = panel;
			if(_panel){
				//trace("FishManager init success");
			}else{
				//trace("FishManager init failed");
			}
		};

		//创建鱼接口
		public function createFish(fInfo:Object):void{
			// if(_switch>=50){
			// 	return;
			// }
			// _switch++;

			var fish:Fish = _object[fInfo.id];
			if(fish){
				//trace("这条鱼已经存在！！！");
			}else{
				fish = new Fish(fInfo);
				_panel.addChild(fish);

				_object[fInfo.id]=fish;
				_objectBBX[fInfo.id]=fish.BBX;
			}
		};
		public function catchFishByBBX(bbx:Array):Object{
			var res:Object = {fish:null,count:0};
			for(var i:int=0 in _objectBBX)
			{ 
				var abbx:Array = _objectBBX[i];
				if(abbx){
					for(var y:int=0 in bbx){
						var butBBx:Object = bbx[y];
						if(butBBx){
							for(var x:int=0 in abbx){
								var fishbbx:Object = abbx[x];
								if(fishbbx){
									res.count++;
									var dis:int = Math.floor( Math.sqrt(Math.pow(fishbbx.a-butBBx.a,2)+Math.pow(fishbbx.b-butBBx.b,2)));
									if(butBBx.r+fishbbx.r>dis){
										_object[i].beenShot();
										res.fish = _object[i];
										return res;
									}
								}
							}
						}
					}
				}
			} 
			return res;
		}
		public function catchFishByPos(pos:Object):Fish{
			for(var i:int=0 in _objectBBX)
			{ 
				var abbx:Array = _objectBBX[i];
				if(abbx){
					for(var x:int=0 in abbx){
						var fishbbx:Object = abbx[x];
						if(fishbbx){
							var dis:int = Math.floor( Math.sqrt(Math.pow(fishbbx.a-pos.x,2)+Math.pow(fishbbx.b-pos.y,2)));
							if(fishbbx.r>dis){
								return _object[i];
							}
						}
					}
				}
			} 
			return null;
		}
		public function removeFish(index:int,fishID:String,score:int,act:Boolean):void{
			var batConfig:Object = FishConfig.BATTERY_CONFIG[index+1];
			if(batConfig){
				var fish:Fish = _object[fishID];
				if(fish){
					fish.fishScore = score;
					fish.fishScoreAniPos = batConfig.scorepos;
					fish.death();
					_object[fishID]=null;
					_objectBBX[fishID]=null;
					if(act){
						FishModel.instance.event(FishSignal.REWARD,{index:fish.fishType,score:score});
					}
				}
			}
		}
		public function get fishes():Array{
			return _object;
		}
		public function getfisheById(id:String):Fish{
			return _object[id];
		}
		//
		public function update():int{
			var count:int = 0;
			var list:Array = [];
			for(var i:int in _object){
				var obj:Fish = _object[i];
				if(obj){
					count++;
					if(obj._life){
						obj.update();
						obj.fishPause = FishModel.instance.pauseFishes;
						_objectBBX[i] = obj.BBX;
						list.push(obj);
					}
					else{
						obj.removeSelf();
						_object[i] = null;
						_objectBBX[i] = null;
					}
				}
			}
			BatteryManager.Instance.lockList=list;
			return count;
		};
		public function clearFishes():void{

			for(var i:int in _object){
				var obj:Fish = _object[i];
				if(obj){
					obj.removeSelf();
					_object[i] = null;
					_objectBBX[i] = null;
				}
			}

			_object = [];
			_objectBBX = [];
		}
	}
}
//
class SingletonEnforcer{}