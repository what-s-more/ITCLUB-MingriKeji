var addImageHtml = `
  <div id="respond">
    <form 
      action="photo?action=insert&type=upload" 
      method="post" 
      enctype="multipart/form-data" 
      id="commentform" 
      onsubmit="return submitImg();"
    >
      <div class="comment-regists" style="text-align:center">
        <h2>上传图片</h2>
      </div>
      <div class="comment-regists">
        <ul>
          <li class="form-inline">
            <label for="info">图片说明：</label>
            <input 
              type="text" 
              name="info" 
              id="info" 
              value="" 
              tabindex="2" 
              aria-required="true" 
              placeholder="请输入图片说明"
            >
          </li>
          <li class="form-inline">
            <label for="userImg">选择图片：</label>
            <input 
              type="file" 
              name="userImg" 
              id="userImg"
              size="50"
              accept="image/*" 
            >
          </li>
        </ul>
      </div>
      <div class="comment-login" style="padding-top:20px; text-align: center;">
        <input 
          name="submit" 
          type="submit" 
          class="submitButton" 
          tabindex="5" 
          value="上传图片"
        >
      </div>
    </form>
  </div>
`;