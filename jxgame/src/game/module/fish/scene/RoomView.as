package game.module.fish.scene{
	import game.core.enum.GlobalEnum;
	import game.core.model.GlobalModel;
	import game.core.utils.Redirect;
	import game.core.utils.Signal;
	import game.module.fish.FishConfig;
	import game.module.fish.FishModel;
	import game.module.fish.enum.FishSignal;
	
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	import ui.fish.scene.RoomViewUI;
	import game.core.model.GlobalConfig;

	/**
	 * chenyuan
	 */
	public class RoomView extends RoomViewUI{
		public function RoomView(){
			super();

			roomList.array = [];

			FishModel.instance.on(FishSignal.ROOMLIST,this,function(data):void{
				roomList.array=[];
				var index:int = 0;
				for (var key:Object in data.data) {
					var roomInfo:Object = data.data[key];
					if(roomInfo&&0==roomInfo.state){
						roomList.array.push({
							icon:{skin:FishConfig.getRoomIconUrl(index+1)},
							num:{skin:FishConfig.getRoomNameUrl(index+1)},
							roomId:roomInfo.roomid,
							roomMul:roomInfo.roomMul,
							bulletSpeed:roomInfo.bulletSpeed,
							min:{text:"准入: "+roomInfo.moneyrangemin+".00",strokeColor:FishConfig.getRoomStrokeColor(index)}
						});
					}
					index++;
				}

				for (var j:int = 0; j < roomList.array.length; j++){
					var boxI:Box=roomList.getCell(j) as Box;
					if(boxI){
						boxI.scaleX = 0;
						boxI.scaleY = 0;
						Tween.to(boxI,{scaleX:1.2,scaleY:1.2,complete:Handler.create(boxI,function(caller):void{
							Tween.to(caller,{scaleX:1,scaleY:1},100);
						},[boxI])},(j+1)*200);
					}
				}
			});

			roomList.vScrollBarSkin=null;
			roomList.selectEnable=false;
			roomList.mouseHandler = Handler.create(this,onRoomList, null, false);

			FishModel.instance.getRoomInfo();

			Signal.on(GlobalEnum.SELF_INFO,this,onUpdateSelfInfo);

			onUpdateSelfInfo();

			back.on(Event.CLICK,this,this.onBack);
		}
		public function resetIcon():void{
			for (var j:int = 0; j < roomList.array.length; j++){
				var boxI:Box=roomList.getCell(j) as Box;
				if(boxI){
					Tween.to(boxI,{scaleX:1,scaleY:1},1);
				}
			}
		}
		public function show():void{
			visible = true;
			onUpdateSelfInfo();
		}
		public function hide():void{
			visible = false;
		}
		public function onUpdateSelfInfo():void{
			//头像
			this.userHead.skin = GlobalModel.instance.self.avatar;
			this.userHead.scaleX = 1.3;
			this.userHead.scaleY = 1.3;
			//创建遮罩对象
            var cMask:Sprite = new Sprite();
            //画一个圆形的遮罩区域
            cMask.graphics.drawCircle(0,0,38,"#ff0000");
              //圆形所在的位置坐标
            cMask.pos(40,40);
             //实现img显示对象的遮罩效果
            this.userHead.mask = cMask;
			//昵称
			userName.text = GlobalModel.instance.self.nickname;
			//分数
			userScore.text = GlobalModel.instance.self.gold/GlobalConfig.goldrate+"";
		}
		public function onBack():void{
			Redirect.hall();
		}
		public function onRoomList(e:Event,index:int):void{
			if(e.type=="click"){
				FishModel.instance.roomId = roomList.array[index].roomId;
				FishModel.instance.roomMul = roomList.array[index].roomMul;
				FishModel.instance.bulletSpeed = roomList.array[index].bulletSpeed;
				FishModel.instance.enter();
			}
		}
		override public function destroy(destroyChild:Boolean=true):void{
			super.destroy(destroyChild);
		}
	}
}