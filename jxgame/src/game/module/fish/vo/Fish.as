package game.module.fish.vo{
	import laya.display.Sprite;
	import laya.display.Animation;

	import game.module.fish.FishConfig;
	import laya.maths.Rectangle;
	import laya.display.Graphics;
	import laya.ui.IBox;
	import laya.maths.Point;
	import laya.ui.Image;
	import laya.events.Event;
	import laya.utils.Tween;
	import laya.filters.ColorFilter;
	import laya.utils.Timer;
	import laya.ui.Label;
	import game.module.fish.FishModel;
	import game.core.model.GlobalConfig;
	import game.module.fish.utils.FishSound;
	import laya.ui.FontClip;

	public class Fish extends Sprite{

		private var _MUIL:int = 1000;

		//死亡标识
		public var _life:Boolean = true;
		//鱼id
		private var _fishID:String = "";
		//鱼类型
		private var _fishType:int = 1;
		//鱼配置
		private var _fishConfig:Object = null;
		//
		private var _bonding_box:Array;
		//鱼动画
		private var _ani:Animation = null;
		//冰冻动画
		private var _aniIce:Animation = null;
		//鱼游动次数
		private var _run_count:int = 0;
		//鱼游动时间
		private var _run_time:Number = 10;
		//路径列表
		private var _curve_lst:Array = [];
		//-1负方向 1正方向
		private var _curve_way:int = 1;
		//鱼初始角度
		private var _curve_angle:Number = 0;
		//鱼初始坐标
		private var _start_pos:Object = {x:0,y:0};
		//鱼
		public var _drawbbx:Boolean = false;
		//鱼最新角度
		private var _cur_angle:int = 0;
		//鱼被锁定准星
		private var _shot_flag:Image = null;
		//鱼分数
		private var _fish_score:int	=0;
		//鱼分数动画的中点坐标
		private var _fish_score_ani:Animation	=null;
		private var _fish_score_ani_pos:Object = {x:0,y:0};
		//鱼暂停
		private var _fish_pause:Boolean = false;
		private var _fish_pause_frame_index:int = 0;
		public function Fish(fInfo:Object){
			super();

			this._fishID = fInfo.id;

			this.x = _start_pos.x=fInfo.x;
			this.y = _start_pos.y=fInfo.y;
			//_fishType = 23;
			_fishType = fInfo.type;
			if(_fishType>23||_fishType<=0){
				_fishType = 1;
			}
			_cur_angle = fInfo.angle;
			rotation = fInfo.angle;
			_curve_angle = fInfo.angle;

			//_fishConfig = clone( FishConfig.FISH_CONFIG[_fishType] );
			_fishConfig = FishConfig.FISH_CONFIG[_fishType];

			_bonding_box = _fishConfig.bonding_box;

			createItems();
			//_curve_lst = fInfo.curve;
			for(var i:int=0;i<fInfo.curve.length;i++){
				addCurve(fInfo.curve[i]);
			}
			_run_time = fInfo.runTime<10?10:fInfo.runTime;

			//trace("   _curve_lst:"+JSON.stringify(_curve_lst));
		}
		private function createItems():void{
			//加载动画文件
			_ani = new Animation();
			_ani.loadAnimation(_fishConfig.res);
			_ani.interval=_fishConfig.aani.interval;
			_ani.play(0,true,_fishConfig.aani.key);
			this.addChild(_ani);

			//被瞄准的准星
			_shot_flag = new Image(FishConfig.BATTERY_CONFIG[1].linea);
			_shot_flag.anchorX = 0.5;
			_shot_flag.anchorY = 0.5;
			_shot_flag.x=0;
			_shot_flag.y=0;
			addChild(_shot_flag);
			_shot_flag.visible = false;

			//冰冻动画
			_aniIce = new Animation();
			_aniIce.loadAnimation(FishConfig.propAction);
			_aniIce.interval=24;
			_aniIce.play(0,true,"ice");
			_aniIce.scale(_fishConfig.ice,_fishConfig.ice);
			_aniIce.visible = false;
			this.addChild(_aniIce);

			//
			if(_drawbbx){
				var bbx:Array = _bonding_box;
				for(var i:int in bbx){
					var bbxinfo:Object = bbx[i];
					if(bbxinfo){
						graphics.drawCircle(bbxinfo.a,bbxinfo.b,bbxinfo.r,"#000000","#ff0400",5)
					}
				}
			}
		}
		// cveinfo = {
		// 	t,
		// 	v,
		// 	ftype,
		// 	fparam = {a,b,c,way,r,k},
		// }
		private function addCurve(cveinfo:Object =null ):void{
			if(cveinfo){
				var item:Object ={
					time: cveinfo.t*_MUIL,
					//time: cveinfo.t,
					speed: cveinfo.speed,
					ftype: cveinfo.ftype,
					fparam: cveinfo.fparam,
					t1:0,						
					t2:0
				};
				//第一段路径的末尾时间作为第二段的起点时间
				if(_curve_lst.length<=0){
					item.t1 =0;
					item.t2 =item.t1+item.time;
					_curve_lst.push(item);
				}else{
					var temp:Object = _curve_lst[_curve_lst.length-1];
					item.t1 = temp.t2;
					item.t2 = item.t1+item.time;
					_curve_lst.push(item);
				}
			}
		}
		public function update():void{

			if(_fish_pause==true){

				_ani.stop();
				_aniIce.visible = true;

				return;
			}
			else{
				_aniIce.visible = false;
			}

			//刷新坐标
			var pos:Object = getPostionByTime(_run_time);
			this.x= pos.x;
			this.y= pos.y;
			
			//刷新角度
			getNewAngle(pos);
			this.rotation = _cur_angle;

			//时间越小越慢 越大越快
			_run_time= _run_time+10;
		}

		//计算角度
		private function getNewAngle(pos:Object):void{
			var angle:int = 0;
			var pos1:Object = getPostionByTime(_run_time+10);
			if(_curve_angle!=0){
				if(pos.x>=pos1.x){
					_curve_way=-1;
				}else{
					_curve_way=1;
				}
			}
			var temp_x:Number = pos1.x-pos.x;
			var temp_y:Number = pos1.y-pos.y;
			if(Math.abs(temp_x)<=0.0000001){
				if(_curve_angle!=0){
					if(pos.y<pos1.y){
						_curve_way=-1;
					}else{
						_curve_way=1;
					}
				}
				if(_curve_way==-1){
					angle=90;
				}else{
					angle=270;
				}
			}else{
				if(_curve_way==-1){
					angle = (360 - Math.atan(temp_y/temp_x)*180/Math.PI);
				}else{
					angle = (180 - Math.atan(temp_y/temp_x)*180/Math.PI);
				}
			}
			_cur_angle = 180-angle;
		}

		//计算坐标
		private function getPostionByTime(dt:Number):Object{

			var pos:Object ={x:0,y:0};

			if(_curve_lst.length<=0){
				return pos;
			}

			_run_count++;
			
			var last_item:Object = _curve_lst[_curve_lst.length-1];
			var time:Number = 0.0;
			var curve_v:Number = 0.0;
			
			//检测鱼是否寿命已到
			if(dt>=last_item.t2){
				_life = false;
				visible  = false;
			}else{
				//遍历路径列表里面的所有路径，通过鱼的已存活时间 dt 和 速度 v获得x， 计算y，累计y ，得到当前时间 x和y的值
				for(var i:int=0;i<_curve_lst.length;i++){
					var item:Object = _curve_lst[i];
					if(dt>=item.t1&&dt<item.t2){
						time = (dt-item.t1);
						curve_v  = item.speed*(time/_MUIL);
						var temp_pos1:Object = getNewPos(item.ftype,{a:item.fparam.a,b:item.fparam.b,c:item.fparam.c,way:item.fparam.way,r:item.fparam.r,k:item.fparam.k,x:curve_v});

						if(temp_pos1.x<0.0000000001){
							_curve_way = -1;
						}else{
							_curve_way = 1;
						}

						pos.x = pos.x+temp_pos1.x;
						pos.y = pos.y+temp_pos1.y;
						
						break;
					}else{
						//累计上一段路径的终点
						time = item.time;
						//对浮点型放大 _MUIL
						curve_v  = item.speed*(time/_MUIL);
						var temp_pos2:Object = getNewPos(item.ftype,{a:item.fparam.a,b:item.fparam.b,c:item.fparam.c,way:item.fparam.way,r:item.fparam.r,k:item.fparam.k,x:curve_v});
						pos.x = pos.x+temp_pos2.x;
						pos.y = pos.y+temp_pos2.y;
					}
				}
			}
			//以上得到增量
			//trace(" fishID:"+this._fishID+" x:"+pos.x+" y:"+pos.y+" curve_v:"+curve_v+" run_time:"+dt);
			//对鱼进行转向 鱼头朝向游动的方向
			if(_curve_angle!=0){
				pos.x = pos.x*Math.cos((_curve_angle/180)*Math.PI) + pos.y*Math.sin((_curve_angle/180)*Math.PI);
				pos.y = pos.y*Math.cos((_curve_angle/180)*Math.PI) - pos.x*Math.sin((_curve_angle/180)*Math.PI);

				//trace(" fishID:"+this._fishID+" x:"+pos.x+" y:"+pos.y+" angle:"+_curve_angle+" run_time:"+dt);
			}
			//trace(" fishID:"+this._fishID+" x:"+pos.x+" y:"+pos.y);
			//得到最终坐标
			pos.x = pos.x + _start_pos.x;
			//pos.y = pos.y + _start_pos.y; 
			//转换为第四象限的坐标系 得出本地坐标
			pos.y = pos.y + _start_pos.y;
			return pos;
		}

		//去浮点
		private function updateNumber(pos:Object):Object{
			var x_s:String = pos.x+"";
			var x_y:String = pos.y+"";
			return {x:parseInt(x_s),y:parseInt(x_y)};
		}

		//通用公式
		private function getNewPos(type:int,param:Object):Object{

			var pos:Object = {x:param.x,y:0};
			switch(type){
				//抛物线
				case 1:{
					pos.y=param.a * Math.pow(param.x, 2) + param.b * param.x + param.c;
				}break;
				//三次曲线
				case 2:{
					pos.y=param.a * Math.pow(param.x, 3);
				}break;
				//指数函数
				case 3:{
					pos.y=Math.pow(param.a, param.x);
				}break;
				//对数函数
				case 4:{
					pos.y=param.a*Math.log(param.x);
				}break;
				//正弦曲线
				case 5:{
					pos.y=param.a*Math.sin(param.b*param.x);
				}break;
				
				//余弦曲线
				case 6:{
					pos.y=param.a * Math.cos(param.b * param.x);
				}break;
				//圆
				case 7:{
					if(param.way == 1){
						pos.y = Math.sqrt(Math.pow(param.r, 2) - Math.pow(param.x + param.a, 2)) - param.b;
					}else{
						pos.y = -Math.sqrt(Math.pow(param.r, 2) - Math.pow(param.x + param.a, 2)) - param.b;
					}
				}break;
				//直线
				case 8:{
						pos.y = param.k * param.x;
				}break;
				default:{
					pos.y=0;
				}break;
			}
			//pos = updateNumber({x:pos.x*_MUIL,y:pos.y*_MUIL});
			return pos;
		}
		public function death():void{
			//删除锁定标识
			if(_shot_flag){
				_shot_flag.visible = false;
				_shot_flag.removeSelf();
			}

			//跑鱼的死亡动画，播放完成将_ani置空 如果没有播放完 后面 再删除
			if(_ani){
				_ani.stop();

				_ani.interval = _fishConfig.dani.interval;
				var count:int = 0;
				_ani.play(0,true,_fishConfig.dani.key);
				_ani.on(Event.COMPLETE, this, function ():void{
					count++;
					if(_fishConfig.dani.loop>count){
						_ani.play(0,false,_fishConfig.dani.key);
					}else{
						_ani.visible = false;
						_ani.removeSelf();
						_ani = null;
					}
				});
			}
			//打死鱼后的分数特效
			runScoreAni();
		}
		public function runScoreAni():void{
			var parent:Object = this.parent;

			//创建金币动画
			var golds:Array =[];
			//根据分数的位数获得金币动画个数
			var count:int =get_length(_fish_score);
			for(var index:int =1;index<=5;index++){
				var img:Animation = new Animation();
				img.loadAnimation("Ani/aniGold.ani");
				img.x=x+90*index-count*45;
				img.y=y+70*2;
				img.interval = 24;
				img.play(0,true,"ani1");
				parent.addChild(img);
				golds.push(img);
			}

			//创建分数字
			// var label:Label = new Label();
			// label.font = "Arial";
			// label.text = _fish_score+"";
			// label.fontSize = 70;
			// label.color = "#FFFF00";
			// label.stroke = 2;
			// label.strokeColor = "#000000";

			// label.anchorX =0.5;
			// label.anchorY = 0.5;
			// parent.addChild(label);
			var label:FontClip = new FontClip(FishConfig.getNumPic("gold"),"+-0123456789");
			label.value = _fish_score+"";
			label.anchorX =0.5;
			label.anchorY = 0.5;
			label.x = x;
			label.y = y+100*2;
			parent.addChild(label);

			if(FishModel.instance.sceneRotation){
				label.rotation = 180;
			}

			//隔70帧后 删除分数字 
			frameOnce(70,this,function():void{
				label.visible = false;
				label.removeSelf();
				//鱼动画没有删除 将其删除
				if(null!=_ani){
					_ani.stop();
					_ani.removeSelf();
				}

				//飞金币动画 
				var time:int = 0;
				for(var i:int in  golds){
					var gold:Object = golds[i];
					if(gold){
						time = i*50+500;
						Tween.to(gold, {x:_fish_score_ani_pos.x,y:_fish_score_ani_pos.y},time);
					}
				}
				//飞金币动画 完成后 删除 所有
				timerOnce(time,this,function():void{
					//删除 金币动画
					for(var m:int in  golds){
						var goldm:Object = golds[m];
						if(goldm){
							goldm.removeSelf();
						}
					}
					removeSelf();
				});
				
			});
			FishSound.effect("fly.mp3");
		}
		//获得整数的位数
		public function get_length(num:int):int{  
			var leng:int=5;  
			// while(num>0)  
			// {  
			// 	num=Math.floor(Math.floor(num)/10);  
			// 	leng++;  
			// }  
			return leng;  
		}  
		public function get shotflag():Image{
			return _shot_flag;
		}
		public function get fishID():String{
			return _fishID;
		}
		public function get fishType():int{
			return _fishType;
		}
		public function set fishScore(score:int):void{
			_fish_score = score;
		}
		public function get fishScore():int{
			return _fish_score;
		}
		public function set fishScoreAniPos(pos:Object):void{
			_fish_score_ani_pos = pos;
		}
		public function get fishScoreAniPos():Object{
			return _fish_score_ani_pos;
		}
		public function set fishPause(pause:Boolean):void{
			if(true==pause){
				pauseAni();
			}

			if(true==_fish_pause&&pause==false){
				resumeAni();
			}

			_fish_pause = pause;
		}
		public function get fishPause():Boolean{
			return _fish_pause;
		}
		public function get  BBX():Array{
			var point:Point = new Point(0,0);
			var bbx:Array = [];
			for(var i:int in _bonding_box){
				var bod:Object = _bonding_box[i];
				if(bod){
					var angle:int = rotation+180;
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
		public function get lockPos():Object{
			var point:Point = new Point(_shot_flag.x,_shot_flag.y);
			localToGlobal(point);
			if(FishModel.instance.sceneRotation){
				point.x =FishConfig.GAME_WIDTH - point.x;
				point.y =FishConfig.GAME_HEIGHT - point.y;
			}
			return {x:point.x,y:point.y};
		}
		public function isCatched(bbx:Array):Boolean{
			var point:Point = new Point(0,0);
			for(var i:int in bbx){
				var bbxI:Object = bbx[i];
				if(bbxI){
					for(var x:int in _bonding_box){
						var fbbx:Object = _bonding_box[x];
						if(fbbx){
							point.x = fbbx.a;
							point.y = fbbx.b;
							localToGlobal(point);
							if(FishModel.instance.sceneRotation){
								point.x =FishConfig.GAME_WIDTH - point.x;
								point.y =FishConfig.GAME_HEIGHT - point.y;
							}
							var dis:int =Math.floor( Math.sqrt(Math.pow(point.x - bbxI.a,2) + Math.pow(point.y - bbxI.b,2)));
							if(bbxI.r+fbbx.r>=dis){
								beenShot();
								return true;
							}
						}
					}
				}
			}
			return false;
		}
		public function beenShot():void{
			//被击中
			makeRedApe();
			frameOnce(10,this,function():void{
				this.filters = [];
			})
		}

		public function pauseAni():void{
			_ani.stop();
			_fish_pause_frame_index = _ani.index;
		}
		public function resumeAni():void{
			_ani.play(_fish_pause_frame_index,true,_fishConfig.aani.key);
		}
		private function makeRedApe():void
		{
			//由 20 个项目（排列成 4 x 5 矩阵）组成的数组，红色
			var redMat:Array = 
				[
					1, 0, 0, 0, 0, //R
					0, 0, 0, 0, 0, //G
					0, 0, 0, 0, 0, //B
					0, 0, 0, 1, 0, //A
				];

			//创建一个颜色滤镜对象,红色
			var redFilter:ColorFilter = new ColorFilter(redMat);

			this.filters = [redFilter];
		}
		private function clone(obj) {
			var o;
			if (typeof obj == "object") {
				if (obj === null) {
					o = null;
				} else {
					if (obj instanceof Array) {
						o = [];
						for (var i = 0, len = obj.length; i < len; i++) {
							o.push(clone(obj[i]));
						}
					} else {
						o = {};
						for (var j in obj) {
							o[j] = clone(obj[j]);
						}
					}
				}
			} else {
				o = obj;
			}
			return o;
		}
	}
}