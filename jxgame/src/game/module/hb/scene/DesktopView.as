package game.module.hb.scene{
	import game.core.enum.GlobalPopup;
	import game.core.enum.Module;
	import game.core.manager.PopupManager;
	import game.core.ui.Alert;
	import game.module.hb.HbModel;
	import game.module.hb.enum.HbPopup;
	import game.module.hb.enum.HbScene;
	import game.module.hb.enum.HbSignal;
	import game.module.hb.ui.Bet;
	import game.module.hb.ui.Gold;
	import game.module.hb.ui.Pew;
	import game.module.hb.ui.Sieves;
	import game.module.hb.ui.Start;
	import game.module.hb.utils.HbSound;
	
	import laya.events.Event;
	import laya.ui.Box;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	import ui.hb.scene.DesktopUI;

	/**
	 * liuhe
	 */
	public class DesktopView extends DesktopUI{
		/**房间信息**/
		private var roomInfo:Object;
		/**座位**/
		private var pewArr:Array=[];
		/**筛子**/
		private var sievesArr:Array=[];
		/**金币**/
		private var goldBoxArr:Array=[];
		
		/**开始**/
		private var startV:Start;
		/**下注**/
		private var betV:Bet;
		/**是否在游戏中**/
		private var inTheGame:Boolean=false; 
		
		public function DesktopView(){
			btnBack.on(Event.CLICK,this,onBack);
			btnRecharge.on(Event.CLICK,this,onRecharge);
			btnColumn.on(Event.CLICK,this,onColumn);
			btnSetUp.on(Event.CLICK,this,onSetUp);
			btnRecord.on(Event.CLICK,this,onRecord);
			btnHelp.on(Event.CLICK,this,onHelp);

			for (var i:int = 0; i < 8; i++){
				var pewBox:Box=getChildByName("pew"+i) as Box;
				var pew:Pew=new Pew();
				pewArr.push(pew);
				pewBox.addChild(pew);
				var sievesBox:Box=getChildByName("sieves"+i) as Box;
				var sieves:Sieves=new Sieves();
				sievesArr.push(sieves);
				sievesBox.addChild(sieves);
				var goldBox:Box=getChildByName("goldBox"+i) as Box;
				var goldV:Gold=new Gold();
				goldBox.addChild(goldV);
				goldBoxArr.push({box:goldBox,x:goldBox.x,y:goldBox.y,view:goldV});
			}
		}
		
		override protected function onAdd():void{
			toSelect();
			HbModel.instance.on(HbSignal.PLAYER_JOIN,this,playerJoin);
			initialPlayer(HbModel.instance.playerData.playerList);
			HbModel.instance.on(HbSignal.PLAYER_GOLD,this,playerGold);
			HbModel.instance.on(HbSignal.PLAYER_LEAVE,this,playerLeave);
			HbModel.instance.on(HbSignal.CAN_JOIN,this,onCanJion);
			HbModel.instance.on(HbSignal.REST,this,onRest);
			HbModel.instance.on(HbSignal.GETRULETIME,this,onStart);
			HbModel.instance.on(HbSignal.PLAYER_GETRULE,this,onPlayerGetrule);
			HbModel.instance.on(HbSignal.PLAYER_INFO,this,onRuleInfo);
			HbModel.instance.on(HbSignal.SETRULETIME,this,onRuleSelect);
			HbModel.instance.on(HbSignal.POINTTIME,this,onRuleConfirm);
			HbModel.instance.on(HbSignal.SIEVERESULTS,this,sieveResults);
			HbModel.instance.on(HbSignal.GETMONEY,this,getMoney);
			HbModel.instance.on(HbSignal.ADDGOLD,this,addGold);
			HbModel.instance.on(HbSignal.WAIT_TIME,this,onMatching);
		}
	
		/**商城**/
		private function onRecharge():void{
			HbSound.effect("button");
			GlobalPopup.openShop();
		}
		/**操作列表**/
		private function onColumn():void{
			HbSound.effect("button");
			column.visible=!column.visible;
			timerOnce(500,this,function():void{
			column.visible&&Laya.stage.once(Event.CLICK,this,onColumn);
			});
		}
		/**设置**/
		private function onSetUp():void{
			HbSound.effect("button");
			PopupManager.open(Module.HB,HbPopup.SETUP);
		}
		/**牌局记录**/
		private function onRecord():void{
			HbSound.effect("button");
			PopupManager.open(Module.HB,HbPopup.RECORD);	
		}
		/**帮助**/
		private function onHelp():void{
			HbSound.effect("button");
			PopupManager.open(Module.HB,HbPopup.HELP);
		}
		
		/**金币减少**/
		private function reduceGold(data:Object):void{
			pewArr[data.i].setChange(data,false);
			
			goldBoxArr[data.i].view.showGold(true);
			goldBoxArr[data.i].box.scaleX=1;
			goldBoxArr[data.i].box.scaleY=1;
			goldBoxArr[data.i].box.pos(goldBoxArr[data.i].x,goldBoxArr[data.i].y);
			Tween.to(goldBoxArr[data.i].box,{x:610,y:310,scaleX:2,scaleY:2},700,null,Handler.create(this,function():void{
				goldBoxArr[data.i].view.showGold(false);
			}));
		}
		
		/**清除数据**/
		private function toSelect():void{
			HbModel.instance.playerData.backDelete();
			for (var i:int = 0; i < pewArr.length; i++){
				pewArr[i].closePew();
				pewArr[i].isRule();
			}
			deleteAll();
		}
		
		/**清除筛子 and 弹窗 and UI**/
		private function deleteAll():void{
			PopupManager.closeByGroup("hbProcedure");
			schedule.removeChildren();
			for (var i:int = 0; i < sievesArr.length; i++){
				sievesArr[i].deleteSieves();
			}
		}
		
		/***房间列表携带参数**/
		public function openDesktop(obj:Object):void{
			roomInfo=obj;
			bets.text=roomInfo.bets;
			rulefee.text="定规费："+roomInfo.rulefee;
			onMatching();
		}
		
		/**初始玩家计算**/
		private function initialPlayer(arr:Array):void{
			for (var i:int = 0; i < arr.length; i++){
				arr[i]&&playerJoin(i);
			}
			
		}
	
		
		/**押注**/
		private function playerGold(data:Object):void{
			timerOnce(3000,this,function():void{
				data.fee=roomInfo.antes;
				reduceGold(data);
			})
		}
	
		
		/**匹配**/
		private function onMatching():void{
			PopupManager.closeByGroup("hbProcedure");
			PopupManager.open(Module.HB,HbPopup.MATCHING,null,false,false);
		}
		
		/**玩家入座**/
		private function playerJoin(index:int):void{
			pewArr[index].setUpPew(HbModel.instance.playerData.playerList[index],index==7);
		}
		
		/**休息准备**/
		private function onRest(time:int):void{
			inTheGame=false;
			deleteAll();
			PopupManager.open(Module.HB,HbPopup.REST,time,false,false);
			pewArr[7].closeArrow();
			HbModel.instance.playerData.getRuleI&&pewArr[HbModel.instance.playerData.getRuleI].isRule(false,false);
		}
		
		/**开始**/
		private function onStart(time:int):void{
			inTheGame=true;
			HbSound.effect("start");
			if(!startV){
				startV=new Start();
			}
			deleteAll();
			schedule.addChild(startV);
			startV.isPlay(true);
			timerOnce(2000,this,onBets,[time-2000]);
		}
		
		/**下注塞红包**/
		private function onBets(time:int):void{
			startV.isPlay(false);
			schedule.removeChildren();
			if(!betV){
				betV=new Bet();
			}
			schedule.addChild(betV);
			betV.onMoneyAni();
			timerOnce(3000,this,onRuleAgree,[time-3000]);
		}
		
		/**规则是否参与**/
		private function onRuleAgree(time:int):void{
			deleteAll();
			var data:Object={time:time,rulefee:roomInfo.rulefee}
			PopupManager.open(Module.HB,HbPopup.RULEAGREE,data,false,false);
			for (var i:int = 0; i < pewArr.length; i++){
				pewArr[i].playDaojishi(time);
			}
		}
		
		/**不参与规则制定**/
		private function onCanJion():void{
			deleteAll();
			pewArr[7].stopDaojishi();
		}
		
		/**参与制定规则的玩家**/
		private function onPlayerGetrule(data:Object):void{
			reduceGold(data);
			pewArr[data.i].isRule(true,false);
			pewArr[data.i].stopDaojishi();
		}
		/**竞规成功**/
		private function onRuleInfo(data:Object):void{
			for (var i:int = 0; i < pewArr.length; i++){
				pewArr[i].isRule(false,false);
				pewArr[i].stopDaojishi();
			}
			pewArr[data.i].isRule(false,true);
			pewArr[data.i].playDaojishi(data.time);
		}
		
		/**规则选择**/
		private function onRuleSelect(index:int):void{
			deleteAll();
			if(HbModel.instance.playerData.ruleIsMy){
				PopupManager.open(Module.HB,HbPopup.RULESELECT,index,false,false);
			}
			
		}
		/**规则确认**/
		private function onRuleConfirm(index:int):void{
			deleteAll();
			PopupManager.open(Module.HB,HbPopup.RULECONFIRM,index,false,false);
			pewArr[HbModel.instance.playerData.getRuleI].stopDaojishi();
		}
		
		/**筛子结果展示**/
		private function sieveResults(data:Object):void{
			sievesArr[data.i].onSieves(data.point);
			HbSound.effect("sieves");
		}
		/**红包**/
		private function getMoney(data:Object):void{
			deleteAll();
			PopupManager.open(Module.HB,HbPopup.SLUGMONEY,data,false,false);
		}
		
		/**拆红包**/
		private function addGold(data:Object):void{
			pewArr[data.i].setChange(data,true);
			goldBoxArr[data.i].view.showGold(true);
			goldBoxArr[data.i].box.scaleX=2;
			goldBoxArr[data.i].box.scaleY=2;
			goldBoxArr[data.i].box.pos(610,310);
			Tween.to(goldBoxArr[data.i].box,{x:goldBoxArr[data.i].x,y:goldBoxArr[data.i].y,scaleX:1,scaleY:1},700,null,Handler.create(this,function():void{
				goldBoxArr[data.i].view.showGold(false);
			}));
		}
		
		/**玩家离开**/
		private function playerLeave(index:int):void{
			pewArr[index].closePew();
		}
		
		/**退出房间**/
		private function onBack():void{
			HbSound.effect("button");
			if(!inTheGame){
				HbModel.instance.tableLeave(Handler.create(this,function(data:Object):void{
					toSelect();
					HbModel.instance.event(HbScene.SELECT);
				}));
				return;
			}
			
			Alert.show("\n是否离开本局比赛，若离开本局会正常结算！",Handler.create(this,function(isok:Boolean):void{
				if(isok){
					HbModel.instance.tableLeave(Handler.create(this,function(data:Object):void{
						toSelect();
						HbModel.instance.event(HbScene.SELECT);
					}));
					HbSound.effect("button");
				}
			}));
			
		}
		override protected function onRemov():void{
			HbModel.instance.off(HbSignal.PLAYER_JOIN,this,playerJoin);
			HbModel.instance.off(HbSignal.PLAYER_GOLD,this,playerGold);
			HbModel.instance.off(HbSignal.PLAYER_LEAVE,this,playerLeave);
			HbModel.instance.off(HbSignal.CAN_JOIN,this,onCanJion);
			HbModel.instance.off(HbSignal.REST,this,onRest);
			HbModel.instance.off(HbSignal.GETRULETIME,this,onStart);
			HbModel.instance.off(HbSignal.PLAYER_GETRULE,this,onPlayerGetrule);
			HbModel.instance.off(HbSignal.PLAYER_INFO,this,onRuleInfo);
			HbModel.instance.off(HbSignal.SETRULETIME,this,onRuleSelect);
			HbModel.instance.off(HbSignal.POINTTIME,this,onRuleConfirm);
			HbModel.instance.off(HbSignal.SIEVERESULTS,this,sieveResults);
			HbModel.instance.off(HbSignal.GETMONEY,this,getMoney);
			HbModel.instance.off(HbSignal.ADDGOLD,this,addGold);
			HbModel.instance.off(HbSignal.WAIT_TIME,this,onMatching);
			PopupManager.closeByGroup("hbProcedure");
			clearTimer(this,onBets);
			clearTimer(this,onRuleAgree);
		}
		override public function destroy(destroyChild:Boolean=true):void{
			super.destroy(destroyChild);
		}
	}
}