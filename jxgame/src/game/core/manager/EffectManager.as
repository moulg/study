package game.core.manager{
	
	import game.core.model.GlobalConfig;
	
	import laya.ani.bone.Skeleton;
	import laya.display.Animation;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.utils.Handler;
	import laya.utils.Tween;

	/**
	 * chenyuan
	 */
	public class EffectManager{
		
		private static var _aniCount:int = 1;
		
		/**
		 * 获取特效
		 * @param url 地址
		 * @param handler 回调(返回Animation实例)
		 * @param isCache 是否缓存
		 */		
		public static function getAni(url:String,handler:Handler,isCache:Boolean=true):void{
			var ani:Animation = new Animation();
			handler.args = [ani];
			ani.loadAtlas(url,handler,isCache?("ANI"+_aniCount++):"");
		}
		
		/**
		 * 获取骨骼动画
		 * @param url 地址
		 * @param handler 回调(返回Skeleton实例)
		 */		
		public static function getSkeleton(url:String,handler:Handler):void{
			var skeleton:Skeleton = new Skeleton();
			handler.args = [skeleton];
			skeleton.load(url,handler);	
		}
		
		/**
		 * 播放道具特效
		 * @param itemId 道具ID
		 * @param container 显示容器
		 * @param start 开始位置
		 * @param end 结束位置
		 */		
		public static function useItem(itemId:int,container:Sprite,start:Point,end:Point):void{
			var url:String = GlobalConfig.getItemAni(itemId);
			EffectManager.getSkeleton(url,Handler.create(null,function(sk1:Skeleton):void{
				sk1.stop();
				sk1.pos(start.x,start.y);
				container.addChild(sk1);
				Tween.to(sk1,{x:end.x,y:end.y},500,null,Handler.create(this,function(sk2:Skeleton):void{
					sk2.on(Event.STOPPED,this,function():void{
						sk2.removeSelf();
						sk2.destroy();
					});
					sk2.play(0,false);
				},[sk1]));
			}));
		}
	}
}