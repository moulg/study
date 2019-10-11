(function($) {
  $.getQuery = function(name) {
    var r = window.location.search.substr(1).match(new RegExp("(^|&)" + name + "=([^&]*)(&|$)"));
    if (r != null) return unescape(r[2]);
    return null;
  };
  $.getScript = function(url, cb, target) {
    var script = document.createElement("script");
    script.setAttribute("type", "text/javascript");
    script.setAttribute("src", url);
    if (!target) target = document.getElementsByTagName("head")[0];
    target.appendChild(script);
    if (document.all) {
      script.onreadystatechange = function() {
        if (script.readyState == "loaded" || script.readyState == "complete") {
          cb && cb();
        }
      }
    } else {
      script.onload = function() {
        cb && cb();
      }
    }
  };
  $.http = function(url, data, cb) {
    $.ajax({
      url: abgame.host + url,
      type: "post",
      data: data || {},
      success: function(res) {
        res = JSON.parse(res);
        cb(res.code == 0, res);
      },
      error: function(xhr, errorType, error) {
        alert("数据错误，请刷新重试");
      }
    });
  };
})($);