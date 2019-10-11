package game.module.hb.scene
{
	import game.core.enum.GlobalEnum;
	import game.core.enum.GlobalPopup;
	import game.core.enum.Module;
	import game.core.manager.EffectManager;
	import game.core.manager.PopupManager;
	import game.core.model.GlobalConfig;
	import game.core.model.GlobalModel;
	import game.core.ui.Alert;
	import game.core.utils.Redirect;
	import game.core.utils.Signal;
	import game.module.hb.HbConfig;
	import game.module.hb.HbModel;
	import game.module.hb.enum.HbPopup;
	import game.module.hb.enum.HbScene;
	import game.module.hb.utils.HbSound;
	
	import laya.ani.bone.Skeleton;
	import laya.display.Animation;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.utils.Handler;
	
	import ui.hb.scene.SelectUI;

	/**
	 * liuhe
	 */
	public class SelectView extends SelectUI{
		private var listBox:Array;
		public function SelectView(){
			EffectManager.getSkeleton(HbConfig.getAniUrl("jiaose"),Handler.create(this,function(sk:Skeleton):void{
				sk.pos(180,660);
				jiaose.addChild(sk);
			}));
			EffectManager.getSkeleton(GlobalConfig.getAniUrl("shanxian"),Handler.create(this,function(sk:Skeleton):void{
				sk.pos(30,22);
				shanxian.addChild(sk);
			}));
			btnBack.on(Event.CLICK,this,onBack);
			btnAdd.on(Event.CLICK,this,onAddGold);
			btnHelp.on(Event.CLICK,this,onHelp);
			avatar.on(Event.CLICK,this,onAvatar);
			
			Signal.on(GlobalEnum.SELF_INFO,this,onUpdateSelfInfo);
			onUpdateSelfInfo();
			
			roomList.hScrollBarSkin=null;
			roomList.selectEnable=true;
			roomList.mouseHandler = Handler.create(this,onRoomList, null, false);
			
			timerLoop(4000,this,onAni);
		}
		
		/**************个人信息*****************/
		private function onUpdateSelfInfo():void{
			name.text = GlobalModel.instance.self.nickname;
			avatar.skin= GlobalModel.instance.self.avatar;
			gold.text = GlobalModel.instance.self.gold/HbConfig.goldrate+"";
		}
		
		
		override protected function onAdd():void{
			roomList.visible=false;
			HbModel.instance.roomList(Handler.create(this,function(data:Object):void{
				roomData(data.roomList);
			}));
		}
		
		/**房间数据and动画**/
		private function roomData(arr:Array):void{
			var roomArr:Array=[];
			for (var i:int = 0; i < arr.length; i++){
				HbConfig.goldrate=arr[i].goldrate;
				roomArr.push({
					roomImg1:"res/hb/select/room"+i+"-1.png",
					roomImg2:"res/hb/select/room"+i+"-2.png",
					bets:"底注："+arr[i].antes/arr[i].goldrate,
					roomchipmin:"准入："+arr[i].roomchipmin/arr[i].goldrate,
					id:arr[i].id,
					rulefee:arr[i].rulefee/arr[i].goldrate,
					antes:arr[i].antes,
					into:arr[i].roomchipmin/arr[i].goldrate,
					btnRoom:{disabled:!arr[i].isopen}
				})
			}
			onUpdateSelfInfo();
			roomList.array=roomArr;
			roomList.visible=true;
			/********滑入动画********/
			listBox=[];
			for (var j:int = 0; j < roomList.array.length; j++){
				var boxI:Box=roomList.getCell(j) as Box;
				listBox.push(boxI);
			}
			AniListBox();
			onAni();
		}
		/***********设置游戏列表初始值和执行帧动画*****************/
		private function AniListBox():void{
			for (var i:int = 0; i <listBox.length; i++){
				listBox[i].y=-700;
			}
			frameLoop(1,this,onListBox);
		}
		private function onListBox():void{
			for (var i:int = 0; i < listBox.length; i++){
				if(i==0||(i>0&&listBox[i-1].y>=-350)){
					if(listBox[i].y>=0){
						listBox[i].y=0;
						i==listBox.length-1&&clearTimer(this,onListBox);
					}else{
						listBox[i].y+=35;
					}
				}
			}
		}
		
		
		
		/**按钮闪光**/
		private function onAni():void{
			for (var i:int = 0; i < listBox.length; i++) {
				var ani:Animation=listBox[i].getChildByName("ani");
				ani.play(0,false);
				ani.interval=100;
			}
		}
		
		private function onAvatar():void{
			HbSound.effect("button");
			GlobalPopup.openUserInfo();
		}
		
		
		/**后退**/
		private function onBack():void{
			HbSound.effect("button");
			Redirect.hall();
		}
		
		private function onAddGold():void{
			HbSound.effect("button");
			GlobalPopup.openShop();
		}
		private function onHelp():void{
			HbSound.effect("button");
			PopupManager.open(Module.HB,HbPopup.HELP);
		}
		
		private function onRoomList(e:Event,index:int):void{
			if(e.type=="click"&&(e.target) is Button){
				HbSound.effect("button");
				if(roomList.array[index].into>GlobalModel.instance.self.gold/HbConfig.goldrate){
					Alert.show("\n您的金币余额不足！是否立即充值？",Handler.create(this,function(isok:Boolean):void{
						if(isok)GlobalPopup.openShop();
					}));
					
					return;
				}
				HbModel.instance.roomEnter({id:roomList.array[index].id},Handler.create(this,function(data:Object):void{
					HbModel.instance.event(HbScene.DESKTOP,roomList.array[index]);
					for (var i:int = 0; i < data.playerList.length; i++){
						HbModel.instance.playerData.playerJoin=data.playerList[i];
					}
				}));
			}
		}
		
	}
}