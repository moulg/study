package game.module.hb.ui{
	import game.core.manager.EffectManager;
	import game.module.hb.HbConfig;
	import game.module.hb.utils.HbSound;
	
	import laya.ani.bone.Skeleton;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	import ui.hb.ui.PewUI;
	
	/**
	 * liuhe
	 */
	public class Pew extends PewUI{
		
		private var num:int=0;
		private var direction:Boolean=true;
		private var txAni:Skeleton;

		public function Pew(){
			EffectManager.getSkeleton(HbConfig.getAniUrl("avatarAni"),Handler.create(this,function(sk:Skeleton):void{
				txAni=sk;
				txAni.pos(44,44);
				avatarAni.addChild(txAni);
				txAni.paused();
			}));
		}
		
		/**
		 * 设置座位
		 * @param data 玩家数据
		 * @param isMy 是否是自己（可选）默认为false
		 */
		public function setUpPew(data:Object,isMy:Boolean=false):void{
			pewBox.visible=true;
			avatar.skin=data.avatar || "";
			name.text=data.name ||data.nickname || "";
			gold.text=(data.gold/HbConfig.goldrate).toFixed(2) || "";
			
			arrow.visible=isMy;
			isMy&&timerLoop(30,this,onArrow);
		}
		private function onArrow():void{
			num++;
			if(num>=10){
				num=0;
				direction=!direction;
			}
			if(direction){
				arrow.y++;
			}else{
				arrow.y--;
			}
		}
		
		/**关闭是自己的动画**/
		public function closeArrow():void{
			arrow.visible=false;
			clearTimer(this,onArrow);
		}
		/**隐藏座位**/
		public function closePew():void{
			pewBox.visible=false;
		}
		
		/**
		 * 金币变化
		 * @param str 变化数值
		 * @param isAdd 是否为加金币
		 */
		public function setChange(data:Object,isAdd:Boolean):void{
			HbSound.effect("gold");
			if(isAdd){
				change.text="+"+(data.addgold/HbConfig.goldrate).toFixed(2);
				change.color="#ffEa00";
				avatarAni.visible=true;
				txAni.resume();
			}else{
				change.text="-"+(data.fee/HbConfig.goldrate).toFixed(2);
				change.color="#b5b5b5";
			}
			gold.text=(data.gold/HbConfig.goldrate).toFixed(2) || "";
			change.visible=true;
			Tween.to(change,{y:30},1500,null,Handler.create(this,function():void{
				change.visible=false;
				change.y=70;
				txAni.paused();
				avatarAni.visible=false;
			}));
		}
		
		/**
		 * 局主竞规是否显示
		 * @param is1 是否显示竞选（默认不显示）
		 * @param is2 是否显示局选（默认不显示）
		 */
		public function isRule(is1:Boolean=false,is2:Boolean=false):void{
			ruleBox1.visible=is1;
			ruleBox2.visible=is2;
		}
		
		/**头像框倒计时**/
		public function playDaojishi(time:int):void{
			daojishi.visible=true;
			daojishi.interval=time/30;
			daojishi.play(0);
			timerOnce(time,this,stopDaojishi);
		}
		
		public function stopDaojishi():void{
			daojishi.visible=false;
			daojishi.stop();
		}
		
	}
}