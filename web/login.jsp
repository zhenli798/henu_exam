<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>上机考试管理系统</title>
  <link rel="shortcut icon"type="image/x-icon" href="${basePath}img/logo.png" media="screen" />
  <link rel="stylesheet" type="text/css" href="${basePath}css/login.css">
  <link rel="stylesheet" type="text/css" href="${basePath}css/bootstrap.css">
  <script type="text/javascript"  src="${basePath}js/jquery.js"></script>
</head>
<body>
<div class="login-form">
  <h1><b>上机考试管理系统</b></h1>
  <div style="display: flex; flex-direction: row;">
    <p style="font-weight:bolder;">身份</p>
    <div style="display: flex; flex-direction: row;justify-content: space-between; width: 80%;margin-left: 5%;">
      <span><input type="radio" value="1" name="type" checked/> 教师</span>
      <span><input type="radio" value="0" name="type"/> 学生</span>
      <span><input type="radio" value="2" name="type"/> 管理员</span>
    </div>
  </div>

  <div class="txtb">
    <input type="text" id="userName">
    <span data-placeholder="学工号"></span>
  </div>

  <div class="txtb">
    <input type="password" id="passWord">
    <span data-placeholder="学生姓名或密码"></span>
  </div>
  <div class="verify">
    <input type="text" value="" placeholder="请输入验证码（不区分大小写）" class="input-val">
    <canvas id="canvas" width="100" height="30"></canvas>
  </div>

  <button class="logbtn">登 陆</button>
</div>
<script type="text/javascript">
  var show_num = [];
  draw(show_num);
  $('input[type=radio][name="type"]').on("change", function(){
    if (this.value == "0")
      $('#passWord').attr('type', 'text')
    else
      $('#passWord').attr('type', 'password')
  })

  $(".txtb input").on("focus", function(){
    $(this).addClass("focus");
  });
  $(".txtb input").on("blur", function(){
    if($(this).val() == "")
      $(this).removeClass("focus");
  });
  $("#canvas").on('click',function(){
    draw(show_num);
  })
  $(".logbtn").on('click', function(){
    if (canvasJudge()== 1){ // 提交
      // alert("登录成功!")
      var userName = $("#userName").val().trim();
      var passWord = $("#passWord").val().trim();
      var type = $('input[type=radio][name="type"]:checked').val().trim();

      $.post(
          "login", {"uname":userName, "pwd":passWord, "type":type}, function (response) {
            if (response[0] != 'p')
            {
              alert(response)
            }
            else
            {
              window.location.href = response;
            }
          }
      )
    }else if (canvasJudge() == 0){
      alert("验证码错误，请重新输入!");
      draw(show_num);
      $(".input-val").focus();
    }else{
      alert("验证码不能为空!");
      $(".input-val").focus();
    }
  })
  // 验证码判断
  function canvasJudge()
  {
    var val = $(".input-val").val().toLowerCase();
    var num = show_num.join("");
    /* console.log(val, num); */
    if (val == ''){ // 空
      return -1;
    }else if (val == num){ // 输入正确
      return 1;
    }else { // 输入错误
      return 0;
    }
  }
  //生成并渲染出验证码图形
  function draw(show_num) {
    var canvas_width=$('#canvas').width();
    var canvas_height=$('#canvas').height();
    var canvas = document.getElementById("canvas");//获取到canvas的对象，演员
    var context = canvas.getContext("2d");//获取到canvas画图的环境，演员表演的舞台
    canvas.width = canvas_width;
    canvas.height = canvas_height;
    var sCode = "a,b,c,d,e,f,g,h,i,j,k,m,n,p,q,r,s,t,u,v,w,x,y,z,A,B,C,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0";
    var aCode = sCode.split(",");
    var aLength = aCode.length;//获取到数组的长度

    for (var i = 0; i < 4; i++) {  //这里的for循环可以控制验证码位数（如果想显示6位数，4改成6即可）
      var j = Math.floor(Math.random() * aLength);//获取到随机的索引值
      // var deg = Math.random() * 30 * Math.PI / 180;//产生0~30之间的随机弧度
      var deg = Math.random() - 0.5; //产生一个随机弧度
      var txt = aCode[j];//得到随机的一个内容
      show_num[i] = txt.toLowerCase();
      var x = 10 + i * 20;//文字在canvas上的x坐标
      var y = 20 + Math.random() * 8;//文字在canvas上的y坐标
      context.font = "bold 23px 微软雅黑";

      context.translate(x, y);
      context.rotate(deg);

      context.fillStyle = randomColor();
      context.fillText(txt, 0, 0);

      context.rotate(-deg);
      context.translate(-x, -y);
    }
    for (var i = 0; i <= 5; i++) { //验证码上显示线条
      context.strokeStyle = randomColor();
      context.beginPath();
      context.moveTo(Math.random() * canvas_width, Math.random() * canvas_height);
      context.lineTo(Math.random() * canvas_width, Math.random() * canvas_height);
      context.stroke();
    }
    for (var i = 0; i <= 30; i++) { //验证码上显示小点
      context.strokeStyle = randomColor();
      context.beginPath();
      var x = Math.random() * canvas_width;
      var y = Math.random() * canvas_height;
      context.moveTo(x, y);
      context.lineTo(x + 1, y + 1);
      context.stroke();
    }
  }

  //得到随机的颜色值
  function randomColor() {
    var r = Math.floor(Math.random() * 256);
    var g = Math.floor(Math.random() * 256);
    var b = Math.floor(Math.random() * 256);
    return "rgb(" + r + "," + g + "," + b + ")";
  }

</script>

</body>
</html>