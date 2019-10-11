package game.core.popup{
	import game.core.enum.GlobalEnum;
	import game.core.model.GlobalConfig;
	import game.core.model.GlobalModel;
	import game.core.ui.Toast;
	import game.core.utils.CoreHound;
	import game.core.utils.GlobalUtil;
	import game.core.utils.Signal;
	import game.core.vo.SelfVo;
	
	import laya.events.Event;
	import laya.utils.Handler;
	
	import ui.common.popup.UserInfoUI;

	/**
	 *liuhe 
	 */
	public class UserInfoView extends UserInfoUI{
		public function UserInfoView(){
			onUpdateSelfInfo();
			
			btnName.on(Event.CLICK,this,onName);
			btnPassworld.on(Event.CLICK,this,onPassworld);
			btnClose.on(Event.CLICK,this,onClose);
		}
		
		/**************个人信息*****************/
		private function onUpdateSelfInfo():void{
			var self:SelfVo=GlobalModel.instance.self;
			nickname.text = self.nickname;
			avatar.skin= self.avatar;
			gold.text = self.gold/GlobalConfig.goldrate+"";
			userId.text = self.userId;
			avatar.skin=self.avatar;
			passW.visible=!!self.CHGPSW;
		}
		
		private function onClose():void{
			CoreHound.effect("button");
			close();
		}
		
		private function onName():void{
			GlobalModel.instance.changeUserinfo({nickname:nickname.text},Handler.create(this,function(data:Object):void{
				Toast.success("修改成功!");
			}));
		}
		
		private function onPassworld():void{
			
			if(password1.text==""){
				Toast.success("请填写新密码！");
			}else if(password2.text==""){
				Toast.success("请填写重复新密码！");
			}else if(password1.text!=password2.text){
				Toast.success("两次填写密码不同！");
			}else{
				GlobalModel.instance.chgpsw({psw:password1.text},Handler.create(this,function(data:Object):void{
					password1.text="";
					password2.text="";
					Toast.success("修改成功！");
				}));
			}
			
		}
		
		override public function onOpened():void{
			GlobalUtil.domButtonEvent(btnCopy,GlobalUtil.clipboard,userId.text);
			Signal.on(GlobalEnum.SELF_INFO,this,onUpdateSelfInfo);
			
		}
		
		override public function onClosed(type:String=null):void{
			super.onClosed(type);
			GlobalUtil.deleteDomButton(btnCopy);
		}
	}
}