package game.core.utils{
	
	import game.core.enum.GlobalEnum;
	import game.core.manager.ExternalManager;
	import game.core.model.GlobalConfig;
	import game.core.model.GlobalModel;
	import game.core.ui.Payment;
	import game.core.ui.Toast;
	import game.core.vo.EnvVo;
	
	import laya.utils.Browser;
	import laya.utils.Handler;

	/**
	 * chenyuan
	 */
	public class Auth{
		
		private static var _instance:Auth;
		
		public static function init():void{
		 	_instance = new Auth();
			_instance.init();
		}
		
		private function init():void{
			if(!App.isMiniGame&&!Platform.isKuaiyu&&!Platform.isGuangDian&&Storage.env.isValid){
				var token:String = Storage.env.token;
				loginByToken(token,Handler.create(this,function(data:Object,code:int):void{
					if(code==0){
						data.token = token;
						complete(data);
					}else{
						login();
					}
				}));
			}else{
				login();
			}
		}
		
		private function login():void{
			if(Platform.isGGame){
				ggame();
			}else if(Platform.isSy){
				sy();
			}else if(Platform.isKuaiyu){
				kuaiyu();
			}else if(Platform.isGuangDian){
				guangdian();
			}else if(Platform.isDanzhu||Platform.isMintparty){
				var imei:int = GlobalUtil.random(1000000);
				loginByImei(imei,Handler.create(this,complete));
			}else{
				if(GlobalConfig.TEST_ID>0&&isDev){
					loginByImei(GlobalConfig.TEST_ID,Handler.create(this,complete));
				}else{
					Storage.clear();
					Signal.event(GlobalEnum.MODULE_START);
				}
			}
		}
		
		private function get isDev():Boolean{
			var url:String = Browser.window.location.href;
			if(url.indexOf("//localhost")!=-1) return true;
			if(url.indexOf("//127.0.0.1")!=-1) return true;
			if(url.indexOf("//192.168")!=-1) return true;
			return false;
		}
		
		
		private function complete(data:Object):void{
			var vo:EnvVo = new EnvVo();
			vo.pf = Platform.platform;
			vo.http = GlobalConfig.HTTP_HOST;
			vo.host = data.host;
			vo.port = data.port;
			vo.token = data.token;
			Storage.login(vo);
			GlobalModel.instance.init();
		}
		
		public function minigame():void{
			Browser.window.wx.login({success:function(login:Object):void{
				Browser.window.wx.getUserInfo({success:function(info:Object):void{
					loginByMiniGame(login.code,info.userInfo);
				}});
			}});
		}
		
		private function wx():void{
			var code:String = ExternalManager.getQuery("code");
			if(code){
				loginByWeixin(code);
			}else{
				var appid:String = ExternalManager.getConfig("appid");
				var href:String = encodeURIComponent(Browser.window.location.href);
				var url:String = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appid+"&redirect_uri="+href+"&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
				ExternalManager.openURL(url);
			}
		}
		
		private function ggame():void{
			var token:String = ExternalManager.getQuery("token");
			if(token){
				loginBySpNew(5,{token:token},Handler.create(this,complete));
			}else{
				//var url:String = "http://testgamesdk.opg.cn/login.html";
				var url:String = "http://gamesdk.opg.cn/login.html";
				var href:String = encodeURIComponent(Browser.window.location.href);
				url = url+"?gameId=165&state=ggame&redirectUri="+href;
				ExternalManager.openURL(url);
			}
		}
		
		private function sy():void{
			var obj:Object = GlobalUtil.getUrlParames();
			if(obj){
				delete obj["pf"];
				delete obj["time"];
				if(!GlobalUtil.hasEmptyObject(obj)){
					loginBySpNew(6,obj,Handler.create(this,complete));
					return;
				}
			}
			//var url:String = "http://h5i.2sy.com/Game/game?appid=100003&agent=0";
			var url:String = "http://h5igame.opg.cn/Game/game?appid=100003&agent=0";
			ExternalManager.openURL(url);
		}
		
		private function kuaiyu():void{
			var obj:Object = GlobalUtil.getUrlParames();
			if(obj){
				delete obj["pf"];
				delete obj["time"];
				if(!GlobalUtil.hasEmptyObject(obj)){
					loginBySpNew(20,obj,Handler.create(this,complete));
					return;
				}
			}
			Toast.show("登录失败请重试！");
		}
		
		private function guangdian():void{
			Browser.window.GetCurrentUser(function(res:Object):void{
				if(res){
					var obj:Object = {};
					var tvmid:String = res.tvmid;
					var token:String = res.token;
					var href:String = Browser.window.location.href;
					var index:int = href.lastIndexOf("/");
					href = href.substring(0,index)+"/payComplete.html?pf="+Platform.platform+"&rnd"+GlobalUtil.random(999999);
					obj.tvmid = tvmid;
					obj.token = token;
					obj.nickname = res.nickname;
					obj.avatar = res.avatar;
					Payment.parameter = {tvmid:tvmid,token:token,redirect:href};
					loginBySpNew(19,obj,Handler.create(this,complete));
				}else{
					Toast.show("登录失败请重试！");
				}
			});
		}
		
		public static function get instance():Auth{
			return _instance;
		}
		
		/**
		 * 通过设备号登录
		 * @param imei 设备号
		 * @param handler 回调
		 */		
		public function loginByImei(imei:int,handler:Handler):void{
			var url:String = GlobalConfig.HTTP_HOST+"/gateway/loginByImei";
			HTTP.post(url,{platform:"h5",imei:imei},handler);
		}
		
		/**
		 * 渠道登录
		 * @param channel 渠道ID
		 * @param data 数据
		 * @param handler 回调
		 */		
		public function loginBySpNew(channel:int,data:Object,handler:Handler):void{
			var url:String = GlobalConfig.HTTP_HOST+"/gateway/loginBySpNew";
			if(!data) data={};
			data.platform = "h5";
			data.channel = channel;
			HTTP.post(url,data,handler);
		}
		
		/**
		 * 通过缓存Token登录
		 * @param token token
		 * @param handler 回调
		 */		
		public function loginByToken(token:String,handler:Handler):void{
			var url:String = GlobalConfig.HTTP_HOST+"/gateway/loginByToken";
			var data:Object = {platform:"h5",loginToken:token};
			HTTP.post(url,data,handler);
		}
		
		/**
		 * 微信登录
		 * @param code 微信CODE
		 * @param handler 回调
		 */		
		public function loginByWeixin(code:String,handler:Handler=null):void{
			var url:String = GlobalConfig.HTTP_HOST+"/gateway/wx_loginNew";
			var index:int = parseInt(ExternalManager.getConfig("appindex"));
			if(isNaN(index)) index=0;
			var data:Object = {os:"h5",platform:"h5",type:"h5",code:code,wx_index:index};
			HTTP.post(url,data,Handler.create(this,function(data:Object):void{
				if(handler) handler.run();
				complete(data);
			}));
		};
		
		/**
		 * 微信小游戏登录
		 * @param code 微信CODE
		 * @param userinfo 用户数据
		 * @param handler 回调
		 */		
		public function loginByMiniGame(code:String,userinfo:Object):void{
			var url:String = GlobalConfig.HTTP_HOST+"/gateway/wx_loginmin";
			var index:int = parseInt(ExternalManager.getConfig("appindex"));
			if(isNaN(index)) index=0;
			var data:Object = {os:"h5",platform:"h5",type:"h5",code:code,wx_index:index,userinfo:JSON.stringify(userinfo)};
			HTTP.post(url,data,Handler.create(this,function(data:Object,code:int):void{
				if(code==0){
					complete(data);
				}else{
					var delay:int = 4000;
					Toast.show(ErrorCode.getMsg(code),null,-1,delay);
					Laya.timer.once(delay,this,function():void{
						Browser.window.wx.exitMiniProgram();
					});
				}
			}));
		};
		
		/**
		 * 通过手机号登录
		 * @param phone 手机号
		 * @param code 验证码
		 * @param handler 回调
		 */		
		public function loginByPhone(phone:String,code:String,handler:Handler=null):void{
			var url:String = GlobalConfig.HTTP_HOST+"/gateway/loginAndDispatchNew";
			var data:Object = {platform:"h5",phone:phone,code:code};
			HTTP.post(url,data,Handler.create(this,function(data:Object):void{
				handler&&handler.run();
				complete(data);
			}));
		};
		
		/**
		 * 获取手机登录验证码
		 * @param phone 手机号
		 * @param handler 回调
		 */		
		public function sendCode(phone:String,handler:Handler):void{
			var url:String = GlobalConfig.HTTP_HOST+"/gateway/sendCodeNew";
			HTTP.post(url,{phone:phone},handler);
		};
		
		
		/**
		 * 通过账号登录
		 * @param account 账号
		 * @param psw 密码
		 * @param handler 回调
		 */	
		public function accountLogin(account:String,psw:String,handler:Handler=null):void{
			var url:String = GlobalConfig.HTTP_HOST+"/gateway/accountLogin";
			HTTP.post(url,{platform:"h5",account:account,psw:psw},Handler.create(this,function(data:Object):void{
				handler&&handler.run();
				complete(data);
			}));
		}
		/**
		 * 账号注册
		 * @param account 账号
		 * @param psw 密码
		 * @param handler 回调
		 */	
		public function accountAdd(account:String,psw:String,handler:Handler):void{
			var url:String = GlobalConfig.HTTP_HOST+"/gateway/accountAdd";
			HTTP.post(url,{platform:"h5",account:account,psw:psw},Handler.create(this,function(data:Object):void{
				handler&&handler.run();
				complete(data);
			}));
		}
		
	}
}