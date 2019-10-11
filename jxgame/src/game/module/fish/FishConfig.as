package game.module.fish{
	
	import game.core.model.GlobalConfig;
	
	import laya.net.Loader;

	/**
	 * chenyuan
	 */
	public class FishConfig{
		/**捕鱼游戏的宽**/
		public static function get GAME_WIDTH():int{
			return 1920;
		}
		/**捕鱼游戏的高**/
		public static function get GAME_HEIGHT():int{
			return 1080;
		}
		
		/**初始化资源**/
		public static const INIT_SKINS:Array = [
			{url:"res/fish/image/bg1.jpg",type:Loader.IMAGE},{url:"res/fish/image/bg2.jpg",type:Loader.IMAGE},
			{url:"res/fish/image/bg3.jpg",type:Loader.IMAGE},{url:"res/fish/image/bg4.jpg",type:Loader.IMAGE},
			{url:"res/fish/image/bg5.jpg",type:Loader.IMAGE},{url:"res/fish/image/bg6.jpg",type:Loader.IMAGE},
			{url:"res/fish/res/res03.json",type:Loader.ATLAS}, {url:"res/fish/res/res16.json",type:Loader.ATLAS}, 
			{url:"res/fish/res/res04.json",type:Loader.ATLAS},{url:"res/fish/res/res05.json",type:Loader.ATLAS}, 
			{url:"res/fish/res/res06.json",type:Loader.ATLAS},{url:"res/fish/res/res07.json",type:Loader.ATLAS}, 
			{url:"res/fish/res/res08.json",type:Loader.ATLAS}, {url:"res/fish/res/res09.json",type:Loader.ATLAS}, 
			{url:"res/fish/res/res10.json",type:Loader.ATLAS}, {url:"res/fish/res/res11.json",type:Loader.ATLAS},
			{url:"res/fish/res/res12.json",type:Loader.ATLAS}, {url:"res/fish/res/res13.json",type:Loader.ATLAS}, 
			{url:"res/fish/res/res14.json",type:Loader.ATLAS}, {url:"res/fish/res/res15.json",type:Loader.ATLAS}, 
			{url:"res/fish/battery.json",type:Loader.ATLAS}, {url:"res/fish/textures.json",type:Loader.ATLAS},
			{url:"res/fish/bullet.json",type:Loader.ATLAS},{url:"res/fish/net.json",type:Loader.ATLAS},
			{url:"res/fish/room.json",type:Loader.ATLAS},{url:"res/fish/gold.json",type:Loader.ATLAS},
			{url:"res/fish/here.json",type:Loader.ATLAS},{url:"res/fish/lock.json",type:Loader.ATLAS},
			{url:"res/fish/btnLight.json",type:Loader.ATLAS},{url:"res/fish/spine/chongzhi/chongzhi.png",type:Loader.IMAGE},
			{url:"res/fish/spine/baofula.png",type:Loader.IMAGE},{url:"res/fish/spine/nizhenniu.png",type:Loader.IMAGE},
			{url:"res/fish/spine/taibangle.png",type:Loader.IMAGE},{url:"res/fish/spine/zhuanfanla.png",type:Loader.IMAGE},
			{url:"res/fish/waterWave.json",type:Loader.ATLAS},{url:"res/fish/prop/ice.json",type:Loader.ATLAS},
			{url:"res/fish/prop/bom.json",type:Loader.ATLAS},{url:"res/fish/prop/flash.json",type:Loader.ATLAS},
			{url:"res/fish/bubble.json",type:Loader.ATLAS},{url:"res/fish/weave.json",type:Loader.ATLAS},

			{url:"Ani/aniFish.ani",type:Loader.JSON},{url:"Ani/aniScene.ani",type:Loader.JSON},
			{url:"Ani/aniNet.ani",type:Loader.JSON},{url:"Ani/aniBullet.ani",type:Loader.JSON},
			{url:"Ani/aniGold.ani",type:Loader.JSON},{url:"Ani/aniRunLight.ani",type:Loader.JSON},
			{url:"Ani/aniWaterWave.ani",type:Loader.JSON},{url:"Ani/aniProp.ani",type:Loader.JSON},
		];

		/**获取房间资源**/
		public static function getRoomNameUrl(index:int):String{
			return "res/fish/room/num"+index+".png";
		}
		/**获取房间资源**/
		public static function getRoomIconUrl(index:int):String{
			return "res/fish/room/icon"+index+".png";
		}
		/**获取房间资源**/
		public static function getRoomStrokeColor(index:int):String{
			var stroke:Array = ['#1c5914','#5d308f','#865804'];
			return stroke[index]||'';
		}
		
		/**获取音效路径**/
		public static function getSoundUrl(name:String):String{
			return "res/fish/sound/"+name;
		}
		/**获取背景路径**/
		public static function getBgSoundUrl(name:int):String{
			return "res/fish/sound/bg"+name+".mp3";
		}
		/**入场提示动画**/
		public static function get sceneAni():String{
			return "Ani/aniScene.ani";
		}
		/**水纹动画**/
		public static function get waterWave():String{
			return "Ani/aniWaterWave.ani";
		}
		/**按钮走光动画**/
		public static function get runLight():String{
			return "Ani/aniRunLight.ani";
		}
		/**核弹资源**/
		public static function get bomUrl():String{
			return "res/fish/textures/hedan.png";
		}
		/**道具动画**/
		public static function get propAction():String{
			return "Ani/aniProp.ani";
		}
		/**数字图片资源**/
		public static function getNumPic(idnex:String):String{
			var url:Object = {gold:"res/fish/textures/goldnum.png",
							  tip:"res/fish/spine/nizhenniu.json"};
			return url[idnex];
		}
		/**Spine动画**/
		public static function getSpineAni(idnex:int):String{
			var url:Object = {0:"res/fish/spine/chongzhi.json",
							  1:"res/fish/spine/nizhenniu.json",
						  	  2:"res/fish/spine/taibangle.json",
							  3:"res/fish/spine/zhuanfanla.json",
							  4:"res/fish/spine/baofula.json"};
			return url[idnex];
		}
		/**炮管资源路径**/
		public static function getBatteryPipUrl(index:int):String{
			var url:Object = {1:"res/fish/battery/bow2_1.png",
							  2:"res/fish/battery/bow2_1.png",
							  3:"res/fish/battery/bow2_1.png",
							  4:"res/fish/battery/bow2_1.png",
							  5:"res/fish/battery/bow2_2.png",
							  6:"res/fish/battery/bow2_2.png",
							  7:"res/fish/battery/bow2_2.png",
							  8:"res/fish/battery/bow2_3.png",
							  9:"res/fish/battery/bow2_3.png",
							  10:"res/fish/battery/bow2_3.png"};
			return url[index];
		}
		/**炮台资源路径**/
		public static function getBatteryUrl(index:int):String{
			var url:Object = {1:"res/fish/battery/bow1_1.png",
							  2:"res/fish/battery/bow1_1.png",
							  3:"res/fish/battery/bow1_1.png",
							  4:"res/fish/battery/bow1_1.png",
							  5:"res/fish/battery/bow1_2.png",
							  6:"res/fish/battery/bow1_2.png",
							  7:"res/fish/battery/bow1_2.png",
							  8:"res/fish/battery/bow1_3.png",
							  9:"res/fish/battery/bow1_3.png",
							  10:"res/fish/battery/bow1_3.png"};
			return url[index];
		}
		/**炮台资源路径**/
		public static function getBatterySound(index:int):String{
			var url:Object = {1:"bulFire.mp3",
							  2:"bulFire.mp3",
							  3:"bulFire.mp3",
							  4:"bulFire.mp3",
							  5:"bulEff.mp3",
							  6:"bulEff.mp3",
							  7:"bulEff.mp3",
							  8:"bulFla.mp3",
							  9:"bulFla.mp3",
							  10:"bulFla.mp3"};
			return url[index];
		}
		/**渔网动画路径**/
		public static function get fishNetUrl():String{
			return "Ani/aniNet.ani";
		}
		public static function getFishNetName(index:int):String{
			var url:Object = {1:"net1_1",
							  2:"net1_1",
							  3:"net1_1",
							  4:"net1_1",
							  5:"net2_1",
							  6:"net2_1",
							  7:"net2_1",
							  8:"net3_1",
							  9:"net3_1",
							  10:"net3_1"};
			return url[index];
		}
		/**子弹动画路径**/
		public static function get bulletUrl():String{
			return "Ani/aniBullet.ani";
		}
		public static function getBulletName(index:int):String{
			var url:Object = {1:"ani1",
							  2:"ani1",
							  3:"ani1",
							  4:"ani1",
							  5:"ani2",
							  6:"ani2",
							  7:"ani2",
							  8:"ani3",
							  9:"ani3",
							  10:"ani3"};
			return url[index];
		}
		public static function getBulletNum(index:int):int{
			var url:Object = {1:1,
							  2:1,
							  3:1,
							  4:1,
							  5:2,
							  6:2,
							  7:2,
							  8:3,
							  9:3,
							  10:3};
			return url[index];
		}
		public static const SCENE_CONFIG:Object = {
			1:{id:1,res:"res/fish/image/bg%d.jpg"},
			2:{id:2,res:"res/fish/image/bg%d.jpg"},
			3:{id:3,res:"res/fish/image/bg%d.jpg"},
			4:{id:4,res:"res/fish/image/bg%d.jpg"},
			5:{id:5,res:"res/fish/image/bg%d.jpg"},
			6:{id:6,res:"res/fish/image/bg%d.jpg"}
		};

		/*鱼配置**/
		/*
		*type 鱼类型
		*desc 鱼名称 
		*anni/dani 游动动画 {interval 帧数 loop 循环次数 -1 一直循环 >=0 循环次数}
		*size 鱼有效范围
		*bonding_box 碰撞范围 {r 半径 。。。}
		*/
		public static const FISH_CONFIG:Object = {
			1:{type:1, desc:"泥鳅",		 res:"Ani/aniFish.ani",	  aani:{key:"fish1_1",interval:128,loop:-1},	 dani:{key:"fish1_2",interval:128,loop:10},		ice:0.5,		bonding_box:[{r:16,a:0,b:0}]},
			2:{type:2, desc:"蝴蝶鱼",	    res:"Ani/aniFish.ani",	 aani:{key:"fish2_1",interval:152,loop:-1},		dani:{key:"fish2_2",interval:24,loop:10},	   ice:0.6,	   	   bonding_box:[{r:30,a:0,b:0}]},
			3:{type:3, desc:"小丑鱼", 	    res:"Ani/aniFish.ani",	 aani:{key:"fish3_1",interval:64,loop:-1},		dani:{key:"fish3_2",interval:100,loop:10},	   ice:0.9,		   bonding_box:[{r:55,a:0,b:0}]},
			4:{type:4, desc:"河豚",   	 res:"Ani/aniFish.ani",	  aani:{key:"fish4_1",interval:256,loop:-1},	 dani:{key:"fish4_2",interval:23,loop:10},	    ice:0.6,		bonding_box:[{r:30,a:0,b:0}]},
			5:{type:5, desc:"大眼鱼",  	res:"Ani/aniFish.ani",	 aani:{key:"fish5_1",interval:133,loop:-1},		dani:{key:"fish5_2",interval:16,loop:10},	   ice:0.9,		   bonding_box:[{r:35,a:0,b:0}]},
			6:{type:6, desc:"花斑鱼",  	res:"Ani/aniFish.ani",	 aani:{key:"fish6_1",interval:152,loop:-1},		dani:{key:"fish6_2",interval:16,loop:10},	   ice:0.9,		   bonding_box:[{r:40,a:0,b:0}]},
			7:{type:7, desc:"海马",    	 res:"Ani/aniFish.ani",	  aani:{key:"fish7_1",interval:152,loop:-1},	 dani:{key:"fish7_2",interval:16,loop:10},	    ice:0.9,		bonding_box:[{r:30,a:0,b:0}]},
			8:{type:8, desc:"青蛙",    	 res:"Ani/aniFish.ani",	  aani:{key:"fish8_1",interval:152,loop:-1},	 dani:{key:"fish8_2",interval:16,loop:10},	    ice:0.9,		bonding_box:[{r:54,a:0,b:0}]},
			9:{type:9, desc:"乌龟",    	 res:"Ani/aniFish.ani",	  aani:{key:"fish9_1",interval:64,loop:-1},	 	 dani:{key:"fish9_2",interval:30,loop:10},	    ice:1.5,		bonding_box:[{r:67,a:0,b:0}]},
			10:{type:10,desc:"虾",     	  res:"Ani/aniFish.ani",   aani:{key:"fish10_1",interval:25,loop:-1},	  dani:{key:"fish10_2",interval:25,loop:10},	 ice:1.0,		 bonding_box:[{r:45,a:0,b:0}]},
			11:{type:11,desc:"草鱼",   	 res:"Ani/aniFish.ani",	  aani:{key:"fish11_1",interval:190,loop:-1},	 dani:{key:"fish11_2",interval:24,loop:10},	 	ice:1.5,		bonding_box:[{r:40,a:-40,b:0},{r:50,a:58,b:0}]},
			12:{type:12,desc:"金龙",    	 res:"Ani/aniFish.ani",	  aani:{key:"fish12_1",interval:112,loop:-1},	 dani:{key:"fish12_2",interval:210,loop:1},	 	ice:2.2,		bonding_box:[{r:80,a:55,b:0},{r:30,a:-80,b:0}]},
			13:{type:13,desc:"银龙",   	 res:"Ani/aniFish.ani",	  aani:{key:"fish13_1",interval:112,loop:-1},	 dani:{key:"fish13_2",interval:210,loop:1},	 	ice:2.2,		bonding_box:[{r:30,a:130,b:0},{r:80,a:0,b:0},{r:30,a:-130,b:0}]},
			14:{type:14,desc:"尖嘴鱼",  	res:"Ani/aniFish.ani",	 aani:{key:"fish14_1",interval:152,loop:-1},	dani:{key:"fish14_2",interval:8,loop:10},	   ice:2.2,		   bonding_box:[{r:40,a:127,b:5},{r:55,a:22,b:0},{r:40,a:-78,b:-1}]},
			15:{type:15,desc:"蝙蝠鱼", 	res:"Ani/aniFish.ani",	 aani:{key:"fish15_1",interval:285,loop:-1},	dani:{key:"fish15_2",interval:27,loop:10},	   ice:2.2,		   bonding_box:[{r:85,a:53,b:0},{r:35,a:-80,b:0}]},
			16:{type:16,desc:"小海豚",  	res:"Ani/aniFish.ani",	 aani:{key:"fish16_1",interval:152,loop:-1},	dani:{key:"fish16_2",interval:30,loop:10},	   ice:3.0,		   bonding_box:[{r:110,a:-122,b:-10},{r:130,a:130,b:0}]},
			17:{type:17,desc:"大白鲨",  	res:"Ani/aniFish.ani",	 aani:{key:"fish17_1",interval:152,loop:-1},	dani:{key:"fish17_2",interval:19,loop:10},	   ice:3.0,		   bonding_box:[{r:110,a:110,b:0},{r:80,a:-70,b:0}]},
			18:{type:18,desc:"美人鱼",  	res:"Ani/aniFish.ani",	 aani:{key:"fish18_1",interval:300,loop:-1},	dani:{key:"fish18_2",interval:80,loop:10},	   ice:3.0,		   bonding_box:[{r:110,a:110,b:0},{r:80,a:-70,b:0}]},
			19:{type:19,desc:"金蟾",    	 res:"Ani/aniFish.ani",	  aani:{key:"fish19_1",interval:340,loop:-1},	 dani:{key:"fish19_2",interval:24,loop:5},	    ice:3.0,		bonding_box:[{r:125,a:0,b:0}]},
			20:{type:20,desc:"黄金鱼",  	res:"Ani/aniFish.ani",	 aani:{key:"fish20_1",interval:285,loop:-1},	dani:{key:"fish20_2",interval:8,loop:10},	   ice:3.3,		   bonding_box:[{r:160,a:120,b:0},{r:120,a:-150,b:0}]},
			21:{type:21,desc:"全屏炸弹",   res:"Ani/aniFish.ani",	aani:{key:"fish21_1",interval:345,loop:-1},	   dani:{key:"fish21_2",interval:80,loop:1},	  ice:3.3,		  bonding_box:[{r:160,a:120,b:0},{r:120,a:-150,b:0}]},
			22:{type:22,desc:"绿草鱼",   	res:"Ani/aniFish.ani",	 aani:{key:"fish22_1",interval:345,loop:-1},	dani:{key:"fish22_2",interval:120,loop:10},	   ice:2.0,		   bonding_box:[{r:80,a:0,b:0}]},
			23:{type:23,desc:"J币",		  res:"Ani/aniFish.ani",   aani:{key:"fish23_1",interval:180,loop:-1},	  dani:{key:"fish23_2",interval:24,loop:5},	     ice:2.0,		 bonding_box:[{r:100,a:0,b:0}]}
		};
		/*炮台配置**/
		/*
		*id 炮台编号
		*desc 炮台描述
		*speed 炮台动画速度和子弹发射速度
		*music_eff 发炮音效
		*angle 炮台旋转角度
		*pos 炮台位置
		*/
		public static const BATTERY_CONFIG:Object = {
			1:{id:1,	res:["res/fish/battery/paozuo.png","res/fish/battery/goldflat.png","res/fish/battery/dda.png","res/fish/battery/add.png","res/fish/battery/waitEnter.png"],	music_eff:{1:"",2:""},	 fangle:90,		bangle:180, 	bgangle:180,	pos:{x:1493,y:81},		scorepos:{x:1493+300,y:81},		linea:"res/fish/lock/lock_1.png",	line:"res/fish/lock/lock_1_1.png"},
			2:{id:2,	res:["res/fish/battery/paozuo.png","res/fish/battery/goldflat.png","res/fish/battery/dda.png","res/fish/battery/add.png","res/fish/battery/waitEnter.png"],	music_eff:{1:"",2:""},	 fangle:90, 	bangle:180, 	bgangle:180,	pos:{x:422,y:81},		scorepos:{x:422+300,y:81},		linea:"res/fish/lock/lock_2.png",	line:"res/fish/lock/lock_2_1.png"},
			3:{id:3,	res:["res/fish/battery/paozuo.png","res/fish/battery/goldflat.png","res/fish/battery/dda.png","res/fish/battery/add.png","res/fish/battery/waitEnter.png"],	music_eff:{1:"",2:""},	 fangle:90,		bangle:0,		bgangle:0,		pos:{x:1493,y:1003},	scorepos:{x:1493,y:1003},		linea:"res/fish/lock/lock_3.png",	line:"res/fish/lock/lock_3_1.png"},
			4:{id:4,	res:["res/fish/battery/paozuo.png","res/fish/battery/goldflat.png","res/fish/battery/dda.png","res/fish/battery/add.png","res/fish/battery/waitEnter.png"],	music_eff:{1:"",2:""},	 fangle:90,		bangle:0,		bgangle:0,		pos:{x:422,y:1003},		scorepos:{x:422,y:1003},		linea:"res/fish/lock/lock_4.png",	line:"res/fish/lock/lock_4_1.png"}
		};	

		/*子弹配置
		*
		*/
		public static const BULLET_CONFIG:Object = {
			1:{bul:"aniBullet.ani",anet:"aniNet.ani"}
		};
		public static const PROP_CONFIG:Object = {
			//"by01":{stime:5},
			//"by02":{name:"火焰",anet:"aniNet.ani"},
			//"by03":{name:"火焰",anet:"aniNet.ani"},
		};
	}
}