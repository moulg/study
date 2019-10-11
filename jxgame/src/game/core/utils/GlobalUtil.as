package game.core.utils{
	
	import game.core.manager.ExternalManager;
	import game.core.model.GlobalConfig;
	import game.core.ui.Toast;
	
	import laya.display.Node;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.utils.Browser;
	import laya.utils.Utils;

	/**
	 * chenyuan
	 */
	public class GlobalUtil{
		
		private static var _stagePos:Point;
		/*******游戏中暂存的粘贴板*********/
		public static var coyText:String;
		/*******粘贴板使用的输入框*******/
		private static var textarea:*;
		/*******DOM浮出点击容器*******/
		private static var buttonContainer:*;
		/*******button数据存储*******/
		private static var buttonContainerArr:Array=[];
		
		/**获取舞台中心点**/
		public static function get stagePos():Point{
			if(!_stagePos) _stagePos=new Point(GlobalConfig.GAME_WIDTH>>1,GlobalConfig.GAME_HEIGHT>>1);
			return _stagePos;
		}
		
		/**获取单位数字**/
		public static function getShortNum(num:Number):String{
			if(Lang.isEn){
				if(num>=100000000){
					return Number(Math.floor(num/1000000)/100).toFixed(2)+Lang.text("yi");
				}else if(num>=1000){
					return Number(Math.floor(num/10)/100).toFixed(2)+Lang.text("wan");
				}
			}else{
				if(num>=100000000){
					return Number(Math.floor(num/1000000)/100).toFixed(2)+Lang.text("yi");
				}else if(num>=10000){
					return Number(Math.floor(num/100)/100).toFixed(2)+Lang.text("wan");
				}
			}
			return num.toString();
		}
		
		/**系列化**/
		public static function serialize(vo:*,data:Object):*{
			if(!vo||!data) return null;
			for(var key:* in data){
				if(vo.hasOwnProperty(key)){
					vo[key] = data[key];
				}
			}
			return vo;
		}
		
		/**系列化**/
		public static function serializeByClass(voClass:Class,data:Object):*{
			return serialize(new voClass(),data);
		}
		
		/**合并对象**/
		public static function mergeObject(target:Object,data:Object):*{
			if(data){
				if(!target) target={};
				for(var key:String in data){
					target[key] = data[key];
				}
			}
			return target;
		}
		
		/**获取随机范围小数**/
		public static function random(max:int,min:int=0):int{
			var val:int = Math.random()*(max-min)+min;
			return val;
		}
		
		/**获取随机范围整数**/
		public static function randomInt(max:int,min:int=0):int{
			return Math.round(random(max,min));
		}
		
		/**获取随机布尔值**/
		public static function randomBoolean():Boolean{
			return Math.random()>0.5;
		}
		
		/**获取随机范围数组**/
		public static function randomArray(len:int,max:int,min:int=0):Array{
			var arr:Array = [];
			for(var i:int=0;i<len;i++){
				arr.push(randomInt(max,min));
			}
			return arr;
		}
		
		/**获取随机颜色**/
		public static function randomColor(r:int=-1,g:int=-1,b:int=-1):String{
			var arr:Array = [r,g,b];
			for(var i:int=0;i<3;i++){
				var num:int = arr[i];
				if(num<0){
					num = randomInt(255);
				}else if(num>255){
					num = 255;
				}
				var str:String = num.toString(16);
				if(str.length==1) str="0"+str;
				arr[i] = str;
			}
			return "#"+arr.join("").toUpperCase();
		}
		
		/**数组乱序**/
		public static function upsetArray(arr:Array):Array{
			arr.sort(function(a:int,b:int):int{
				return randomBoolean()?1:-1;
			});
			return arr;
		}
		
		/**计算两点的距离**/
		public static function distance(x1:Number,y1:Number,x2:Number,y2:Number):Number{
			return Math.sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
		}
		
		/**设置字符串颜色**/
		public static function getColorHtml(value:String,color:String):String{
			return '<span style="color:'+color+';">'+value+'</span>';
		}
		
		/**判断是否空对象**/
		public static function hasEmptyObject(obj:Object):Boolean{
			if(obj) for(var k:String in obj) return false;
			return true;
		}
		
		/**获取URL参数**/
		public static function getUrlParames():Object{
			var str:String = Browser.window.location.search;
			if(!str) return null;
			var obj:Object = {};
			var reg:RegExp = new RegExp(/([^?=|^&=]+)=?([^&]*)/g);
			while(true){
				var arr:Object = reg.exec(str);
				if(!arr) break;
				obj[arr[1]]=arr[2];
			}
			return obj;
		}
		
		/**获取当前时间字符**/
		public static function nowTimeStr(isDate:Boolean=false):String{
			var t:Date = new Date();
			var arr:Array = isDate?[t.getFullYear(),"-",t.getMonth()+1,"-",t.getDate()," "]:[];
			arr = arr.concat([t.getHours(),":",t.getMinutes(),":",t.getSeconds(),".",t.getMilliseconds()]);
			var len:int = arr.length;
			for(var i:int=0;i<len;i++){
				var v:int = parseInt(arr[i]);
				if(!isNaN(v)){
					if(i==len-1){
						if(v<10){
							arr[i]="00"+v;
						}else if(v<100){
							arr[i]="0"+v;
						}
					}else{
						if(v<10) arr[i]="0"+v;
					}
				}
			}
			return arr.join("");
		}
		
		
		/** 转换金币显示*/
		public static function goldToString(gold:int):String{
			if(!gold) return "0";
			var memory:String = gold+"" ;
			var str1:String = "";
			while(memory.length){
				if(memory.length <= 3){
					var s:String = "";
					str1 =  s.concat(memory,str1);
					memory = "" ;
				}else{
					s = "" ;
					str1 =  s.concat("." + memory.slice(memory.length-3,memory.length),str1) ;
					memory = memory.slice(0,memory.length-3) ;
				}		
			}
			return str1 ;
		}
		/**
		 * 复制到粘贴板和存到内存字符串
		 * @param str 复制到粘贴板和游戏内存的字符串
		 */	
		public static function clipboard(str:String):void{
			coyText=str;
			if(!textarea){
				textarea =Browser.document.createElement("textarea");
				Browser.document.body.appendChild(textarea);
				textarea.setAttribute('readonly', '');
				textarea.style="position: fixed;left: 100%;";
			}
			textarea.value = str;
			textarea.select();
			textarea.setSelectionRange(0, textarea.value.length);
			if(Browser.document.execCommand("Copy")){
				Toast.success("复制成功");
			}else{
				trace("不支持复制到粘贴板功能");
			}
		}
		
		/**
		 * 删除遮盖的点击事件
		 * @param _this laya中节点
		 */	
		public static function deleteDomButton(_this:*):void{
			if(App.isApp||App.isMiniGame) return;
			for (var i:int = 0; i < buttonContainerArr.length; i++){
				if(buttonContainerArr[i].laya==_this){ //判断是否有此laya中节点
					buttonContainerArr[i].dom.remove();
					buttonContainerArr.splice(i,1)
					return;	
				}
			}
		}
		
		/**
		 * 粘贴公告
		 * @param input 需要粘贴的text属性
		 * @param fun 成功后执行的函数，默认为null
		 */	
		public static function paste(input:*,fun:Function=null):void{
			if(App.isApp){
				ExternalManager.paste(function(text:String):void{
					if(text&&text.length){
						input.text=text;
						fun&&fun();
					}else{
						Toast.show("请先复制后再粘贴！",null,-1,1500);
					}
				})
				return;
			}
			if(GlobalUtil.coyText){
				input.text = GlobalUtil.coyText;
				fun&&fun();
			}else{
				Toast.show("未检测到您在游戏中复制，请长按粘贴！",null,-1,1500);
			}
		}
		
		/**
		 * 在canvas同级的div中新建遮盖画布点击事件
		 * @param _this layabox中节点
		 * @param fun 执行的Function
		 * @param parameter 携带的参数，默认为null
		 * @param delOrigin 是否删除原来的遮盖，默认为true
		 */	
		public static function domButtonEvent(_this:*,fun:Function,parameter:*=null,delOrigin:Boolean=true):void{
			if(App.isApp){
				var node:Node = _this;
				if(node.hasListener(Event.CLICK)) return;
				node.on(Event.CLICK,null,function():void{
					ExternalManager.copy(parameter);
					Toast.success("复制成功");
				});
				return;
			}
			if(!buttonContainer){ //判断是否有div--容器
				buttonContainer=Browser.createElement("div");
				buttonContainer.style.position = "absolute";
				buttonContainer.style.zIndex = 1E5;
				Browser.container.appendChild(buttonContainer);
			}
			delOrigin&&deleteDomButton(_this);
			var transform:Object = Utils.getTransformRelativeToWindow(_this, 0, 0);
			var buttonElement:*=Browser.createElement("button");
			buttonElement.style.cssText = "position:absolute;overflow:hidden;resize:none;transform-origin:0 0;-webkit-transform-origin:0 0;-moz-transform-origin:0 0;-o-transform-origin:0 0;";
			buttonElement.style.resize = 'none';
			buttonElement.style.backgroundColor = 'transparent';
			buttonElement.style.border = 'none';
			buttonElement.style.outline = 'none';
			buttonElement.style.padding = 0;
			buttonElement.style.zIndex = 1;
			buttonElement.style.width = _this.displayWidth + 'px';
			buttonElement.style.height=_this.displayHeight + 'px';
			buttonElement.style.transform = buttonElement.style.webkitTransform = "scale(" + transform.scaleX + "," + transform.scaleY + ") rotate(" + (Laya.stage.canvasDegree) + "deg)";
			buttonElement.style.left = transform.x + 'px';
			buttonElement.style.top  = transform.y + 'px';
			buttonElement.onclick=function():void{
				fun(parameter);
			}
			buttonContainer.appendChild(buttonElement);
			buttonContainerArr.push({laya:_this,dom:buttonElement});
		}
	}
}