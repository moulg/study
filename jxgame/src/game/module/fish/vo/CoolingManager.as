package game.module.fish.vo{
	import game.module.fish.FishModel;
	import laya.ui.Button;
	import laya.ui.Label;
	import laya.display.Sprite;
	import laya.ui.Image;
	public class CoolingManager{
		private var _cdTime:int = 0;
		private var _effTime:int = 0;
		private static var _instance:CoolingManager = null;
		private var _coolInfo:Object = {};
		private var _coolItems:Object = {};
		private var _cooling:Object = {};
		//CD 冷却 队列
		public function CoolingManager(enforcer:SingletonEnforcer){
			if(!enforcer)throw new trace("Singleton Error");
		};
		public static function get Instance():CoolingManager
		{
			if(!_instance)_instance = new CoolingManager(new SingletonEnforcer());
			return _instance;
		}
		public function destroy():void{
			_instance = null;
		}
		public function init(items):void{
			_coolItems = items;
		}
		public function set propInfo(info:Array):void{
			_coolInfo = info;
			checkCooling();
		}
		public function Cooling(id:String):void{
			for(var i:int in _coolInfo){
				var propInfo:Object = _coolInfo[i];
				if(propInfo&&propInfo.id==id){
					this.startCooling(propInfo.id,propInfo.cdTime,propInfo.cdTime);
					return;
				}
			}
		}
		private function checkCooling():void{
			for(var i:int=0 in _coolInfo){
				var propInfo:Object = _coolInfo[i];
				if(propInfo&&propInfo.timerCD>0){
					this.startCooling(propInfo.id,propInfo.timerCD,propInfo.cdTime);
				}
			}
		}
		 public function startCooling(id:String,cool:int,cdTime:int):void{
			_cooling[id] = {id:id,time:cool,cd:cdTime};
		}
		 public function updateTime():void{
			for(var index:int in _cooling){
				var item:Object = _cooling[index];
				if(item){
					//cooling
					if(item.time>0){
						item.time = item.time-16;
						var percent:Number = item.time/item.cd;
						var p:int = Math.floor(percent*360);
						this.updateNode(item.id,p,false,item.time);
					}
					//end
					else{
						this.updateNode(item.id,0,true,0);
						_cooling[index] = null;
						delete _cooling[index];
					}
				}
			}
		}
		public function updateNode(id:String,p:int,end:Boolean,time:int):Boolean{
			var obj:Object = _coolItems[id];
			if(obj){
				//禁用按钮
				// var btn:Image = obj["prop"];
				// if(btn){
				// 	btn.mouseEnabled = end;
				// }

				//设置进度
				var bar:Sprite = obj["effect"];
				if(bar){
					bar.graphics.clear();
					if(!end){
						bar.scaleY = -1;
						bar.rotation = -90;
						bar.graphics.drawPie(-60,-60,90,0,p,"#000000");
					}
				}
				//设置时间
				var timer:Label = obj["timer"];
				if(timer){
					_cdTime=0;
					time = Math.floor(time/1000);
					time<=0?timer.text="":timer.text = time+"";
				}

			}
			return true;
		}
		public function reset():void{
			for(var i:int=0 in _coolInfo){
				var propInfo:Object = _coolInfo[i];
				if(propInfo){
					propInfo.timerCD = 0;
					this.updateNode(propInfo.id,0,true,0);
				}
			}
			_cooling = {};
		}
	}
}
//
class SingletonEnforcer{}