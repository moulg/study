package game.module.hall.utils{
	
	import game.core.manager.AudioManager;
	import game.core.manager.EffectManager;
	import game.module.hall.HallConfig;
	
	import laya.display.Animation;
	import laya.display.Sprite;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.utils.Handler;
	import laya.utils.Tween;

	/**
	 * liuhe
	 */
	public class HallUtil{

		private static var attAlertBox:Box;
		private static var attAlertText:Label;
		
		/**
		 * 放大缩小
		 * @param evenObj 需要放大或缩小的对象
		 * @param eventBoo 是否放大（Boolean型）
		 */
		public static function EventMOUSE(evenObj:Sprite,eventBoo:Boolean):void{
			if(eventBoo){
				evenObj.scaleX=1.08;
				evenObj.scaleY=1.08;
			}else{
				evenObj.scaleX=1;
				evenObj.scaleY=1;
			}
		}

		/**
		 * 隐藏信息
		 * @param str 字符串
		 * @param frontLen 前面保留位数(默认为0)
		 * @param endLen 后面保留位数(默认为0)
		 */
		public static function Secrecy(str:String,frontLen:int=0,endLen:int=0):String{
			var len:int = str.length-frontLen-endLen;
			var xing:String="";
			for (var i:int = 0; i < len; i++){
				xing+="*";
			}
			return str.substring(0,frontLen)+xing+str.substring(str.length-endLen);
		}
		/**
		 * 身份证验证
		 * @param str 需要验证的身份证号
		 * 返回Boolean型
		 */
		public static function IdentityCodeValid(str:String):Boolean{
			var city:Object={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
			var tip:String = "";
			var pass:Boolean= true;
			var reg:RegExp=/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i;

			if(!str || !reg.test(str)){
				tip = "身份证号格式错误";
				pass = false;
			}else if(!city[str.substr(0,2)]){
				tip = "地址编码错误";
				pass = false;
			}else{
				//18位身份证需要验证最后一位校验位
				if(str.length == 18){
					var strArr:Array = str.split('');
					//∑(ai×Wi)(mod 11)
					//加权因子
					var factor:Array = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
					//校验位
					var parity:Array = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
					var sum:int = 0;
					var ai:int = 0;
					var wi:int = 0;
					for (var i:int = 0; i < 17; i++){
						ai = strArr[i];
						wi = factor[i];
						sum += ai * wi;
					}
					var last:int = parity[sum % 11];
					if(parity[sum % 11] != strArr[17]){
						tip = "校验位错误";
						pass =false;
					}
				}
			}
			return pass;
		}
		
		/**
		 * 播放大撒金币效果
		 * @param str 需要验证的身份证号
		 */
		public static function aniReward(_this:*):void{
			if(!attAlertBox){
				attAlertBox=new Box;
				attAlertBox.centerX=0;
				var img:Image=new Image();
				img.skin="res/hall/attendance/attAlert.png";
				var tex:Label=new Label();
				tex.color="#FFFFFF";
				tex.font="Microsoft YaHei";
				tex.fontSize=32;
				tex.y=18;
				tex.centerX=0;
				attAlertBox.addChild(img);
				attAlertBox.addChild(tex);
				_this.addChild(attAlertBox);
			}
			attAlertBox.centerY=113;
			attAlertBox.visible=false;
			HallUtil.attAlertBox._childs[1].text="获取1000金币";
			var signAni:Animation;
			EffectManager.getAni(HallConfig.getAniUrl("signImg"),Handler.create(_this,function(ani:Animation):void{
				signAni=ani;
				signAni.interval = 100;
				signAni.x-=_this.x;
				signAni.y-=_this.y;
				signAni.play(0,true);
				_this.addChild(signAni);
			}));
			/**停止背景音乐，播放签到音乐**/
			AudioManager.stopMusic();
			HallSound.sign();
			/**定时器关闭**/
			Laya.timer.once(1000,_this,function():void{
				/****播放音乐，停止金币效果*****/
				AudioManager.replayMusic();
				signAni&&signAni.destroy();
				attAlertBox.visible = true;
				Tween.to(attAlertBox,{centerY:0,alpha:1},150,null,Handler.create(this,function():void{
					Tween.to(attAlertBox,{centerY:-113,alpha:0},150,null,Handler.create(this,function():void{
//						attAlertBox&&attAlertBox.destroy();
						attAlertBox.visible=false;
					}),700);
				}));
			});
		}
		

	}
}