window.google = {}

document.write("<style>\
    #logo{width:554px;height:186px;background:black url(http://html5games.net/wp-content/games/pacman/src/pacman10-hp.gif) 0 0 no-repeat;position:relative;margin-bottom:9px}\
    #logo-l{width:200px;height:2px;left:177px;top:157px;background:#990;position:absolute;display:none;overflow:hidden}\
    #logo-b{position:absolute;left:0;background:#ff0;height:8px;width:0}\
    #gameblock{width:554px;height:186px;padding:10px;background:#000;-webkit-border-radius:8px;}\
    .lsb:active{background:-webkit-gradient(linear,left top,left bottom,from(#ccc),to(#ddd))}\
    .ds{display:-moz-inline-box}\
    .ds{border-bottom:solid 1px #e7e7e7;border-right:solid 1px #e7e7e7;display:inline-block;margin:3px 0 4px;margin-left:4px;margin-right:3px:height:32px}\
  </style>");

document.write("<div id=\"gameblock\">\
  	<a href=\"#gameover\" id=\"dlink\"></a>\
  	<div id='logo' title=\"PAC-MAN's 30th Birthday! Doodle with PAC-MANâ„¢ & Â©1980 NAMCO BANDAI Games Inc.\">\
  		<div id=\"logo-l\">\
  			<div id=\"logo-b\">\
  			</div>\
  		</div>\
    </div>\
  </div>");

google.dom = {};
google.pacManSound = true;
google.browser = {};
google.browser.engine = {}
google.dom.remove = function (a) {
    return a && a.parentNode && a.parentNode.removeChild(a)
};
google.dom.append = function (a) {
    return document.body.appendChild(a)
};
google.browser.engine.IE = false;
google.pml = function () {
      function d(a) {
        if (!google.pml_installed) {
          google.pml_installed = true;
          if (!a) {
            document.getElementById("logo").style.background = "black";
            window.setTimeout(function () {
              var b = document.getElementById("logo-l");
              if (b) b.style.display = "block"
            }, 400)
          }
          a = document.createElement("script");
          a.type = "text/javascript";
          a.src = "http://html5games.net/wp-content/games/pacman/src/js/pacman10-hp.3.js";
          document.body.appendChild(a)
        }
      }
      function e() {
        if (document.f && document.f.btnI) document.f.btnI.onclick = function () {
            typeof google.pacman != "undefined" ? google.pacman.insertCoin() : d(false);
            return false
        }
      }
      if (!google.pml_loaded) {
        google.pml_loaded = true;
        window.setTimeout(function () {
          document.f && d(true)
        }, 1E4);
        e();
      }
    };

document.write("<form action=\"#submit\" name='f'>\
              <input name='btnI' type='submit' value=\"Insert Coin\" class='lsb'>\
  </form>");

google.pml && google.pml();