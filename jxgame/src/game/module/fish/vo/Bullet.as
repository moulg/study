package game.module.fish.vo{

	import game.module.fish.FishConfig;
	import laya.ui.Image;
	import game.core.model.GlobalConfig;
	import laya.display.Sprite;
	import laya.display.Animation;
	import laya.events.Event;
	import laya.maths.Point;
	import game.module.fish.vo.BatteryManager;
	import game.module.fish.FishModel;

	public class Bullet extends Sprite{
		//死亡标识
		private var _life:Boolean = true;
		/*1 底边
		*2 右边
		*3 顶边
		*4 左边
		*/
		private var _side:int = 3;

		//计时 毫秒 一边到另一边的时间
		private var _run_time:Number;
		//速度
		private var _run_speed:int;
		//增量
		private var _run_pos:Object;
		//初始坐标（每次反弹后需要重置）
		private var _start_pos:Object;
		private var _bonding_box:Array;
		//子弹ID
		private var _b_ID:String ="";
		//玩家ID
		private var _p_ID:String ="";
		//锁定的鱼
		private var _lockFish_ID:String = "";

		private var _multiple:int;
		private var _net:Animation;
		private var _ani:Sprite;
		public function Bullet(bInfo:Object){
			super();

			this._run_time = 14;
			this._side=3;
			this._b_ID=bInfo.bulletId;
			this._p_ID=bInfo.playerId;
			this._run_pos = {x:0,y:0};

			this._bonding_box = [{a:0,b:0,r:16}];

			this._multiple = bInfo.mul;

			this._lockFish_ID = bInfo.lockfish;

			//设置坐标
			this.x = bInfo.spos.x;
			this.y = bInfo.spos.y;

			//记录初始坐标
			this._start_pos={x:x,y:y};

			////设置子弹速度（后期放配置）
			_run_speed = 10;

			//播放渔网
			_net = new Animation();
			_net.loadAnimation(FishConfig.fishNetUrl);
			_net.interval=30;
			_net.play(0,false,getNRes());
			addChild(_net);
			_net.visible=false;
			_net.stop();

			//加载动画文件
			_ani = new Sprite();
			addChild(_ani);

			var num:int =  FishConfig.getBulletNum(this._multiple);
			if(num==1){
				var ani:Animation = new Animation();
				ani.loadAnimation(FishConfig.bulletUrl);
				ani.interval=30;
				ani.rotation = 90;
				ani.play(0,true,getBRes());
				_ani.addChild(ani);
			}else if(num==2){
				var ani1:Animation = new Animation();
				ani1.loadAnimation(FishConfig.bulletUrl);
				ani1.interval=30;
				ani1.rotation = 90;
				ani1.y=-40;
				ani1.play(0,true,getBRes());
				_ani.addChild(ani1);

				var ani2:Animation = new Animation();
				ani2.loadAnimation(FishConfig.bulletUrl);
				ani2.interval=30;
				ani2.rotation = 90;
				ani2.y=40;
				ani2.play(0,true,getBRes());
				_ani.addChild(ani2);
			}
			else if(num==3){
				var ani3:Animation = new Animation();
				ani3.loadAnimation(FishConfig.bulletUrl);
				ani3.interval=30;
				ani3.rotation = 90;
				ani3.y=-50;
				ani3.play(0,true,getBRes());
				_ani.addChild(ani3);

				var ani4:Animation = new Animation();
				ani4.loadAnimation(FishConfig.bulletUrl);
				ani4.interval=30;
				ani4.rotation = 90;
				ani4.play(0,true,getBRes());
				_ani.addChild(ani4);

				var ani5:Animation = new Animation();
				ani5.loadAnimation(FishConfig.bulletUrl);
				ani5.interval=30;
				ani5.rotation = 90;
				ani5.y=50;
				ani5.play(0,true,getBRes());
				_ani.addChild(ani5);
			}
			// var bul:Image = new Image();
			// bul.skin = getBImage();
			// bul.rotation=30;
			// addChild(bul);

			//设置角度
			setRotation(bInfo.angle);

			//按照初始发射角度 矫正边
			if(3==_side){
				if(this.rotation>180){
					_side = 1;
				}
			}
		}

		public function setRotation(angle:int):void{
			this.rotation = angle;
		}
		//
		public function update():void{
			//触碰边界
			if(check()){
				//碰撞的边
				var side:int = getSide();
				//对应边反射后的角度
				//rotation = getAngle(side);
				setRotation(getAngle(side));
				//记录边（需要在角度算完后操作）
				_side = side;
				//重置时间
				_run_time = 0;
				//重新记录起点
				_start_pos.x =  _start_pos.x + _run_pos.x;
				_start_pos.y =  _start_pos.y + _run_pos.y;
				//重置增量
				_run_pos.x = 0;
				_run_pos.y = 0;
			}

			//与炮台角度同步
			var bat:Object = BatteryManager.Instance.getbattery(_p_ID);
			if(_p_ID!=""&&_lockFish_ID!=""&&bat&&bat.lockFish!=""&&bat.lockFish==_lockFish_ID){
				if(bat.curAngle<=180){
					//rotation = bat.curAngle;
					setRotation(bat.curAngle);
				}
			}

			//计时
			_run_time = _run_time+1;

			//计算子弹总路程
			var dis:int = _run_time*_run_speed;
			//获得增量
			_run_pos.x =  dis*Math.cos((rotation/180)*Math.PI);
			_run_pos.y =  dis*Math.sin((rotation/180)*Math.PI);
			//设置坐标
			this.x= _start_pos.x+_run_pos.x;
			this.y= _start_pos.y+_run_pos.y;
		}
		//边界判断
		private function check():Boolean{

			//获取当前实时坐标
			var t_x:Number = _start_pos.x+_run_pos.x;
			var t_y:Number = _start_pos.y+_run_pos.y;
			
			//遍历子弹碰撞列表 是否在屏幕内
			for(var index:int =0;index<_bonding_box.length;index++){
				var bod:Object = _bonding_box[index];
				if(bod){

					t_x = t_x + bod.a;
					t_y = t_y + bod.b;
					if(t_x<bod.r||FishConfig.GAME_WIDTH-t_x<bod.r||t_y<bod.r||FishConfig.GAME_HEIGHT-t_y<bod.r){
						return true;
					}
				}
			}

			return false;
		}

		//获取一边到另一边的角度
		private function getAngle(next_side:int):int{

			var angle:int = rotation;

			if(angle==90||angle==270){
				return 360-angle;
			}else if(angle==0||angle==360){
				return 180;
			}else if(angle==180){
				return 0;
			}

			if(_side==1&&next_side==2){          //bottom -> right
				if(angle<90){
					return 180-angle;
				}
				return 360-angle+180;
			}else if(_side==1&&next_side==3){    //bottom -> top
				if(angle>90){
					return 180-angle+180;
				}
				return 360-angle;
			}else if(_side==1&&next_side==4){    //bottom -> left
				if(angle>180){
					return 360-(angle-180);
				}
				return 180-angle;
			}else if(_side==3&&next_side==2){    //top -> left
				if(angle>270){
					return 360-angle+180;
				}
				return 180-angle;
			}else if(_side==3&&next_side==4){    //top -> right
				if(angle>180){
					return 360-(angle-180);
				}
				return 180-angle;
			}else if(_side==3&&next_side==1){    //top -> bottom
				if(angle>90){
					return 180+(180-angle);
				}
				return 360-angle;
			}else if(_side==4&&next_side==3){    //left -> top
				return 360-angle;
			}else if(_side==4&&next_side==1){    //left -> bottom
				return 360-angle;
			}else if(_side==4&&next_side==2){    //left -> right
				if(angle<90){
					return 180-angle;
				}
				return 360-angle+180;
			}else if(_side==2&&next_side==3){    //right -> top
				if(angle>180){
					return 180-(angle-180);
				}
				return 180-angle+180;
			}else if(_side==2&&next_side==1){    //right -> bottom
				if(angle>90){
					return 180-angle+180;
				}
				return 360-angle;
			}else if(_side==2&&next_side==4){    //right -> left
				if(angle>180){
					return 360-(angle-180);
				}
			}
			return 180-angle;
		}


		//*******子弹在四条边的哪个边******
		private function getSide():int{

			var pos:Object = {x:_start_pos.x+_run_pos.x,y:_start_pos.y+_run_pos.y};
			//var pos:Object = {x:x,y:y};

			var side:int = 0;
			if ((pos.x < FishConfig.GAME_WIDTH/2 && pos.y > FishConfig.GAME_HEIGHT/2) && (pos.x <= FishConfig.GAME_HEIGHT - pos.y) ){  //at left side
				side = 4;
				//trace("============================================at left side1");
			}else if ((pos.x < FishConfig.GAME_WIDTH/2 && pos.y > FishConfig.GAME_HEIGHT/2) && (pos.x > FishConfig.GAME_HEIGHT - pos.y)) {//at bottom side
				side = 1;
				//trace("============================================at bottom side1");
			}else if ((pos.x < FishConfig.GAME_WIDTH/2 && pos.y < FishConfig.GAME_HEIGHT/2) && (pos.x <= pos.y) ) { //at left side
				side = 4;
				//trace("============================================at left side2");
			}else if ((pos.x < FishConfig.GAME_WIDTH/2 && pos.y < FishConfig.GAME_HEIGHT/2) && (pos.x > pos.y) ) { //at top sie
				side = 3;
				//trace("============================================at top side1");
			}else if ((pos.x > FishConfig.GAME_WIDTH/2 && pos.y > FishConfig.GAME_HEIGHT/2) && (FishConfig.GAME_WIDTH - pos.x <= FishConfig.GAME_HEIGHT - pos.y)) { //at right side
				side = 2;
				//trace("============================================at right side1");
			}else if ((pos.x > FishConfig.GAME_WIDTH/2 && pos.y > FishConfig.GAME_HEIGHT/2) && (FishConfig.GAME_WIDTH - pos.x > FishConfig.GAME_HEIGHT - pos.y) ) { //at bottom side
				side = 1;
				//trace("============================================at bottom side2");
			}else if ((pos.x > FishConfig.GAME_WIDTH/2 && pos.y < FishConfig.GAME_HEIGHT/2) && (FishConfig.GAME_WIDTH - pos.x <= pos.y) ) { //at right side
				side = 2;
				//trace("============================================at right side2");
			}else if ((pos.x > FishConfig.GAME_WIDTH/2 && pos.y < FishConfig.GAME_HEIGHT/2) && (FishConfig.GAME_WIDTH - pos.x > pos.y)) { // --at top side
				side = 3;
				//trace("============================================at top side2");
			};
			return side
		}

		public function get bulletID():String{
			return _b_ID;
		}

		public function get playerID():String{
			return _p_ID;
		}

		public function set life(life:Boolean):void{
			_life = life;
		}
		public function get life():Boolean{
			return _life;
		}
		public function get BBX():Array{
			var point:Point = new Point(0,0);
			var bbx:Array = [];
			for(var i:int in _bonding_box){
				var bod:Object = _bonding_box[i];
				if(bod){
					// var t_a:Number = bod.a*Math.cos((rotation/180)*Math.PI) + bod.b*Math.sin((rotation/180)*Math.PI)+x;
					// var t_b:Number = bod.b*Math.cos((rotation/180)*Math.PI) - bod.a*Math.sin((rotation/180)*Math.PI)+y;
					point.x = bod.a;
					point.y = bod.b;
					localToGlobal(point);
					if(FishModel.instance.sceneRotation){
						point.x =FishConfig.GAME_WIDTH - point.x;
						point.y =FishConfig.GAME_HEIGHT - point.y;
					}
					var t:Object={a:point.x,b:point.y,r:bod.r};
					bbx.push(t);
				}
			}
			return bbx;
		}

		public function getBRes():String{
			var str:String = FishConfig.getBulletName(this._multiple);
			return str;
		}
		public function getBImage():String{
			return "res/fish/bullet/bul1_1.png";
		}
		public function getNRes():String{
			var str:String = FishConfig.getFishNetName(this._multiple);
			return str;
		}
		public function get lockFish():String{
			return _lockFish_ID;
		}
		public function shotSomething():void{
			_life = true;
			_side = 3;
			_run_time =0;
			_run_pos = {x:0,y:0};
			_lockFish_ID = "";

			_ani.visible = false;
			_ani.removeSelf();
			_ani = null;
			
			_net.visible = true;
			_net.play(0,false,getNRes());
			_net.on(Event.COMPLETE, this, function ():void{
				_net.stop();
				_net.visible = false;
				_net.removeSelf();
				removeSelf();
			});
		}
	}
}