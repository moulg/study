package game.module.fish.vo{
	import game.module.fish.FishModel;
	import laya.ui.Image;
	import game.module.fish.vo.FishManager;
	import laya.utils.Handler;
	import ui.fish.popup.FishAlertUI;
	import game.module.fish.FishConfig;
	import laya.utils.Tween;
	import laya.display.Animation;
	import laya.events.Event;
	import game.module.fish.utils.FishSound;
	public class PropManager{
		private static var _instance:PropManager = null;
		private var _propInfo:Object = {};
		private var _proping:Object = {};

		private var _panel:Image = null;
		public const ICE:String = 'by01';
		public const BOM:String = 'by02';
		public const ELE:String = 'by03';

		//CD 冷却 队列
		public function PropManager(enforcer:SingletonEnforcer){
			if(!enforcer)throw new trace("Singleton Error");
		};
		public static function get Instance():PropManager
		{
			if(!_instance)_instance = new PropManager(new SingletonEnforcer());
			return _instance;
		}
		public function destroy():void{
			_instance = null;
		}
		public function init(panel:Image):void{
			_panel = panel;
			if(_panel){
			}else{
			}
		}
		public function set propInfo(info:Array):void{
			_propInfo = info;
			checkProp();
		}
		public function proping(id:String):void{
			for(var i:int in _propInfo){
				var propInfo:Object = _propInfo[i];
				if(propInfo&&propInfo.id==id){
					this.startProp(propInfo.id,propInfo.effectTime);
					return;
				}
			}
		}
		public function stopProp(id:String):void{
			var info:Object = _proping[id];
			if(info){
				info.time = 0;
			}
		}
		public function updateTime():void{
			for(var index:String in _proping){
				var item:Object = _proping[index];
				if(item){
					if(item.time>0){
						item.time = item.time - 16;
					}else{
						this.effect(item.id,false);
						_proping[index]= null;
						delete _proping[index];
					}
				}
			}
		};
		private function checkProp():void{
			for(var i:int=0 in _propInfo){
				var propInfo:Object = _propInfo[i];
				if(propInfo&&propInfo.timerEffect>0){
					this.startProp(propInfo.id,propInfo.timerEffect);
				}
			}
		}
		private function startProp(id:String,time:int):void{
			_proping[id] = {id:id,time:time};
			this.effect(id,true);
		}

		private function effect(id:String,state:Boolean):void{
			//结束特效
			switch(id){
				//冰冻
				case ICE:{
					FishModel.instance.pauseFishes = state;
				}break;
				//核弹
				case BOM:{
				}break;
				//闪电
				case ELE:{
				}break;
			}
		}
		public function runAction(data:Object):void{
			//结束特效
			switch(data.id){
				//冰冻
				case ICE:{
					//不用处理，由鱼Fish 处理
				}break;
				//核弹
				case BOM:{
					runBomAct(data,Handler.create(this,this.propRes));
				}break;
				//闪电
				case ELE:{
					//
					runFlashAct(data,Handler.create(this,this.propRes));
				}break;
			}
		}
		private function propRes(data:Object):void{
			trace(" propRes:"+JSON.stringify(data));
			//清理鱼
			for(var i:int in data.arr){
				var fishData:Object = data.arr[i];
				if(fishData){
					FishManager.Instance.removeFish(data.seatIndex,fishData.id,fishData.score,false);
				}
			}
			//更新玩家数据
			var player:Object = FishModel.instance.getUserInfo(data.playerId);
			if(player){
				player.playerGold = data.playerMoney;
				BatteryManager.Instance.updateBatteryScore(data.playerId,data.playerMoney);
			}
		};
		private function runBomAct(data:Object,callback:Handler):void{
			if(!_panel){
				return;
			}

			var time:int = 600;
			var ani1:Image = new Image(FishConfig.bomUrl);
			ani1.anchorX = 0.5;
			ani1.anchorY = 0.5;
			ani1.rotation = 0;
			ani1.pos(960,-200);
			_panel.addChild(ani1);

			Tween.to(ani1,{y:540,rotation:360},time);

			var ani2:Animation = new Animation();
			ani2.loadAnimation(FishConfig.propAction);
			ani2.interval=80;
			ani2.play(0,false,"bom");
			ani2.visible = false;
			ani2.scale(3.0,3.0);
			_panel.addChild(ani2);

			_panel.timerOnce(time,_panel,function():void{
				ani2.x = ani1.x;
				ani2.y = ani1.y;
				ani1.visible = false;
				ani2.visible = true;
				ani2.play(0,false,"bom");
				FishSound.effect("propBom.mp3");
			});
			ani2.on(Event.COMPLETE,this,function():void{
				if(callback){
					callback.runWith(data);
				}
				ani1.removeSelf();
				ani2.removeSelf();
			});
		}
		private function runFlashAct(data:Object,callback:Handler):void{
			if(!_panel){
				return;
			}
			var time:int = 1500;
			var ani1:Animation = new Animation();
			ani1.loadAnimation(FishConfig.propAction);
			ani1.interval=150;
			ani1.x = 960;
			ani1.y = 400;
			ani1.scale(2.0,2.0);
			ani1.play(0,true,"flash");
			_panel.addChild(ani1);

			var ani2:Animation = new Animation();
			ani2.loadAnimation(FishConfig.propAction);
			ani2.interval=150;
			ani2.x = 960;
			ani2.y = 540;
			ani2.scale(2.0,2.0);
			ani2.play(0,false,"ani4");
			ani2.visible = false;
			_panel.addChild(ani2);

			_panel.timerOnce(10,_panel,function():void{
				ani2.visible = true;
				ani2.play(0,true,"ani4");
			});

			ani2.timerOnce(time,ani2,function():void{
				if(callback){
					callback.runWith(data);
				}
				ani1.stop();
				ani1.removeSelf();
				ani2.stop();
				ani2.removeSelf();
			});
			FishSound.effect("propFla.mp3");
		}
	}
}
//
class SingletonEnforcer{}