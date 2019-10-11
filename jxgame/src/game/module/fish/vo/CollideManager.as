package game.module.fish.vo{
	import game.module.fish.FishConfig;
	import game.module.fish.vo.FishManager;
	import game.module.fish.vo.BulletManager;
	import game.module.fish.vo.Bullet;
	import game.module.fish.vo.Fish;
	import game.module.fish.FishModel;
	import game.module.fish.vo.Battery;
	import game.module.fish.vo.BatteryManager;
	public class CollideManager{
		private static var _instance:CollideManager = null;
		//碰撞检测
		public function CollideManager(enforcer:SingletonEnforcer){
			if(!enforcer)throw new trace("Singleton Error");
		};
		public static function get Instance():CollideManager
		{
			if(!_instance)_instance = new CollideManager(new SingletonEnforcer());
			return _instance;
		}
		public function destroy():void{
			_instance = null;
		}
		//子弹刷新
		public function update():int{
			var count:int = 0;
			var fish_lst:Array = [];
			var bullt_lst:Array =BulletManager.Instance.bulletes;
			for(var bulltindex:Object in bullt_lst)
			{ 
				var bullet:Bullet = bullt_lst[bulltindex];
				if(bullet){

					var bbx:Array = bullet.BBX;

					//自动锁定时只检测碰撞锁定的鱼
					var bat:Battery = BatteryManager.Instance.getbattery(bullet.playerID);
					if(bat&&bat.lockFish!=""&&bullet.lockFish!=""){
						var fish:Fish = FishManager.Instance.getfisheById(bat.lockFish);
						if(fish&&bat.lockFish == bullet.lockFish){
							if(fish.isCatched(bbx)){
								fish_lst.push({bulletID:bullet.bulletID,fishID:fish.fishID,playerID:bullet.playerID});
							}
						}else{
							//正常检测碰撞
							var fishO1:Object = FishManager.Instance.catchFishByBBX(bbx);
							count += fishO1.count;
							if(fishO1.fish){
								fish_lst.push({bulletID:bullet.bulletID,fishID:fishO1.fish.fishID,playerID:bullet.playerID});
							}
						}
					}else{
						//正常检测碰撞
						var fishO2:Object = FishManager.Instance.catchFishByBBX(bbx);
						count += fishO2.count;
						if(fishO2.fish){
							fish_lst.push({bulletID:bullet.bulletID,fishID:fishO2.fish.fishID,playerID:bullet.playerID});
						}
					}
				}
			} 

			for(var i:int in fish_lst){
				var item:Object = fish_lst[i];
				if(item){
					var userInfo:Object = FishModel.instance.getUserInfo(item.playerID);
					if(userInfo){
						FishModel.instance.sendHitFish(item.bulletID,item.fishID,item.playerID);
						BulletManager.Instance.shotSomething(item.bulletID);
					}
				}
			}
			return count;
		};
	}
}
//
class SingletonEnforcer{}