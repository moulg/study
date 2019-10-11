package game.core.manager{
	
	import game.core.enum.GlobalEnum;
	import game.core.ui.Loading;
	import game.core.ui.Toast;
	import game.core.utils.App;
	import game.core.utils.Signal;
	
	import laya.display.Sprite;
	import laya.utils.Browser;
	
	/**
	 * chenyuan
	 */
	public class ExternalManager{
		
		private static var _game:Object;
		public static var isStart:Boolean;
		
		public function ExternalManager(){
			
		}
		
		public static function init():void{
			Browser.window.callAs = callAs;
			_game = Browser.window.Game;
		}
		
		public static function start():void{
			callGame("start");
			isStart = true;
		}
		
		public static function callAs(type:String,data:*=null):void{
			if(type=="upload"){
				Signal.event(GlobalEnum.UPLOAD_IMG,data);
			}else if(type=="toast"){
				Toast.show(data);
			}else if(type=="showLoading"){
				Loading.show(data);
			}else if(type=="hideLoading"){
				Loading.hide();
			}else if(type=="onWxLogin"){
				var login:String = data;
				if(login&&login.length){
					Signal.event(GlobalEnum.APP_WX_LOGIN,data);
				}
			}else if(type=="onWxShare"){
				var share:String = data;
				if(share&&share.length){
					Laya.timer.once(3000,null,function():void{
						Toast.success("分享成功！");
					});
				}
			}else if(type=="onIosPay"){
				Signal.event(GlobalEnum.APP_IOS_PAY,data);
			}else if(type=="onSaveImage"){
				Signal.event(GlobalEnum.APP_SAVE_IMAGE,data);
			}
		}
		
		public static function callJS(name:String,data:*=null):void{
			if(Browser.window[name]) Browser.window[name](data);
		}
		
		public static function callGame(name:String,data:*=null):void{
			if(_game&&_game[name]) _game[name](data);
		}
		
		public static function data(data:Object):void{
			alert(JSON.stringify(data));
		}
		
		public static function alert(value:String):void{
			callJS("alert",value);
		}
		
		public static function openURL(url:String):void{
			callGame("goto",url);
		}
		
		public static function copy(text:String):void{
			callGame("copy",text);
		}
		
		public static function saveImage(url:String):void{
			callGame("saveImage",url);
		}
		
		public static function paste(cb:Function):void{
			callGame("paste");
			Laya.timer.frameOnce(5,null,function():void{
				cb(Browser.window.clipboardText);
			});
		}
		
		public static function exit():void{
			if(App.isMiniGame){
				Browser.window.wx.exitMiniProgram();
			}else{
				callGame("exit");
			}
		}
		
		public static function error(msg:String):void{
			if(App.isApp){
				alert(msg);
			}else{
				callGame("error",msg);
			}
		}
		
		public static function reload():void{
			if(App.isMiniGame){
				Browser.window.wx.exitMiniProgram();
			}else{
				callGame("reload");
			}
		}
		
		public static function login():void{
			callGame("login");
		}
		
		public static function share(data:*=null):void{
			callGame("share",data);
		}
		
		public static function webPay(title:String,url:String):void{
			callGame("pay",{title:title,url:url});
		}
		
		public static function appPay(data:String):void{
			if(App.isIosCheck){
				callGame("iosPay",data);
			}else if(App.isApp){
				callGame("pay",data);
			}
		}
		
		public static function closePay():void{
			callGame("closePay");
		}
		
		public static function getConfig(name:String):String{
			if(App.isApp||App.isMiniGame) return App.config[name];
			var o:Object = Browser.window.abgame;
			if(o&&o.hasOwnProperty(name)) return o[name];
			return getQuery(name);
		}
		
		public static function getQuery(name:String):String{
			if(App.isMiniGame) return null;
			var r:Array = Browser.window.location.search.substr(1).match(new RegExp("(^|&)"+name+"=([^&]*)(&|$)"));
			if (r!=null) return unescape(r[2]);
			return null;
		}

		public static function removeUpload():void{
			var file:Object = Browser.document.querySelector("#upload");
			if(file) file.style.display="none";
		}
		
		public static function uploadImg(obj:Sprite=null):void{
			if(App.isApp){
				callGame("uploadImg");
				return;
			}
			var file:Object = Browser.document.querySelector("#upload");
			if(!file) return;
			var cw:int = Browser.clientWidth;
			var ch:int = Browser.clientHeight;
			var gw:int = Laya.stage.width;
			var gh:int = Laya.stage.height;
			var dom:* = Browser.document.getElementById("layaCanvas");
			var str:String = dom.style.transform;
			str = str.match(/\([\S\s]+\)/)[0];
			str = str.substr(1,str.length-2);
			var arr:Array = str.split(",");
			var matrixX:int = arr[4];
			var matrixY:int = arr[5];
			var offsetX:int = (matrixX==0)?1:(cw-matrixX/2)/cw;
			var offsetW:int = (matrixX==0)?1:(cw-matrixX*2)/cw;
			var offsetY:int = (matrixY==0)?1:(ch-matrixY/2)/ch;
			var offsetH:int = (matrixY==0)?1:(ch-matrixY*2)/ch;
			var parent:Sprite = obj.parent as Sprite;
			var tx:Number = (parent.x+obj.x)/gw*100;
			var ty:Number = (parent.y+obj.y)/gh*100;
			var tw:Number = obj.width/gw*100;
			var th:Number = obj.height/gh*100;
			file.style.left = (tx/offsetX)+"%";
			file.style.top = (ty/offsetY)+"%";
			file.style.width = (tw*offsetW)+"%";
			file.style.height = (th*offsetH)+"%";
			file.style.display = "block";
		}
	}
}