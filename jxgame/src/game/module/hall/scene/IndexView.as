package game.module.hall.scene
{
	import game.module.hall.HallModel;
	import game.module.hall.enum.HallSignal;
	
	import laya.display.Sprite;
	import laya.ui.View;
	
	/**
	 *caoheyan 
	 */
	public class IndexView extends View
	{	
		private var _layer:Sprite;
		private var _curViewIndex:int = -1;							
		private var classList:Array = [HomeView];
		private var viewList:Array;
		
		public function IndexView(){
			
			_layer = new Sprite();
			addChild(_layer);
			viewList = new Array(classList.length);				
			HallModel.instance.on(HallSignal.SHOW_HOME,this,showView,[0]);
			showView(0);
		}
		
		private function showView(index:int):void{
			if(_curViewIndex==index) return;						
			var view:Sprite = viewList[index];						
			if(!view){
				view = new classList[index]();				
				viewList[index] = view;								
			}
			_layer.removeChildren();
			if(index==2){
				var home:Sprite = viewList[0];
				_layer.addChild(home);
			}
			_layer.addChild(view);
			_curViewIndex = index;
		}
		
		override public function destroy(destroyChild:Boolean=true):void{
			super.destroy(destroyChild);
		}
	}
}