<%@page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<!-- student主界面-->
<head>
<meta charset="utf-8" />
<title>上机考试系统首页</title>
<link rel="shortcut icon" href="${basePath}img/logo.png" />
<link rel="bookmark" href="${basePath}img/logo.png" />
<link rel="stylesheet" href="${basePath}static/css/index.css" />
<link rel="stylesheet"
	href="${basePath}static/css/font-awesome-4.7.0/css/font-awesome.min.css" />
<script src="${basePath}static/js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$('.menux p').click(function() {
			$(this).siblings('ul').slideUp(200);
			$(this).next('ul').slideToggle(200);
		});
		$('.menux p:first').trigger("click");
		
		$('.menux ul a').click(function() {

			$('iframe').attr("src", $(this).attr("url"));
			$('.menu_title').html($(this).attr("title"));
		});
		$(".logout").click(function(){
			if(window.confirm("确定要退出吗？")){
				window.location.href = "${basePath}logout"
			}
		});
	})
</script>
</head>
<body>
	<div class="header">
		<div class="logo">上机考试系统</div>
		<div class="user" style="min-width:77px">
			<i class="fa fa-caret-down point"></i> <i class="fa fa-user"></i>
					${user.s_name}
			<ul>
				<li><a target="mainFrame" href="${basePath}info.jsp">个人信息</a></li>
				<li><a href="javascript:void(0)" class="logout">退出登录</a></li>
			</ul>
		</div>
	</div>
	<div class="left">
		<div class="title">
			<i class="fa fa-home"></i> 系统功能
		</div>
		<div class="menux">
				<p>
					<i class="fa fa-user-circle-o"></i> <i
						class="fa fa-angle-right point"></i> 学生权限
				</p>
				<ul>
					<li><a href="javascript:void(0);" url="${basePath}student?method=listMyExam" title="我的考试">
							<i class="fa fa-caret-right"></i> 我的考试
					</a></li>
					<li><a href="javascript:void(0);" url="${basePath}scquery?method=query_student" title="我的成绩图">
							<i class="fa fa-caret-right"></i> 我的成绩图
					</a></li>
					<li><a href="javascript:void(0);" url="${basePath}myfile?method=list&msg=" title="我的云空间">
							<i class="fa fa-caret-right"></i> 我的云空间
					</a></li>
					
				</ul>
		</div>
	</div>
	<div class="main">
		<div class="location">
			<i class="fa fa-home"></i> <span class="menu_title">简要介绍</span>
		</div>
		<iframe name="mainFrame" src="${basePath}page/Student/introduce3.jsp" width="100%" height="90%" frameborder="0px"></iframe>
	</div>
</body>
</html>
