package game.module.fish.vo{
	import laya.display.Animation;
	import game.module.fish.FishConfig;
	import game.module.fish.vo.Bullet;
	public class BulletManager{

		private static var _instance:BulletManager = null;
		private var _panel:Object = null;
		private var _object:Array = [];
		private var _objectBBx:Array = [];
		//子弹单例对象管理器 控制子弹和屏幕内子弹刷新
		public function BulletManager(enforcer:SingletonEnforcer){
			if(!enforcer)throw new trace("Singleton Error");
		};

		public static function get Instance():BulletManager
		{
			if(!_instance)_instance = new BulletManager(new SingletonEnforcer());
			return _instance;
		}

		public function destroy():void{
			_instance = null;
		}

		public function init(panel:Object):void{
			_panel = panel;
			if(_panel){
				//trace("BulletManager init success");
			}else{
				//trace("BulletManager init failed");
				return;
			}
		};

		//创建并发射子弹（...）
		public function send(bInfo:Object):void{
			var bul:Bullet = new Bullet(bInfo);
			_panel.addChild(bul);
			_object[bInfo.bulletId]=bul;
			_objectBBx[bInfo.bulletId]=bul.BBX;
		};
		public function shotSomething(id:String):void{
			var bullt:Bullet = _object[id];
			if(bullt){
				bullt.shotSomething();
				_object[id] = null;
				_objectBBx[id] = null;
			}
		};
		public function get bulletes():Array{
			return _object;
		}
		//子弹刷新
		public function update():int{
			var count:int = 0;
			for(var i:int in _object)
			{ 
				var obj:Bullet = _object[i];
				if(obj){
					count++;
					obj.update();
					_objectBBx[i]=obj.BBX;
				}
			} 
			return count;
		};
		public function clearBullets():void{

			for(var i:int in _object){
				var obj:Fish = _object[i];
				if(obj){
					obj.removeSelf();
					_object[i] = null;
					_objectBBx[i] = null;
				}
			}

			_object = [];
			_objectBBx = [];
		}
	}
}
//
class SingletonEnforcer{}