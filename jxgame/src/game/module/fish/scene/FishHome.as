package game.module.fish.scene{
	
	import laya.display.Sprite;
	import laya.ui.View;
	import game.module.fish.FishModel;
	import game.module.fish.enum.FishScene;
	import game.module.fish.scene.FishView;
	import game.module.fish.scene.RoomView;
	
	public class FishHome extends View{
		
		private var _layer:Sprite;
		private var classList:Array = [RoomView,FishView];
		private var viewList:Array=[];
		public function FishHome(){
			_layer=new Sprite();
			addChild(_layer);

			var roomView:RoomView = new RoomView();
			_layer.addChild(roomView);
			roomView.visible = true;

			viewList.push(roomView);

			var fishView:FishView = new FishView();
			_layer.addChild(fishView);
			fishView.visible = false;

			viewList.push(fishView);

			FishModel.instance.on(FishScene.FISHVIEW,this,showScene);
			FishModel.instance.on(FishScene.ROOMVIEW,this,showDesktop);
		}
		
		private function showDesktop(obj:Object):void{
			showView(0);
		}

		private function showScene(obj:Object):void{
			showView(1);
		}
		
		private function showView(index:int):void{

			for(var i:int in viewList){
				var view:Object = viewList[i];
				if(view){
					view.hide();
				}
			}

			if(viewList[index])viewList[index].show();
		}
		
		override public function destroy(destroyChild:Boolean=true):void{
			super.destroy(destroyChild);
			viewList = null;
			classList = null;
		}
	}
}