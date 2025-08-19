/**
 * 注册表单（美化版）
 */
var rgHtml = `
<style>
    #Rrespond {
        max-width: 500px;
        margin: 50px auto;
        font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
        border: 1px solid #ccc;
        padding: 20px 30px;
        border-radius: 8px;
        background-color: #f9f9f9;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    .comment-regists {
        font-size: 20px;
        margin-bottom: 20px;
        color: #333;
        text-align: center;
        font-weight: bold;
    }
    ul {
        list-style: none;
        padding: 0;
    }
    .Rform-inline {
        margin-bottom: 15px;
        display: flex;
        align-items: center;
    }
    .Rform-inline label {
        flex: 0 0 110px;
        font-weight: bold;
        color: #444;
    }
    .Rform-inline input[type="text"],
    .Rform-inline input[type="password"],
    .Rform-inline input[type="file"] {
        flex: 1;
        padding: 8px 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
        background: #fff;
    }
    .registButton {
        background-color: #4CAF50;
        color: white;
        padding: 10px 25px;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
    }
    .registButton:hover {
        background-color: #45a049;
    }
</style>
<div id="Rrespond">
    <form action="userReg?action=upIco" method="post" enctype="multipart/form-data" onsubmit="return regUser()">
        <div class="comment-regists">请注册</div>
        <div class="comment-regists">
            <ul>
                <li class="Rform-inline">
                    <label><span style="color:red">*</span>账号：</label>
                    <input type="text" name="userName" id="userName" value="" tabindex="1" aria-required="true">
                </li>
                <li class="Rform-inline">
                    <label><span style="color:red">*</span>密码：</label>
                    <input type="password" name="userPs" id="userPs" value="" tabindex="2" aria-required="true">
                </li>
                <li class="Rform-inline">
                    <label><span style="color:red">*</span>确认密码：</label>
                    <input type="password" name="psRepeat" id="psRepeat" value="" tabindex="3" aria-required="true">
                </li>
                <li class="Rform-inline">
                    <label><span style="color:red">*</span>博客名称：</label>
                    <input type="text" name="regBlogName" id="regBlogName" value="" tabindex="4" aria-required="true">
                </li>
                <li class="Rform-inline">
                    <label><span style="color:red">*</span>个性签名：</label>
                    <input type="text" name="blogInfo" id="blogInfo" value="" tabindex="5" aria-required="true">
                </li>
                <li class="Rform-inline">
                    <label><span style="color:red">*</span>头像：</label>
                    <input type="file" name="userIco" size="50" value="">
                </li>
            </ul>
        </div>
        <div class="comment-regist" style="text-align:center; padding-top:20px">
            <input name="submit" type="submit" class="registButton" tabindex="6" value="注册">
        </div>
    </form>
</div>`;