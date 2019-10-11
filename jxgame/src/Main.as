package{
	
	import game.core.enum.GlobalEnum;
	import game.core.enum.GlobalPopup;
	import game.core.enum.Module;
	import game.core.manager.AudioManager;
	import game.core.manager.ExternalManager;
	import game.core.model.GlobalConfig;
	import game.core.utils.App;
	import game.core.utils.Auth;
	import game.core.utils.Lang;
	import game.core.utils.Layer;
	import game.core.utils.Platform;
	import game.core.utils.Redirect;
	import game.core.utils.Signal;
	import game.core.utils.Storage;
	import game.core.utils.Version;
	
	import laya.display.Stage;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import laya.utils.Stat;
	import laya.webgl.WebGL;
	
	/**
	 * chenyuan
	 */
	public class Main{
		
		public function Main(){
			App.init();
			Laya.init(GlobalConfig.GAME_WIDTH,GlobalConfig.GAME_HEIGHT,WebGL);
			Laya.stage.alignH = Stage.ALIGN_CENTER;
			Laya.stage.alignV = Stage.ALIGN_MIDDLE;
			Laya.stage.scaleMode = Stage.SCALE_SHOWALL;
			if(Browser.onMobile) Laya.stage.screenMode=Stage.SCREEN_HORIZONTAL;
			Signal.once(GlobalEnum.MODULE_START,this,start); 
			Signal.once(GlobalEnum.MODULE_COMPLETE,this,complete);
			var res:String = GlobalConfig.getResVer();
			var root:String = ExternalManager.getConfig("root");
			Version.init(root,res,Handler.create(this,initLoader));
		}
		
		private function initLoader():void{
			Storage.init();
			Platform.init();
			Lang.init();
			var host:String = ExternalManager.getQuery("host");
			if(!host) host=ExternalManager.getConfig("host");
			if(host) GlobalConfig.HTTP_HOST=host;
			var pws:String = ExternalManager.getConfig("pws");
			GlobalConfig.IS_PRINT_WS = pws&&pws=="true";
			Laya.loader.load(GlobalConfig.INIT_RES,Handler.create(this,initModel));
		}
		
		private function initModel():void{
			Lang.start();
			Layer.init();
			Module.init();
			AudioManager.init();
			ExternalManager.init();
			Auth.init();
		}
		
		private function start():void{
			GlobalPopup.init();
			var stat:String = ExternalManager.getConfig("stat");
			if(stat&&stat=="true") Stat.show();
			if(Storage.env.isLogin){
				Redirect.start();
			}else{
				Redirect.login();
			}
		}
		
		private function complete():void{
			ExternalManager.start();
		}
	}
}