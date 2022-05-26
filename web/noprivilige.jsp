<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="cn">
<head>
<title>权限不足</title>
	<link rel="shortcut icon" href="${basePath}img/logo.png" />
	<link rel="bookmark" href="${basePath}img/logo.png" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<style type="text/css">
		body{margin:0;padding:0;font:14px/1.6 Arial,Sans-serif;background:#fff url(img/body.png) repeat-x;}
		a:link,a:visited{color:#007ab7;text-decoration:none;}
		h1{
			position:relative;
			z-index:2;
			width:540px;
			height:0;
			margin:110px auto 15px;
			padding:230px 0 0;
			overflow:hidden;
			xxxxborder:1px solid;
			background-image: url(${basePath}img/main.jpg);
			background-repeat: no-repeat;
		}
		h2{
			position:absolute;
			top:55px;
			left:233px;
			margin:0;
			font-size:0;
			text-indent:-999px;
			-moz-user-select:none;
			-webkit-user-select:none;
			user-select:none;
			cursor:default;
			width: 404px;
			height: 90px;
		}
		h2 em{display:block;font:italic bold 200px/120px "Times New Roman",Times,Serif;text-indent:0;letter-spacing:-5px;color:rgba(216,226,244,0.3);}
		.link a{margin-right:1em;}
		.link,.texts{width:540px;margin:0 auto 15px;color:#505050;}
		.texts{line-height:2;}
		.texts dd{margin:0;padding:0 0 0 15px;}
		.texts ul{margin:0;padding:0;}
		.portal{color:#505050;text-align:center;white-space:nowrap;word-spacing:0.45em;}
		.portal a:link,.portal a:visited{color:#505050;word-spacing:0;}
		.portal a:hover,.portal a:active{color:#007ab7;}
		.portal span{display:inline-block;height:38px;line-height:35px;background:url(img/portal.png) repeat-x;}
		.portal span span{padding:0 0 0 20px;background:url(img/portal.png) no-repeat 0 -40px;}
		.portal span span span{padding:0 20px 0 0;background-position:100% -80px;}
		.STYLE1 {
			font-family: Arial, Helvetica, sans-serif;
			font-size: 65px;
		}
	</style>
<body>
<h1></h1>
<p class="link">
	<a href="login.jsp">&#9666;请登录</a>
</p>
<dl class="texts">
	<dt>噢，您好像没有权限访问该界面哟</dt>
	<dd>
		<ul>
			<li>推荐您去登录</li>
			<li>确定不要登录吗?</li>
			<li>真的真的确定不要登录吗?</li>
			<li>好吧.还是随便你要不要真的确定登录吧</li>
		</ul>
	</dd>
</dl>

</span></span></span></p>
</body>
</html>