package game.core.utils{
	
	import game.core.ui.Toast;
	
	import laya.events.Event;
	import laya.net.HttpRequest;
	import laya.utils.Handler;

	/**
	 * chenyuan
	 */
	public class HTTP{
		
		private static var _token:Object;
		private static var _headers:Array;
		private static var _reqId:int = 1;
		private static var _reqs:Array = [];
		
		public static function get(url:String,data:*=null,handler:Handler=null,responseType:String="json",headers:Array=null):void{
			call(url,data,handler,"get",responseType,headers);
		}
		
		public static function post(url:String,data:*=null,handler:Handler=null,responseType:String="json",headers:Array=null):void{
			call(url,data,handler,"post",responseType,headers);
		}
		
		public static function setToken(token:Object):void{
			_token = token;
		}
		
		public static function setHeaders(headers:Array):void{
			_headers = headers;
		}
		
		private static function call(url:String,data:*=null,handler:Handler=null,method:String="get",responseType:String="text",headers:Array=null):void{
			var req:HttpRequest = _reqs.length?_reqs.shift():new HttpRequest();
			function onCallback(result:Boolean,data:*):void{
				req.offAll();
				if(handler!=null&&handler.method!=null){
					if(!result){
						Toast.error(Lang.text("netError"));
						return;
					}
					var code:int = data.code;
					if(handler.method.length==1){
						if(code==0){
							handler.runWith(data);
						}else{
							Toast.error(data.errMsg||ErrorCode.getMsg(code));
						}
					}else if(handler.method.length==2){
						handler.runWith([data,code]);
					}else{
						handler.run();
					}
				}
				_reqs.push(req);
			}
			function onError(e:*):void{
				onCallback(false,e);
			}
			function onComplete(e:*):void{
				onCallback(true,e);
			}
			if(method=="post"){
				if(!data) data={};
				data.reqid = _reqId;
				if(_token){
					for(var x:String in _token){
						data[x] = _token[x];
					}
				}
				data = fromatData(data);
			}else{
				url = url+((url.indexOf("?")==-1)?"?":"&")+"reqid="+_reqId;
				if(data){
					for(var y:String in data){
						url+="&"+y+"="+data[y];
					}
				}
				if(_token){
					for(var z:String in _token){
						url+="&"+z+"="+_token[z];
					}
				}
			}
			_reqId++;
			req.once(Event.ERROR,null,onError);
			req.once(Event.COMPLETE,null,onComplete);
			req.send(url,data,method,responseType,headers||_headers);
		}
		
		private static function fromatData(json:Object):String{
			function fromat(key:String,value:String):String{
				return key+"="+encodeURIComponent(value);
			}
			var data:Array = [];
			if(json){
				for(var key:String in json){
					var val:* = json[key];
					if(val is Array){
						for(var i:int=0;i<val.length;i++){
							data.push(fromat(key,val[i]));
						}
					}else{
						data.push(fromat(key,val));
					}
				}
				return data.join("&");
			}
			return "";
		}
	}
}