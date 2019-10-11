package game.core.utils{
	import laya.net.Loader;
	import laya.net.URL;
	import laya.utils.Handler;

	/**
	 * chenyuan
	 */
	public class Version{
		
		private static var _data:Object;
		
		public static function init(root:String,res:String,handler:Handler):void{
			URL.customFormat = parse;
			if(root&&root.length) URL.basePath=root;;
			if(res&&res.length){
				var url:String = getUrl(res);
				Laya.loader.load(url,Handler.create(null,onComplete,[handler]),null,Loader.JSON);
			}else{
				handler&&handler.run();
			}
		}
		
		private static function onComplete(handler:Handler,data:Object):void{
			_data = data;
			handler&&handler.run();
		}
		
		private static function parse(url:String):String{
			return getUrl(url);
		}
		
		private static function getUrl(url:String):String{
			if(_data&&_data[url]) url=_data[url]+"/"+url;
			return url;
		}
	}
}