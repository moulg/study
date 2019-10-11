window.appos = "minigame";
window.appConfig = {
  appid: "wxffad6b2f424b005b",
  appindex: "3",
  offerId: "1450015220",
  root: "https://jsh5.oss-cn-hangzhou.aliyuncs.com/minigame/c2/",
  host: "https://xcx.45yu.com",
  oss: "https://xcx.45yu.com/gateway/getOsstoken",
  lang: "cn",
  game: "9",
  stat: "false",
  check: "false",
  isClearLS: "false",
  res: ["res/login/ui.png", "res/login/ani", "res/common/cn.png", "res/common/popup.png", "res/common/ui.png", "res/hhzl/ani", "res/hhzl/common.png", "res/hhzl/desktop.png", "res/hhzl/help.png", "res/hhzl/popup.png"],
  shareUrl: "http://www.189dianwan.com/jinshun/index.html",
  shareImg: "https://jsh5.oss-cn-hangzhou.aliyuncs.com/ios/app/share.png",
  shareTitle: "金舜游戏",
  shareDescription: "我在玩，金舜游戏，这里棋牌电玩应有尽有，赶快来体验吧！"
};
window.wxPlay = function() {
  wx.requestMidasPayment({
    mode: "game",
    env: 1,
    offerId: "1450015220",
    currencyType: "CNY",
    platform: "android",
    buyQuantity: 1,
    zoneId: 1,
    success: function(res) {
      // 支付成功
    },
    fail: function(res) {
      // 支付失败
      console.log(res)
    }
  });
};