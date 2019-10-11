package game.module.fish.scene{
	
	import laya.events.Event;
	import laya.utils.Tween;
	import game.core.ui.Toast;

	import game.module.fish.vo.FishManager;
	
	import game.module.fish.vo.BatteryManager;

	import ui.fish.scene.FishSceneUI;
	import game.module.fish.FishModel;
	import game.module.fish.enum.FishSignal;
	import laya.maths.Point;
	import game.module.fish.vo.BulletManager;
	import game.core.model.GlobalModel;
	import game.module.fish.FishConfig;
	import game.module.fish.vo.CollideManager;
	import laya.utils.Browser;
	import game.module.fish.vo.CoolingManager;
	import game.module.fish.vo.PropManager;
	import laya.display.Animation;
	import game.core.enum.GlobalPopup;
	import game.module.fish.enum.FishScene;
	import game.core.manager.PopupManager;
	import game.core.enum.Module;
	import game.module.fish.enum.FishPopup;
	import game.module.fish.popup.FishAlert;
	import laya.ui.Button;
	import game.core.manager.EffectManager;
	import laya.utils.Handler;
	import laya.ani.bone.Skeleton;
	import laya.ui.Image;
	import game.module.fish.utils.FishSound;
	
	/**
	 * chenyuan
	 */
	public class FishView extends FishSceneUI{
		private var step:int = 0;
		private var _runLight:Animation = null;
		private var _shopAni:Skeleton = null;
		private var _waterWave:Array = [];
		public function FishView(){
			super();
			FishManager.Instance.init(fishPanel);
			BulletManager.Instance.init(bulletPanel);
			BatteryManager.Instance.init(batteryPanel);
			PropManager.Instance.init(propPanel);

			CoolingManager.Instance.init({"by01":{prop:iceProp,effect:iceEffect,timer:iceTimer},
										  "by02":{prop:fireProp,effect:fireEffect,timer:fireTimer},
										  "by03":{prop:flashProp,effect:flashEffect,timer:flashTimer}});
			
			FishModel.instance.on(FishSignal.ALLFISH,this,allFish);
			FishModel.instance.on(FishSignal.ALLUSER,this,allUser);
			FishModel.instance.on(FishSignal.CURSCENE,this,curScene);
			FishModel.instance.on(FishSignal.NEWSCENE,this,newScene);
			FishModel.instance.on(FishSignal.NEWUSER,this,userEnter);
			FishModel.instance.on(FishSignal.NEWFISH,this,newFish);
			FishModel.instance.on(FishSignal.NEWBULLET,this,newBullet);
			FishModel.instance.on(FishSignal.NEWBATTERY,this,newBattery);
			FishModel.instance.on(FishSignal.LOCKFISH,this,lockFish);
			FishModel.instance.on(FishSignal.QLOCKFISH,this,qLockFish);
			FishModel.instance.on(FishSignal.OFFLINE,this,offLine);
			FishModel.instance.on(FishSignal.ENTERFINISHED,this,enterFinished);
			FishModel.instance.on(FishSignal.REWARD,this,runRewardTips);

			//道具
			iceProp.on(Event.CLICK,this,this.propIceCallback);
			fireProp.on(Event.CLICK,this,this.propFireCallback);
			flashProp.on(Event.CLICK,this,this.propflashCallback);
			btnVisible1.on(Event.CLICK,this,this.btnRight1Callback);
			btnVisible2.on(Event.CLICK,this,this.btnRight2Callback);
			gameset.on(Event.CLICK,this,this.setCallback);
			gamehelp.on(Event.CLICK,this,this.helpCallback);
			gameexit.on(Event.CLICK,this,this.exitCallback);
			autoLock.on(Event.CLICK,this,this.lockCallback);
			autoFire.on(Event.CLICK,this,this.fireCallback);
			btnshop.on(Event.CLICK,this,this.btnshopCallback);
			bulletPanel.on(Event.MOUSE_DOWN,this,this.batteryCallback);

			timerLoop(16,this,timeUpdate,null,false);
			frameLoop(1,this,update,null,false);
			//
			Laya.stage.on(Event.VISIBILITY_CHANGE, this,function():void{
				if(FishModel.instance._gameVisible){
					FishModel.instance._gameVisible = false;
					//清理
					FishManager.Instance.clearFishes();
					BulletManager.Instance.clearBullets();
					//FishModel.instance.exit();
				}else{
					FishModel.instance.enter();
					FishModel.instance._gameVisible = true;
				}
			});
			Browser.window.onunload = function():void{
			}

			closeBtn.on(Event.CLICK,this,this.closeBtnsCallback);
		};
		public function show():void{
			visible = true;
			onLoadingFinished();
		}
		public function hide():void{
			visible = false;
			FishManager.Instance.clearFishes();
			BulletManager.Instance.clearBullets();

			BatteryManager.Instance.destroybattery(GlobalModel.instance.self.userId);

			CoolingManager.Instance.reset();

			runLight(autoFire,false);
			runLight(autoLock,false);
		}
		//
		private function closeBtnsCallback(e:Event):void{
			scaleBtns(true);
		};
		private function btnRight1Callback(e:Event):void{
			scaleBtns(false);
		};
		private function btnRight2Callback(e:Event):void{
			scaleBtns(true);
		};
		private function scaleBtns(scale:Boolean):void{
			if(scale){
				Tween.to(this.btnsbg, { scaleY:0 }, 30);
				btnVisible1.visible = true;
				btnVisible2.visible = false;
				closeBtn.visible = false;
			}else{
				Tween.to(this.btnsbg, { scaleY:1 }, 100);
				btnVisible1.visible = false;
				btnVisible2.visible = true;
				closeBtn.visible = true;
			}
		};
		private function onLoadingFinished():void{
			mengbanbg.on(Event.CLICK,this,function():void{

			});
			this.mengbanbg.visible = true;
			this.mengban.visible = true;
			this.visible = true;
		}
		private function btnshopCallback(e:Event):void{
			GlobalPopup.openShop(true);
		}
		private function propFireCallback(e:Event):void{
			FishModel.instance.sendProp(PropManager.Instance.BOM);
		}
		private function propIceCallback(e:Event):void{
			FishModel.instance.sendProp(PropManager.Instance.ICE);
		}
		private function propflashCallback(e:Event):void{
			FishModel.instance.sendProp(PropManager.Instance.ELE);
		}
		private function setCallback(e:Event):void{
			PopupManager.open(Module.FISH,FishPopup.SETUP);
		}
		private function helpCallback(e:Event):void{
			PopupManager.open(Module.FISH,FishPopup.HELP);
		}
		private function lockCallback(e:Event):void{
			if(FishModel.instance.autoLock){
				FishModel.instance.autoLock=false;
				FishModel.instance.sendQAutoLock();
			}else{
				FishModel.instance.autoLock=true;
				if(FishModel.instance.autoFire){
					FishModel.instance.autoFire=false;
					BatteryManager.Instance.autoFire(FishModel.instance.autoFire);
				}
			}
			BatteryManager.Instance.autoLock(FishModel.instance.autoLock);
			runLight(autoFire,false);
			runLight(autoLock,FishModel.instance.autoLock);
		}
		private function fireCallback(e:Event):void{
			if(FishModel.instance.autoFire){
				FishModel.instance.autoFire=false;
			}else{
				FishModel.instance.autoFire=true;
				if(FishModel.instance.autoLock){
					FishModel.instance.autoLock=false;
					FishModel.instance.sendQAutoLock();
					BatteryManager.Instance.autoLock(FishModel.instance.autoLock);
				}
			}
			BatteryManager.Instance.autoFire(FishModel.instance.autoFire);
			runLight(autoLock,false);
			runLight(autoFire,FishModel.instance.autoFire);
		}
		private function exitCallback(e:Event):void{
			FishModel.instance.roomId = 0;
 			FishModel.instance.exit();
		}
		public function batteryCallback(e:Event):void{
			var point:Point = new Point(e.stageX,e.stageY);
			localToGlobal(point);

			var pos:Object = {x:e.stageX,y:e.stageY}

			if(FishModel.instance.sceneRotation){
				pos.x =FishConfig.GAME_WIDTH - pos.x;
				pos.y =FishConfig.GAME_HEIGHT - pos.y;
			}
			
			if(FishModel.instance.autoLock){
				var user:Object = FishModel.instance.getSelfInfo();
				if(user){
					//点中鱼
					var fish:Object = FishManager.Instance.catchFishByPos(pos);
					if(fish){
						BatteryManager.Instance.lockFish(user.index,fish.fishID);
						FishModel.instance.sendAutoLock(fish.fishID);
					}
				}
			}else{
				BatteryManager.Instance.reqbatteryFire(pos);
			}
		}

		private function update():void{
			//鱼儿
			var countF:int = FishManager.Instance.update();
			if(countF){
				fishNum.text = "";
			}
			//炮台
			BatteryManager.Instance.update();
			//子弹
			var countB:int = BulletManager.Instance.update();
			if(bulNum){
				bulNum.text = "";
			}

			step++;
			if(step>=6){
				step = 0
				//碰撞检测
				var countC:int = CollideManager.Instance.update();
				if(coNum){
					coNum.text = "";
				}
			}
		}
		private function timeUpdate():void{

			CoolingManager.Instance.updateTime();
			PropManager.Instance.updateTime();
		}
		//创建鱼
		private function newFish(data:Object):void{
			var fishData:Object = { id : data.id ,runTime:data.runTime,type:data.type,x:data.start_x,y:data.start_y,angle:data.angle,curve:data.curve};
			//var fishData:Object = { id : data.id ,runTime:data.runTime,type:data.type,x:1940,y:1080,angle:data.config.angle,curve:data.config.curve};
			FishManager.Instance.createFish(fishData);
		}

		//发射子弹
		private function newBullet(data:Object):void{
			BatteryManager.Instance.batteryFire({angle:data.angle,bulletId:data.bullet.bulletId,playerId:data.bullet.playerId,chairID:data.seatIndex,score:data.leftGold});
		}

		//切换炮台
		private function newBattery(data:Object):void{
			BatteryManager.Instance.newBattery(data.batteryLevel,data.seatIndex);
		}

		//重现所有鱼
		private function allFish():void{
			var fishes:Array = FishModel.instance.enterfishes;
			for(var index:int =0;index<fishes.length;index++){
				var fishinfo:Object = fishes[index];
				var fishData:Object={id : fishinfo.id ,runTime:fishinfo.runTime,type:fishinfo.type,x:fishinfo.start_x,y:fishinfo.start_y,angle:fishinfo.angle,curve:fishinfo.curve};
				FishManager.Instance.createFish(fishData);
			}
		}
		//玩家进入
		private function userEnter():void{
			var selfIndex:int = updatePlayerView(false);
			//旋转炮台
			if(selfIndex!=-1)BatteryManager.Instance.newRotation(selfIndex);
		}
		//所有玩家
		private function allUser():void{
			BatteryManager.Instance.destroyAllBattery();
			//所有炮台信息
			var selfIndex:int = updatePlayerView(true);
			//旋转场景
			if(selfIndex<=1&&selfIndex!=-1){
				rotationScene();
			}

			//旋转炮台
			if(selfIndex>-1)BatteryManager.Instance.newRotation(selfIndex);

			runShopAni();
			runWaterWave();
		}
		private function rotationScene():void{
			gamebg.rotation = 180;
			fishPanel.rotation=180;
			bulletPanel.rotation=180;
			batteryPanel.rotation=180;
			FishModel.instance.sceneRotation = true;
		}
		private function updatePlayerView(enter:Boolean):int{
			var selfIndex:int = -1;
			var players:Array = FishModel.instance.players;
			
			for(var index:int =0;index<players.length;index++){
				var info:Object = players[index];
				if(info){
					var self:Boolean = false;

					if(GlobalModel.instance.self.userId==info.playerId){
						selfIndex = info.index;
						self = true;
						if(enter){
							runTips(info.index);
						}
					}
					BatteryManager.Instance.createBattery({isSat:true,id:info.playerId,name:info.playerName,score:info.playerGold,chairid:info.index,isSelf:self});
					BatteryManager.Instance.newBattery(info.batteryLevel,info.index);
				}
			}
			return selfIndex;
		}
		//当前场景
		private function curScene():void{
			var cur:uint = FishModel.instance.sceneid;
			var config:Object = FishConfig.SCENE_CONFIG[cur];
			var res:String = config.res;
			res = res.replace(/%d/,config.id);
			gamebg.skin = res;
			if(FishModel.instance.sceneRotation){
				gamebg.rotation = 180;
			}
		}
		// //当前场景
		// private function newScene(data:Object):void{
		// 	trace("newScene:"+JSON.stringify(data));
		// 	var cur:uint = FishModel.instance.sceneid;
		// 	trace("sceneid:"+cur);
		// }
		//切换场景
		private function newScene(data:Object):void{
			FishModel.instance.changing = true;
			//新背景
			var cur:uint = FishModel.instance.sceneid;
			var config:Object = FishConfig.SCENE_CONFIG[cur];
			var res:String = config.res;
			res = res.replace(/%d/,config.id);
			var img:Image = new Image(res);
			img.x = FishConfig.GAME_WIDTH;
			gamebg.addChild(img);

			if(cur>=1&&cur<=8){
				FishSound.init(cur);
			}
			else{
				trace("error:"+cur);
			}

			//波浪动画
			var ani:Animation = new Animation();
			ani.loadAnimation(FishConfig.sceneAni);
			ani.y = FishConfig.GAME_HEIGHT/2;
			ani.interval=60;
			ani.play(0,true,"ani3");
			img.addChild(ani);

			FishSound.effect("weave.wav");

			Tween.to(img, { x:0 }, 2500);

			ani.timerOnce(2500,this,function():void{
				Tween.to(ani, { x:-FishConfig.GAME_WIDTH*2 }, 1000);
				gamebg.skin = res;
			});

			timerOnce(3000,this,function():void{
				ani.stop();
				ani.removeSelf();
				img.removeSelf();
				FishModel.instance.changing = false;
			});
		}
		//锁定鱼
		private function lockFish(data:Object):void{
			BatteryManager.Instance.lockFish(data.seatIndex,data.fishId);
		}
		//取消锁定鱼
		private function qLockFish(data:Object):void{
			BatteryManager.Instance.lockFish(data.seatIndex);
		}

		//玩家离开
		private function offLine(data:Object):void{
			var user:Object = FishModel.instance.getUserInfoByChairId(data.index);
			if(user){
				FishModel.instance.deletUserInfoByChairId(data.index);
				BatteryManager.Instance.destroybattery(user.playerId);
				if(GlobalModel.instance.self.userId==user.playerId){
					FishModel.instance.event(FishScene.ROOMVIEW);
				}
			}
		}
		//
		private function enterFinished():void{

		}
		//提示动画
		private function runTips(index:int):void{
			var config:Object = null;
			if(index==0||index==3){
				config = FishConfig.BATTERY_CONFIG[4];
			}else{
				config = FishConfig.BATTERY_CONFIG[3];
			}
			var ani:Animation = new Animation();
			ani.loadAnimation(FishConfig.sceneAni);
			ani.x = config.pos.x;
			ani.y = config.pos.y-300;
			ani.interval=48;
			ani.play(0,true,"ani1");
			mengbanbg.addChild(ani);
			var temp:Function = function():void{
				mengbanbg.visible =false;
				this.mengban.visible = false;
				ani.stop();
				ani.removeSelf();
				ani= null;
				Laya.timer.clear(this,temp);
			}
			//动画时间
			Laya.timer.loop(2500,this,temp);
		}
		//自动射击和自动锁定按钮的动画
		private function runLight(node:Button,enable:Boolean):void{
			if(node){
				if(!_runLight){
					_runLight = new Animation();
					_runLight.loadAnimation(FishConfig.runLight);
					_runLight.interval = 30;
					_runLight.play(0,true,"ani1");
					node.parent.addChild(_runLight);
				}

				_runLight.visible = enable;

				if(enable){
					_runLight.x = node.x-30;
					_runLight.y = node.y-30;
				}
			}
		}
		//商店动画
		private function runShopAni():void{
			if(!_shopAni){
				EffectManager.getSkeleton(FishConfig.getSpineAni(0),Handler.create(this,function(sk:Skeleton):void{
					_shopAni = sk;
					sk.x = btnshop.x;
					sk.y = btnshop.y;
					btnshop.parent.addChild(sk);
				}));
			}
		}
		//中奖提示
		private function runRewardTips(data:Object):void{
			var ani_index:int = 0;
			//你真牛
			if(data.index>=9&&data.index<=14){
				ani_index=1;
			}
			//太棒了
			else if(data.index>=15&&data.index<=18){
				ani_index=2;
			}
			//真是太牛了
			else if(data.index>=19&&data.index<=21){
				ani_index=3;
			}
			//暴富啦
			else if(data.index==22){
				ani_index=4;
			}
			if(ani_index!=0){
				var url:String = FishConfig.getSpineAni(ani_index);
				PopupManager.open(Module.FISH,FishPopup.REWARD,{url:url,score:data.score},true,false);
			}
		}
		private function runWaterWave():void{
			if(_waterWave.length<=0){
				var pos:Array = [
					{x : 192,y : 192},{x : 576,y : 192},{x : 960,y : 192},{x : 1334,y : 192},{x : 1728,y : 192},
					{x : 192,y : 576},{x : 576,y : 576},{x : 960,y : 576},{x : 1334,y : 576},{x : 1728,y : 576},
					{x : 192,y : 960},{x : 576,y : 960},{x : 960,y : 960},{x : 1334,y : 960},{x : 1728,y : 960},
				];

				for(var index:int in pos){
					var item:Object = pos[index];
					if(item){
						var ani:Animation = new Animation();
						ani.loadAnimation(FishConfig.waterWave);
						ani.x = item.x;
						ani.y = item.y;
						ani.interval=60;
						ani.play(0,true,"ani1");
						waterPanel.addChild(ani);
						_waterWave.push(ani);
					}
				}
			}
		}
		override public function destroy(destroyChild:Boolean=true):void{
			
			FishManager.Instance.destroy();
			BulletManager.Instance.destroy();
			BatteryManager.Instance.destroy();
			super.destroy(destroyChild);
		}
	}
}