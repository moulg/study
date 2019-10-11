package game.module.hall.scene{
	import game.core.enum.GameID;
	import game.core.enum.GlobalEnum;
	import game.core.enum.GlobalPopup;
	import game.core.enum.Module;
	import game.core.manager.EffectManager;
	import game.core.manager.PopupManager;
	import game.core.model.GlobalConfig;
	import game.core.model.GlobalModel;
	import game.core.ui.Alert;
	import game.core.ui.Toast;
	import game.core.utils.CoreHound;
	import game.core.utils.Redirect;
	import game.core.utils.Signal;
	import game.core.utils.Storage;
	import game.module.hall.HallConfig;
	import game.module.hall.enum.HallPopup;
	
	import laya.ani.bone.Skeleton;
	import laya.events.Event;
	import laya.utils.Handler;
	
	import ui.hall.scene.HomeUI;
	
	/**
	 * liuhe
	 */
	public class HomeView extends HomeUI{
		
		/****子游戏动画移动值***/
		private var gamesAniI:int=1;
		/****子游戏动画移动对比值***/
		private var gamesAnicC:int=0;
		/****是否是点击后清除清除子游戏动画***/
		private var gamesAnicS:Boolean=false;
		
		public function HomeView(){
			EffectManager.getSkeleton(GlobalConfig.getAniUrl("shanxian"),Handler.create(this,function(sk:Skeleton):void{
				sk.pos(30,22);
				shanxian.addChild(sk);
			}));
			
			EffectManager.getSkeleton(HallConfig.getAniUrl("jinxiujiaose"),Handler.create(this,function(sk:Skeleton):void{
				sk.pos(120,666);
				jinxiujiaose.addChild(sk);
			}));
			Signal.on(GlobalEnum.SELF_INFO,this,onUpdateSelfInfo);
			onUpdateSelfInfo();
			setGameList();
			btnAdd.on(Event.CLICK,this,onAddGold);
			btnSetUp.on(Event.CLICK,this,onSetUp);
			btnBack.on(Event.CLICK,this,onBack);
			avatar.on(Event.CLICK,this,onAvatar);
			
		}
		
		override protected function onAdd():void{
			/***进入执行动画**/
			timerOnce(5000,this,goGamesAni);
		}
		
		/**************个人信息*****************/
		private function onUpdateSelfInfo():void{
			name.text = GlobalModel.instance.self.nickname;
			avatar.skin= GlobalModel.instance.self.avatar;
			gold.text = GlobalModel.instance.self.gold/GlobalConfig.goldrate+"";
		}
		
		private function onAvatar():void{
			CoreHound.effect("button");
			GlobalPopup.openUserInfo();
		}
		
		private function onAddGold():void{
			CoreHound.effect("button");
			GlobalPopup.openShop();
		}
		
		private function onSetUp():void{
			CoreHound.effect("button");
			PopupManager.open(Module.HALL,HallPopup.SETUP);
		}
		
		private function onBack():void{
			CoreHound.effect("button");
			Alert.show("\n是否退回登录页？",Handler.create(this,function(isok:Boolean):void{
				if(isok){
					Redirect.game(GameID.LOGIN);
					Storage.clear();
				}
				CoreHound.effect("button");
			}));
		}
		
		
		private function setGameList():void{
			var arr:Array=GlobalModel.instance.gameList;
			gameList.array=[];
			for (var i:int = 0; i < arr.length; i++) {
				gameList.array.push({
					logo:{skin:"res/hall/home/game"+arr[i].gameId+"-"+arr[i].gameState+".png"},
					hotSign:{skin:"res/hall/home/hotSign"+arr[i].hotSign+".png"},
					gameId:arr[i].gameId,
					gameState:arr[i].gameState
				});
			}
			gameList.hScrollBarSkin=null;
			gameList.selectEnable=true;
			gameList.scrollBar.elasticBackTime = 150;
			gameList.scrollBar.elasticDistance = 200;
			gameList.mouseHandler = Handler.create(this,onGameList, null, false);
		}
		
		
		private function onGameList(e:Event,index:int):void{
			if(e.type=="click"){
				CoreHound.effect("button");
				if(gameList.array[index].gameState==1){
					Redirect.game(gameList.array[index].gameId);
				}else{
					Toast.error("游戏未开启，敬请期待");
				}
			}else if(e.type=="mousedown"){
				onGamePanelDown();
			}else if(e.type=="mouseup"){
				onGamePanelUp();
			}else if(e.type=="mouseout"){
				onGamePanelUp();
			}
		}
		
		
		/******进入首页子游戏5秒钟滑动一次*******/
		private function goGamesAni():void{
			if(gameList.scrollBar.max-gameList.scrollBar.value>100){
				gamesAniI=1;
			}else{
				gamesAniI=-1;
			}
			timerLoop(40,this,onGamesAni);
		}
		
		/****子游戏滑动效果*****/
		private function onGamesAni():void{
			gameList.scrollBar.value+=gamesAniI;
			gamesAnicC++;
			if(gamesAnicC==100){
				gamesAniI=-gamesAniI;
				gamesAnicC=0;
			}
		}
		
		/**点击子游戏清除效果**/
		private function onGamePanelDown():void{
			clearTimer(this,onGamesAni);
			gamesAnicS=true;
		}
		/**点击子游戏后执行5秒后执行效果**/
		private function onGamePanelUp():void{
			if(gamesAnicS){
				timerOnce(5000,this,goGamesAni);
				gamesAnicS=false;
			}
		}
		
		/**在显示列表中被移除**/
		override protected function onRemov():void{
			clearTimer(this,goGamesAni);
			clearTimer(this,onGamesAni);
		}
		override public function destroy(destroyChild:Boolean=true):void{
			super.destroy(destroyChild);
		}
	}
}