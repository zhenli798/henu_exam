<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>上机考试管理系统</title>
  <link rel="shortcut icon" href="${basePath}static/img/1.ico" />
  <link rel="bookmark" href="${basePath}static/img/1.ico" />

  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="keywords" content="" />
  <script type="application/x-javascript">
    addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
  <link href="${basePath}static/css/login.css" type="text/css" rel="stylesheet" media="all">
</head>
<body>
<div id="container">
  <div id="output">
    <div class="containerT">
      <h1>上机考试系统</h1>
      <div class="controls w3l">
        <div class="cbcontrol" id="cbControlRight"><</div>
        <div class="cbcontrol" id="cbControlLeft">></div>
        <div class="clear"></div>
      </div>
      <div class="stage" style="text-align: center;">
        <div id="t_form" class="cbImage w3">
          <h3>教师</h3>

          <form action="login" method="post" class="form">
            <input name="uname" required type="text" placeholder="用户名"  value="001">
            <input name="pwd" required type="password" placeholder="密码" value="123456">
            <input name="type" type="hidden" value="1"/>
            <button type="submit">登录</button>
            <div id="prompt" class="prompt">${error1}</div>
          </form>
        </div>
        <div id="s_form" class="cbImage active signin agileits">
          <h3>学生</h3>
          <form action="login" method="post"  class="form">
            <input name="uname" required type="text" placeholder="学号" value="1912020079">
            <input name="pwd" required type="text" placeholder="姓名" value="李振" >
            <input name="type"  type="hidden" value="0"/>
            <button type="submit">登录</button>
            <div id="prompt" class="prompt">${error0}</div>
          </form>
        </div>
        <div id="a_form" class="cbImage agileinfo">
          <h3>管理</h3>
          <form action="login" method="post" class="form" >
            <input name="uname" required  type="text" placeholder="用户名" value="001">
            <input name="pwd" required type="password" placeholder="密码" value="123456">
            <input name="type" type="hidden" value="2"/>
            <button type="submit">登录</button>
            <div id="prompt" class="prompt">${error2}</div>
          </form>
        </div>
        <div class="clear"></div>
      </div>
      <div class="clear"></div>
      <div class="footer">
        <p>&copy; 2022 All Rights Reserved | Design by 228</p>
      </div>
      <script src="${basePath}static/js/jquery.min.js"></script>
      <script src="${basePath}static/js/coverflow-slideshow.js"></script>
      <script src="${basePath}static/js/vector.js"></script>
      <script type="text/javascript">
        Victor("container", "output");   //登录背景函数
        $(function () {
          Victor("container", "output");   //登录背景函数
          $("#entry_name").focus();
          $(document).keydown(function (event) {
            if (event.keyCode == 13) {
              $("#entry_btn").click();
            }
          });
          $(document).click(function () {
            $(".prompt").html("");//第二次填充表单时，关闭上次的警告提醒
          });

        });
        if('${type}' == "1"){
          $("#t_form").click();
        }else if('${type}'=="2"){
          $("#a_form").click();
        }

        //缩放刷新
        $(window).resize(function () {
          location.reload();
        })

      </script>
    </div>
  </div>
</div>
</body>

</html>