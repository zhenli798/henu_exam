<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<!-- Admin-->
<head>
<meta charset="utf-8" />
<title>上机考试系统首页</title>
<link rel="shortcut icon" href="${basePath}static/img/1.ico" />
<link rel="bookmark" href="${basePath}static/img/1.ico" />
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
					${user.t_name}
			<ul>
				<li><a  target="mainFrame" href="${basePath}page/Admin/pwd.jsp">修改密码</a></li>
				<li><a  target="mainFrame" href="${basePath}info.jsp">个人信息</a></li>
				<c:if test="${user.t_isadmin==1}">
					<li><a href="${basePath}page/Teacher/index.jsp">切换到老师</a></li>
				</c:if>
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
						class="fa fa-angle-right point"></i> 管理员权限
				</p>
				<ul>
					<li><a href="javascript:void(0);" url="${basePath}admin?method=list" title="所有教师">
							<i class="fa fa-caret-right"></i> 所有教师
					</a></li>
						<li><a href="javascript:void(0);" url="${basePath}scquery?method=query_range" title="分数区间统计">
							<i class="fa fa-caret-right"></i> 分数区间统计
					</a></li>
					<li><a href="javascript:void(0);" url="${basePath}scquery?method=query_jgl" title="及格率统计">
							<i class="fa fa-caret-right"></i> 及格率统计
					</a></li>
					<li><a href="javascript:void(0);" url="${basePath}main" title="成绩报表">
							<i class="fa fa-caret-right"></i> 成绩报表
					</a></li>
					<li><a href="javascript:void(0);" url="${basePath}page/Admin/showGlobal.jsp" title="全局变量">
							<i class="fa fa-caret-right"></i> 全局变量
					</a></li>
				
					<li><a href="javascript:void(0);" url="${basePath}page/Admin/about.jsp" title="系统监控">
							<i class="fa fa-caret-right"></i> 系统监控
					</a></li>
				</ul>
		</div>
	</div>
	<div class="main">
		<div class="location">
			<i class="fa fa-home"></i> <span class="menu_title">简要介绍</span>
		</div>
		<iframe name="mainFrame" src="${basePath}page/Admin/introduce2.jsp" width="100%" height="90%" frameborder="0px"></iframe>
	</div>
</body>
</html>
