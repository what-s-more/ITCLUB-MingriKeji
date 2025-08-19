var loginHtml = '<div id="loginHtml">' +

    '<style>' +
    '#loginHtml #respond { font-family: "微软雅黑", sans-serif; display: flex;}' +
    '#loginHtml .Indexleft { flex: 1; background: #f0f7ff; display: flex; flex-direction: column; align-items: center; justify-content: center;}' +
    '#loginHtml .Indexright { flex: 1.8; background: #eee;}' +
    '#loginHtml .Indexcenter { width: 2px; background: #eee; }' +
    '#loginHtml .comment-login:first-child { color: #333; font-size: 22px; font-weight: 600; letter-spacing: 1px; }' +
    '#loginHtml #showspan { display: inline-block; width: 80px; height: 30px; line-height: 30px; text-align: center; margin: 0 10px; border-radius: 4px; }' +
    '#loginHtml .kanbuqing { color: #4a90e2; cursor: pointer; text-decoration: none; }' +
    '#loginHtml .kanbuqing:hover { text-decoration: underline; }' +
    '#loginHtml .submitButton { background: #4a90e2; color: white; border: none; border-radius: 4px !important; cursor: pointer; transition: background 0.3s; }' +
    '#loginHtml .submitButton:hover { background: #3a80d2; }' +
    '</style>' +

    '<div class="Indexleft">' +
    '<div style="text-align: center; padding: 20px;">' +
	'<img src="images/me.webp" style="width: 120px; height: 120px; border-radius: 50%; box-shadow: 0 2px 8px rgba(0,0,0,0.1); margin: 0 auto; cursor: pointer;" onclick="window.open(\'https://github.com/what-s-more\', \'_blank\');">'  +
    '<p style="margin-top: 20px; color: #555; font-size: 16px;">关注我，获取更多技术资讯</p>' +
    '</div>' +
    '</div>' +
    '<div class="Indexright">' +
    '<div id="respond" ><form  method="post" id="commentform">' +
    '<div class="comment-login">请登录</div>' +
    '<div class="comment-login" style="font-size:16px;margin-top:-40px">' +
    '<ul style="margin-left:-100px">' +
    '<li class="form-inline">' +
    '<label>账号：</label>' +
    '<input type="text" name="user" id="user" value="" tabindex="1" aria-required="true">' +
    '</li>' +
    '<li class="form-inline">' +
    '<label>密码：</label>' +
    '<input type="password" name="ps" id="ps" value="" tabindex="2" aria-required="true">' +
    '</li>' +
    '<li class="form-inline" style="margin-left:92px">' +
    '<label>验证码：</label>' +
    '<input class="wenbenkuang" style="width:100px" name="verifycode" id="verifycode" type="text" value="" maxLength=2 size="3"  onkeydown="keyLogin();">' +
    '<input id="hiddencode" type="hidden">'+
    '<span id="showspan" name="showspan" style="border:5px;font-weight:bold;background:#131313;color:white"></span>' +
    '<a class="kanbuqing" href="javascript:void(0)" onClick="getverifycodeChange();">&nbsp;换一题</a>' +
    '</li>' +
    '</ul>' +
    '</div>' +
    '<div class="comment-login"><input name="submit" type="button" id="save" onclick="loginIn()"  class="submitButton" tabindex="5" value="登录">' +
    '</div>' +
    '</form></div>' +
    '</div>' +
    '<div class="Indexcenter"></div>' +
'</div>';