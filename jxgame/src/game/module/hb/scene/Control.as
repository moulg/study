package game.module.hb.scene{
	import game.core.model.GlobalConfig;
	import game.module.hb.HbModel;
	import game.module.hb.enum.HbScene;
	
	import laya.display.Sprite;
	import laya.ui.View;
	
	public class Control extends View{
		
		private var _layer:Sprite;
		private var classList:Array = [SelectView,DesktopView];
		private var viewList:Array=[];
		public function Control(){
			_layer=new Sprite();
			addChild(_layer);
			HbModel.instance.on(HbScene.SELECT,this,showView,[0]);
			HbModel.instance.on(HbScene.DESKTOP,this,showDesktop);
			showView(0);
		}
		
		private function showDesktop(obj:Object):void{
			showView(1);
			var store:DesktopView = _layer.getChildAt(0) as DesktopView;
			if(store) store.openDesktop(obj);
		}
		
		private function showView(index:int):void{
			_layer.removeChildren();
			var view:Sprite = viewList[index];
			if(!view){
				view = new classList[index]();
				view.scaleX = GlobalConfig.GAME_WIDTH/view.width;
				view.scaleY = GlobalConfig.GAME_HEIGHT/view.height;
				viewList[index] = view;
			}
			_layer.addChild(view);
		}
		
		override public function destroy(destroyChild:Boolean=true):void{
			super.destroy(destroyChild);
			viewList = null;
			classList = null;
		}
	}
}