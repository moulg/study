!function(t,e,i){i.un,i.uns;var n=i.static,a=i.class,s=i.getset,o=(i.__newvec,game.core.ui.Alert),l=game.core.manager.AudioManager,c=game.core.base.BaseModel,u=game.core.base.BaseModule,r=game.core.utils.CoreHound,h=game.core.manager.EffectManager,m=(laya.events.Event,game.core.enum.GameID,game.core.model.GlobalConfig),f=(game.core.enum.GlobalEnum,game.core.model.GlobalModel),d=game.core.enum.GlobalPopup,g=ui.hall.popup.HallSetUpUI,p=laya.utils.Handler,S=ui.hall.scene.HomeUI,y=(laya.net.Loader,game.core.enum.Module,game.core.manager.PopupManager),_=game.core.utils.Redirect,v=game.core.manager.SceneManager,A=(game.core.vo.SettingVo,game.core.utils.Signal),L=(laya.ani.bone.Skeleton,laya.display.Sprite),I=game.core.utils.Storage,U=game.core.ui.Toast,b=laya.ui.View,w=(function(){function t(){}a(t,"game.module.hall.enum.HallPopup"),t.SETUP="SETUP"}(),function(){function t(){}a(t,"game.module.hall.enum.HallScene"),t.INDEX="INDEX",t.RETURNHALL="RETURNHALL"}(),function(){function t(){}a(t,"game.module.hall.enum.HallSignal"),t.START="START",t.SHOW_HOME="SHOW_HOME"}(),function(){function t(){}return a(t,"game.module.hall.HallConfig"),t.getAniUrl=function(t){return"res/hall/ani/"+t+".json"},t.getSoundUrl=function(t,e){return void 0===e&&(e=!1),"res/hall/sound/"+t+m.getSoundExt(e)},n(t,["INIT_SKINS",function(){return this.INIT_SKINS=[{url:"res/hall/home.json",type:"atlas"},{url:"res/hall/xingdian.json",type:"atlas"},{url:"res/hall/ani/jinxiujiaose.png",type:"image"}]}]),t}()),E=function(){function t(){}return a(t,"game.module.hall.utils.HallSound"),s(1,t,"initSounds",function(){for(var e=[t.getUrl("bg",!0)],i=["button"];i&&i.length;)e.push(t.getUrl(i.shift()));return e}),t.init=function(){l.start(t.getUrl("bg",!0))},t.effect=function(e){l.playSound(t.getUrl(e))},t.getUrl=function(t,e){return void 0===e&&(e=!1),m.getSoundUrl(t,e)},t}(),H=function(t){function e(){e.__super.call(this)}a(e,"game.module.hall.HallModel",t);var i=e.prototype;return i.init=function(e){t.prototype.init.call(this,e),this.event("START")},i.destroy=function(){t.prototype.destroy.call(this)},s(1,e,"instance",function(){return e._instance||(e._instance=new e),e._instance},game.core.base.BaseModel._$SET_instance),e._instance=null,e}(c),N=(function(t){function e(){e.__super.call(this),this.isCache=!0,y.reg("HALL","SETUP",G),v.reg("HALL","INDEX",N);var t=w.INIT_SKINS;t=t.concat(E.initSounds),this.init(t)}a(e,"game.module.hall.HallModule",t);var i=e.prototype;i.onInit=function(){t.prototype.onInit.call(this),H.instance.once("START",this,this.start),H.instance.init(this.dataSource)},i.start=function(){v.enter("HALL","INDEX"),this.initComplete()},i.enter=function(e){t.prototype.enter.call(this,e),E.init(),"REDIRECT_BACK"!=e&&H.instance.event("RETURNHALL")},i.remove=function(){t.prototype.remove.call(this)},i.destroy=function(t){void 0===t&&(t=!0),laya.display.Sprite.prototype.destroy.call(this,t),H.instance.destroy()}}(u),function(t){function e(){this._layer=null,this._curViewIndex=-1,this.classList=[T],this.viewList=null,e.__super.call(this),this._layer=new L,this.addChild(this._layer),this.viewList=new Array(this.classList.length),H.instance.on("SHOW_HOME",this,this.showView,[0]),this.showView(0)}a(e,"game.module.hall.scene.IndexView",t);var i=e.prototype;return i.showView=function(t){if(this._curViewIndex!=t){var e=this.viewList[t];if(e||(e=new this.classList[t],this.viewList[t]=e),this._layer.removeChildren(),2==t){var i=this.viewList[0];this._layer.addChild(i)}this._layer.addChild(e),this._curViewIndex=t}},i.destroy=function(e){void 0===e&&(e=!0),t.prototype.destroy.call(this,e)},e}(b)),T=function(t){function e(){this.gamesAniI=1,this.gamesAnicC=0,this.gamesAnicS=!1,e.__super.call(this);var t=this;h.getSkeleton(m.getAniUrl("shanxian"),p.create(this,function(e){e.pos(30,22),t.shanxian.addChild(e)})),h.getSkeleton(w.getAniUrl("jinxiujiaose"),p.create(this,function(e){e.pos(120,666),t.jinxiujiaose.addChild(e)})),A.on("SELF_INFO",this,this.onUpdateSelfInfo),this.onUpdateSelfInfo(),this.setGameList(),this.btnAdd.on("click",this,this.onAddGold),this.btnSetUp.on("click",this,this.onSetUp),this.btnBack.on("click",this,this.onBack),this.avatar.on("click",this,this.onAvatar)}a(e,"game.module.hall.scene.HomeView",S);var i=e.prototype;return i.onAdd=function(){this.timerOnce(5e3,this,this.goGamesAni)},i.onUpdateSelfInfo=function(){this.name.text=f.instance.self.nickname,this.avatar.skin=f.instance.self.avatar,this.gold.text=f.instance.self.gold/m.goldrate+""},i.onAvatar=function(){r.effect("button"),d.openUserInfo()},i.onAddGold=function(){r.effect("button"),d.openShop()},i.onSetUp=function(){r.effect("button"),y.open("HALL","SETUP")},i.onBack=function(){r.effect("button"),o.show("\n是否退回登录页？",p.create(this,function(t){t&&(_.game(101),I.clear()),r.effect("button")}))},i.setGameList=function(){var t=f.instance.gameList;this.gameList.array=[];for(var e=0;e<t.length;e++)this.gameList.array.push({logo:{skin:"res/hall/home/game"+t[e].gameId+"-"+t[e].gameState+".png"},hotSign:{skin:"res/hall/home/hotSign"+t[e].hotSign+".png"},gameId:t[e].gameId,gameState:t[e].gameState});this.gameList.hScrollBarSkin=null,this.gameList.selectEnable=!0,this.gameList.scrollBar.elasticBackTime=150,this.gameList.scrollBar.elasticDistance=200,this.gameList.mouseHandler=p.create(this,this.onGameList,null,!1)},i.onGameList=function(t,e){"click"==t.type?(r.effect("button"),1==this.gameList.array[e].gameState?_.game(this.gameList.array[e].gameId):U.error("游戏未开启，敬请期待")):"mousedown"==t.type?this.onGamePanelDown():"mouseup"==t.type?this.onGamePanelUp():"mouseout"==t.type&&this.onGamePanelUp()},i.goGamesAni=function(){this.gameList.scrollBar.max-this.gameList.scrollBar.value>100?this.gamesAniI=1:this.gamesAniI=-1,this.timerLoop(40,this,this.onGamesAni)},i.onGamesAni=function(){this.gameList.scrollBar.value+=this.gamesAniI,this.gamesAnicC++,100==this.gamesAnicC&&(this.gamesAniI=-this.gamesAniI,this.gamesAnicC=0)},i.onGamePanelDown=function(){this.clearTimer(this,this.onGamesAni),this.gamesAnicS=!0},i.onGamePanelUp=function(){this.gamesAnicS&&(this.timerOnce(5e3,this,this.goGamesAni),this.gamesAnicS=!1)},i.onRemov=function(){this.clearTimer(this,this.goGamesAni),this.clearTimer(this,this.onGamesAni)},i.destroy=function(t){void 0===t&&(t=!0),laya.ui.View.prototype.destroy.call(this,t)},e}(),G=function(t){function e(){this._status=null,this._data=null,e.__super.call(this),this.musicNum.changeHandler=p.create(this,this.onMusicNums,null,!1),this.effectNum.changeHandler=p.create(this,this.onEffectNum,null,!1),this.btnMusic.on("click",this,this.onMusic),this.btnEffect.on("click",this,this.onEffect),this.btnClose.on("click",this,this.onClose)}a(e,"game.module.hall.popup.HallSetUpView",g);var i=e.prototype;return i.onOpened=function(){this._data=l.data,this._status=JSON.stringify(this._data),this.musicNum.value=this._data.musicVolume,this.effectNum.value=this._data.soundVolume,this.btnMusic.selected=this._data.musicOff,this.btnEffect.selected=this._data.soundOff},i.onClose=function(){r.effect("button"),this.close()},i.onMusic=function(){this._data.musicOff=this.btnMusic.selected,this.voice()},i.onEffect=function(){this._data.soundOff=this.btnEffect.selected,this.voice()},i.onMusicNums=function(){this._data.musicVolume=this.musicNum.value,this.voice()},i.onEffectNum=function(){this._data.soundVolume=this.effectNum.value,this.voice()},i.voice=function(){var t=JSON.stringify(this._data);t!=this._status&&(this._status=t,l.update(this._data))},e}()}(window,document,Laya),"function"==typeof define&&define.amd&&define("laya.core",["require","exports"],function(t,e){"use strict";Object.defineProperty(e,"__esModule",{value:!0});for(var i in Laya){var n=Laya[i];n&&n.__isclass&&(e[i]=n)}});