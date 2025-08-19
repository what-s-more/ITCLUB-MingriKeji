<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <title>ITCLUB 博客</title>
    <link href="css/base.css" rel="stylesheet">
    <link href="css/index.css" rel="stylesheet">
    <link href="css/new.css" rel="stylesheet">

    <script src="http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=407687"></script>
    <link rel="stylesheet" href="http://bdimg.share.baidu.com/static/api/css/share_style1_32.css">
    <script type="text/javascript" src="js/jBox/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="js/jBox/jquery.jBox-2.3.min.js"></script>
    <script type="text/javascript" src="js/jBox/i18n/jquery.jBox-zh-CN.js"></script>
    <link type="text/css" rel="stylesheet" href="js/jBox/Skins2/Yellow/jbox.css" />
    <script type="text/javascript" src="js/toolTip/tooltip.js"></script>
    <link type="text/css" rel="stylesheet" href="js/toolTip/tooltip.css" />

    <!--[if lt IE 9]>  
    <script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script> 
    <script src="js/respond.js"></script> 
    <![endif]-->

</head>

<body style="width: 1000px; margin: auto; background: url(images/bg.png) repeat-y">
    <c:set var="logoner" value="${sessionScope.logoner}" />
    <div id="logoner" style="display: none">${logoner}</div>
    <div id="blogNameIndex" style="display: none">${logoner.userBlogName}</div>
    <div id="userIdIndex" style="display: none">${logoner.id}</div>
    <header>
        <div id="logo">
            <a href="#"></a>
        </div>
        <nav class="topnav" id="topnav">
            <div id="logined" style="border: none; display: none" class="tooltip"
                 onmouseover="tooltip.pop(this, '#textContent',{position:1, offsetX:-50,  effect:'slide'})">
                <a href="javascript:loginIndex();" id="topnav_current">
                    <span id="userBlogName">你好，${logoner.userBlogName}（菜单）</span>
                    <span class="en"></span>
                </a>
            </div>

            <div style="display: none">
                <div id="textContent" style="width: 75px; height: 75px;">
                    <a id="blogUrl" href="goBlogIndex?master=${logoner.id}">进入博客</a> <br />
                    <a id="blogUrl" href="javascript:logOff();">退出</a>
                </div>
            </div>

            <div id="unLogin" style="margin-left: 550px;">
                <a href="javascript:loginIndex();" id="topnav_current">
                    <span class="menuTitle">登录</span>
                    <span class="en"></span> 
                </a>
            </div>
        </nav>
    </header>
    <div class="banner"></div>
    <div class="template">
        <div class="box">
            <h3>
                <p><span>快速访问</span></p>
            </h3>
            <ul>
                <li>
                    <a href="http://www.mingrisoft.com/" target="_black">
                        <img src="images/ad01.png"> 
                    </a>
                    <span>明日学院</span>
                </li>
                <li>
                    <a href="https://github.com/" target="_black">
                        <img src="images/GitHub.png"> 
                    </a>
                    <span>GitHub</span>
                </li>
                <li>
                    <a href="https://www.google.com.hk/?hl=zh-CN" target="_black">
                        <img src="images/google.png"> 
                    </a>
                    <span>谷歌</span>
                </li>
                <li>
                    <a href="https://www.wikipedia.org/" target="_black">
                        <img src="images/wiki.png"> 
                    </a>
                    <span>维基百科</span>
                </li>
                <li>
                    <a href="https://chat.deepseek.com/" target="_black">
                        <img src="images/deepseek.png"> 
                    </a>
                    <span>deepseek</span>
                </li>
            </ul>
        </div>
    </div>

    <article>
        <h1 class="t_nav">
            <a href="#" class="n1">精选博文</a>
            <a href="javascript:reg()" class="n2">AI聊天助手</a> 
        </h1>
        <div class="bloglist left">
            <c:set var="mostArticlelist" value="${requestScope.mostArticlelist}" />
            <c:if test="${!empty mostArticlelist}">
                <c:forEach var="article" items="${mostArticlelist}">
                    <h3>
                        <a href="goBlogContent?id=${article.id}&master=${article.artWhoId}">${article.artTitle}</a>
                    </h3>
                    <ul>
                        <p id="cssClip">${article.artContent}</p>
                        <a href="goBlogContent?id=${article.id}&master=${article.artWhoId}" target="_blank" class="readmore">阅读全文&gt;&gt;</a>
                    </ul>
                    <p class="dateview">
                        <span>${article.artPubTime}</span>
                        <span>作者：${article.userName}</span>
                    </p>
                </c:forEach>
            </c:if>
            <c:if test="${empty mostArticlelist}">
        		<p style="text-align: center; padding: 20px;">暂无精选博文~</p>
    		</c:if>
        </div>

        <aside class="right">
            <div class="news">
                <h3>
                    <p>最新 <span>博文</span></p>
                </h3>
				<c:set var="newArticlelist" value="${requestScope.newArticlelist}" />

				<ul class="rank">
					<c:if test="${!empty newArticlelist}">
						<c:forEach var="article" items="${newArticlelist}">
							<li>
								<a
									href="goBlogContent?id=${article.id}&master=${article.artWhoId}"
									title="${article.artTitle}" target="_blank">${article.artTitle}</a>
							</li>
						</c:forEach>
					</c:if>
					<c:if test="${empty newArticlelist}">
		        		<p style="text-align: center; padding: 20px;">暂无最新博文~</p>
		    		</c:if>
				</ul>
                <h3 class="ph">
                    <p>博客 <span>排行</span></p>
                </h3>
				<c:set var="toplist" value="${sessionScope.toplist}" />
				<ul class="paih">
					<c:if test="${!empty toplist}">
						<c:forEach var="topUser" items="${toplist}">
							<ul>
								<li>
									<a style="color: #5EA51B"
										href="goBlogIndex?master=${topUser.id}">${topUser.userName}</a>
									<span style="float: right">${topUser.userHitNum}次阅读</span>
								</li>
							</ul>
						</c:forEach>
					</c:if>
					<c:if test="${empty toplist}">
		        		<p style="text-align: center; padding: 20px;">暂无最新排行榜~</p>
		    		</c:if>
				</ul>
                <h3 class="links">
                    <p><span>分享</span></p>
                </h3>

                <div class="bdsharebuttonbox bdshare-button-style1-32" data-bd-bind="1467678661338">
                    <a href="#" class="bds_more" data-cmd="more"></a>
                    <a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
                    <a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
                    <a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a>
                    <a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a>
                    <a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
                </div>
            </div>
        </aside>
    </article>
    <footer>
        <p>
            <span style="color: white">技术支持</span> 
            <a href="http://www.mingrisoft.com" style="color: #FF7F50" target="_blank">吉林省明日科技有限公司</a>
        </p>
    </footer>  
			<script type="text/javascript" src="js/loginHtml.js" charset="UTF-8"></script>
<script type="text/javascript" src="js/rg.js" charset="UTF-8"></script>
<script>
    $(function() {
        // 从localStorage获取登录状态
        var isLogin = localStorage.getItem('isLogin') || '0';
        
        if (isLogin !== '0') {
            // 登录状态
            $('#unLogin').hide();
            $('#logined').show();
            // 恢复用户信息
            var userBlogName = localStorage.getItem('userBlogName');
            var userId = localStorage.getItem('userId');
            $("#userBlogName").html('你好，' + userBlogName + '<span style="color:red">菜单</span>');
            $("#blogUrl").attr({href: "goBlogIndex?master=" + userId});
        } else {
            $('#unLogin').show();
            $('#logined').hide();
        }
    });
    
    function reg() {
        window.location.href = "chat.jsp"; // 相对路径，指向webapp根目录下的chat.jsp
    }
    
    function loginIndex() {
        var html1 = loginHtml;
        var html2 = rgHtml;
        var data = {};
        var states = {};
        
        var content = {
            state1 : {
                content : html1,
                buttons : {
                    '忘记密码?':0,
                    '没有账号? 请注册': 1,
                },
                
                buttonsFocus : 0,
                submit : function(v, h, f) {
                    if (v == 1) {
                        $.jBox.nextState(); 
                    }
                    if (v == 0) {
                        $.jBox.tip("请联系系统管理员！", 'success');
                    }
                    return false;
                }
            },
            state2 : {
                content : html2,
                buttons: { '若有账号，请直接登录': 1 },
                buttonsFocus: 1, // focus on the second button
                submit: function (v, o, f) {
                    if (v == 1) {
                        $.jBox.prevState() //go back
                    } 
                    return false;
                }
            }
        }
        $.jBox.open(content, '登录', 650, 550);
        var i=parseInt(10*Math.random()); //生成随机数赋值给i
        var j=parseInt(10*Math.random()); //生成随机数赋值给j
        var k=i+j; 
        $("#hiddencode").val(k); 
        $("#showspan").html(" " + i + " + " + j + " = ?"); 
    }
</script>
<script type="text/javascript" language="javascript">
    function getverifycodeChange(){ //定义方法
        var i = parseInt(10 * Math.random()); //生成随机数赋值给i
        var j = parseInt(10 * Math.random()); //生成随机数赋值给j
        var k = i + j; //变量k为i与j之和
        $("#hiddencode").val(k); //设置验证码的正确答案
        $("#showspan").html(" " + i + " + " + j + " =?"); //设置验证码的样式
        $("#verifycode").focus(); //单击验证码时，鼠标聚焦
    }
</script>
<script>
// 获取页面参数
function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
}

function regUser() {
    if ($('#userName').val() === '') {
        $.jBox.tip("账号不能为空", 'error');	
        return false;
    }
    
    if ($('#userPs').val() === '') {
        $.jBox.tip("密码不能为空", 'error');	
        return false;
    }
    
    if ($('#psRepeat').val() === '') {
        $.jBox.tip("确认密码不能为空", 'error');	
        return false;
    }
    
    if ($('#psRepeat').val() !== $('#userPs').val()) {
        $.jBox.tip("密码输入不一致", 'error');	
        return false;
    }
    
    if ($('#regBlogName').val() === '') {
        $.jBox.tip("博客名称不能为空", 'error');	
        return false;
    }
    
    if ($('#regBlogName').val().length > 10) {
        $.jBox.tip("博客名称不能超过10个字", 'error');	
        return false;
    }
    
    if ($('#blogInfo').val() === '') {
        $.jBox.tip("个性标签不能为空", 'error');	
        return false;
    }
    
    return true;
}

function loginIn() {
    if ($("#user").val() === "" || $("#ps").val() === "") { 
        $.jBox.tip("账户或密码不能为空", 'error'); 
        return; 
    }
    if ($("#hiddencode").val() !=parseInt($("#verifycode").val())) { 
        $.jBox.tip("验证码错误", 'error'); 
        return; 
    }
    $.jBox.tip("正在提交...", 'loading'); 
    $.ajax({ 
        url: "logon", 
        type: "post", 
        data: { 
            userName: $("#user").val(), 
            userPswd: $("#ps").val() 
        },
        success: function(data) { 
            $.jBox.closeTip(); 
            arrData = eval("(" + data + ")"); 
            if (arrData.result === '1') { 
                $.jBox.tip("账户或密码不正确。", 'error'); 
            } else { 
                $.jBox.close();
                $.jBox.tip("登录成功！", 'success');
                
                $("#userBlogName").html('你好，' + arrData.userBlogName + '<span style="color:red">菜单</span>');
                $("#blogUrl").attr({href: "goBlogIndex?master=" + arrData.userId});
                
                $('#unLogin').hide();
                $('#logined').show();
                $('#isLogin').html("1");
                
                // 保存登录状态到localStorage
                localStorage.setItem('isLogin', '1');
                localStorage.setItem('userBlogName', arrData.userBlogName);
                localStorage.setItem('userId', arrData.userId);
                
                if (arrData.userFlag === '1') {
                    // 当前blog与登录用户为同一个用户
                    $('.delFlag').show();
                    $('#addFlag').show();
                    $('.editFlag').show();
                }
            }
        },
        error: function(xhr, status, error) {
            $.jBox.closeTip();
            let errorMsg = `请求失败: ${error}`;
        }
    });
}

function logOff() {
    $.jBox.tip("正在退出...", 'loading');
    
    $.ajax({
        url: "logoff",
        type: "post",
        success: function(data) {
            // 关闭加载条
            $.jBox.closeTip();
            $.jBox.tip("成功退出！", 'success');
            
            $('#unLogin').show();
            $('#logined').hide();
            $('#isLogin').html("0");
            $('.delFlag').hide();
            $('#addFlag').hide();
            $('.editFlag').hide();
            
            // 清除localStorage中的登录状态
            localStorage.removeItem('isLogin');
            localStorage.removeItem('userBlogName');
            localStorage.removeItem('userId');
        }
    });
}
</script>
</body>
</html>