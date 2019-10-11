package game.core.utils{
	
	import game.core.model.GlobalConfig;
	
	/**
	 * chenyuan
	 */
	public class Crypto{
		
		public static function encode(data:Array):ArrayBuffer{
			var str:String = JSON.stringify(data);
			if(GlobalConfig.IS_PRINT_WS) console.log("%c↑ "+GlobalUtil.nowTimeStr()+" "+str,"color:#007A00");
			str = encodeURIComponent(str);
			var codes:Array = [];
			var len:int = str.length;
			for(var i:int=0;i<len;i++){
				var char:String = str.charAt(i);
				if(char==="%"){
					var hex:String = str.charAt(i+1)+str.charAt(i+2);
					codes.push(parseInt(hex,16));
					i+=2;
				}else{
					codes.push(char.charCodeAt(0));
				}
			}
			len = codes.length;
			var flag:int = len%128;
			var buffer:ArrayBuffer = new ArrayBuffer(len);
			var arr:Uint8Array = new Uint8Array(buffer);
			for(i=0;i<len;i++){
				arr[i] = codes[i]^flag;
			}
			return buffer;
		}
		
		public static function decode(data:ArrayBuffer):Array{
			var str:String = "";
			var arr:Uint8Array = new Uint8Array(data);
			var len:int = arr.byteLength;
			var flag:int = len%128;
			for(var i:int=0;i<len;i++){
				var num:Number = arr[i]^flag;
				str+="%"+num.toString(16).toUpperCase();
			}
			str = decodeURIComponent(str);
			if(GlobalConfig.IS_PRINT_WS) console.log("%c↓ "+GlobalUtil.nowTimeStr()+" "+str,"color:#E35E05");
			return JSON.parse(str) as Array;
		}
	}
}