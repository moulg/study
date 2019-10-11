package game.core.utils{
	
	import game.core.enum.GlobalEnum;
	import game.core.ui.Toast;
	
	import laya.events.Event;
	import laya.net.Socket;

	/**
	 * chenyuan
	 */
	public class WS{
		
		private static var _host:String;
		private static var _port:int;
		private static var _socket:Socket;
		private static var _key:int;		
		private static var _cbs:Object;
		
		public static function init(host:String,port:int):void{
			if(_socket) return;
			_key = 1;
			_cbs = {};
			_host = host;
			_port = port;
			_socket = new Socket(host,port);
			_socket.on(Event.OPEN,null,onOpen);
			_socket.on(Event.CLOSE,null,onClose);
			_socket.on(Event.ERROR,null,onError);
			_socket.on(Event.MESSAGE,null,onMessage);
		}
		
		public static function send(type:String,data:Object=null,cb:Function=null):int{
			if(_socket&&_socket.connected){
				if(cb) _cbs[_key]=cb;
				_socket.send(Crypto.encode([type,_key,data||{}]));
				return _key++;
			}
			return 0;
		}
		
		public static function close():Boolean{
			if(_socket&&_socket.connected){
				_socket.close();
				return true;
			}
			return false;
		}
		
		public static function reconn():Boolean{
			if(_socket&&!_socket.connected){
				_socket.connect(_host,_port);
				return true;
			}
			return false;
		}
		
		public static function reset():Boolean{
			if(_socket){
				_socket.offAll();
				_socket.cleanSocket();
				_socket = null;
				return true;
			}
			return false;
		}
		
		private static function onOpen(e:*):void{
			Signal.event(GlobalEnum.WS_OPEN,e);
		}
		
		private static function onClose(e:*):void{
			Signal.event(GlobalEnum.WS_CLOSE,e);
		}
		
		private static function onError(e:*):void{
			Signal.event(GlobalEnum.WS_ERROR,e);
		}
		
		private static function onMessage(e:*):void{
			var res:Array = Crypto.decode(e);
			if(!res||res.length<3){
				console.error("message error",e);
				return;
			}
			var type:int = res.shift();
			var key:int = res.shift();
			var data:Object = res.shift();
			if(key>0){
				var cb:Function = _cbs[key];
				if(cb){
					var code:int = data.code;
					if(code!=0&&!data.errMsg) data.errMsg=ErrorCode.getMsg(code);
					if(cb.length==1){
						if(code==0){
							cb(data);
						}else{
							if(code==ErrorCode.PAY){
								ErrorCode.pay(data);
							}else{
								Toast.error(data.errMsg);
							}
						}
					}else if(cb.length==2){
						cb(data,code);
					}else{
						cb();
					}
					delete _cbs[key];
				}
			}else{
				Signal.event(GlobalEnum.WS_MESSAGE,{type:type,data:data});
			}
		}
	}
}