package game.core.utils{
	
	import laya.utils.Handler;

	/**
	 * chenyuan
	 */
	public class ResLoader{
		
		private static var _instance:ResLoader;
		private var _props:Array;
		private var _require:Handler;
		private var _complete:Handler;
		
		public function ResLoader(){
			
		}
		
		public static function load(list:Array,require:Handler=null,complete:Handler=null):void{
			if(!_instance) _instance=new ResLoader();
			_instance.load(list,require,complete);
		}
		
		private function load(list:Array,require:Handler=null,complete:Handler=null):void{
			_props = [];
			_require = require;
			_complete = complete;
			var len:int = list?list.length:0;
			var inits:Array = [];
			for(var i:int=0;i<len;i++){
				var obj:Object = list[i];
				if(obj is String){
					obj = {url:obj,level:99999};
				}else if(!obj.level){
					obj.level = 99999;
				}
				var level:int = obj.level;
				if(obj.level==1){
					delete obj.level;
					inits.push(obj);
				}else{
					_props.push(obj);
				}
			}
			if(_props.length>1){
				_props.sort(function(a:Object,b:Object):int{
					if(a.level>b.level) return 1;
					if(a.level<b.level) return -1;
					return 0;
				});
			}
			if(inits.length){
				Laya.loader.load(inits,Handler.create(this,onInit));
			}else{
				onInit();
			}
		}
		
		private function onInit():void{
			if(_require) _require.run();
			_require = null;
			props();
		}
		
		private function props():void{
			if(_props&&_props.length){
				var obj:Object = _props.shift();
				var url:String = obj.url;
				var type:String = obj.type||null;
				Laya.loader.load(url,Handler.create(this,onProps),null,type);
			}else{
				if(_complete) _complete.run();
				_complete = null;
			}
		}
		
		private function onProps():void{
			//props();
			Laya.timer.frameOnce(2,this,props);
		}
	}
}