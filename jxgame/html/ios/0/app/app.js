function getScript(url, cb) {
  var script = document.createElement("script");
  script.src = url;
  script.loader = "laya";
  document.body.appendChild(script);
  cb && cb();
};
var appurl = "Main.max.js";
getScript(appurl);