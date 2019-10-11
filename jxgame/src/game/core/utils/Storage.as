package game.core.utils{
	
	import game.core.manager.ExternalManager;
	import game.core.model.GlobalConfig;
	import game.core.vo.EnvVo;
	import game.core.vo.SettingVo;
	
	import laya.net.LocalStorage;
	
	/**
	 * chenyuan
	 */
	public class Storage{
		
		private static var _env:EnvVo;
		private static var _key:String = "USER";
		
		public static function init():void{
			var clear:String = ExternalManager.getConfig("isClearLS");
			if(clear=="true"){
				Storage.clear();
				return;
			}
			_env = new EnvVo();
			_env.setData(LocalStorage.getItem(_key));
		}
		
		public static function login(data:EnvVo):void{
			_env = data;
			GlobalConfig.isAutomatic&&LocalStorage.setItem(_key,JSON.stringify(data));
		}
		
		public static function clear():void{
			_env = new EnvVo();
			LocalStorage.removeItem(_key);
		}
		
		public static function setItem(key:String,value:String):void{
			LocalStorage.setItem(key,value);
		}
		
		public static function getItem(key:String):String{
			return LocalStorage.getItem(key);
		}
		
		public static function setData(key:String,data:Object):void{
			LocalStorage.setItem(key,JSON.stringify(data));
		}
		
		public static function getData(key:String):Object{
			var str:String = LocalStorage.getItem(key);
			if(str&&str.length) return JSON.parse(str);
			return null;
		}
		
		public static function updateSetting(moduleId:String,data:SettingVo):void{
			setData(moduleId,data);
		}
		
		public static function getSetting(moduleId:String):SettingVo{
			var vo:SettingVo = getData(moduleId) as SettingVo;
			if(!vo) vo=new SettingVo();
			return vo;
		}
		
		public static function get env():EnvVo{
			return _env;
		}
	}
}