<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<!-- Teacher -->
<head>
<meta charset="utf-8" />
<title>上机考试系统首页</title>
<link rel="shortcut icon" href="${basePath}static/img/1.ico" />
<link rel="bookmark" href="${basePath}static/img/1.ico" />
<link rel="stylesheet" href="${basePath}static/css/teacher.css" />
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
		$(".logout").click(function() {
			if (window.confirm("确定要退出吗？")) {
				window.location.href = "${basePath}logout"
			}
		});
	})
	
</script>
</head>
<body>
	<div class="left">
	<div class="logo">上机考试系统</div>
		 <div class="menux">
		<p>
				<i class="fa fa-user-circle-o"></i> <i
					class="fa fa-angle-right point"></i> 老师权限
			</p>
			<ul>
				<li><a href="javascript:void(0);"
					url="${basePath}teacher?method=list"  title="所有考试列表"> <i
						class="fa fa-caret-right"></i> 所有考试列表
				</a></li>
				<li><a href="javascript:void(0);"   url="${basePath}exam?method=detail&e_id=left" title="单场考试管理">
						<i class="fa fa-caret-right"></i> 单场管理考试
				</a></li>
				<li><a href="javascript:void(0);" url="${basePath}scquery?method=query_teacher" title="成绩统计">
						<i class="fa fa-caret-right"></i> 成绩统计
				</a></li>
								<li><a href="javascript:void(0);" url="${basePath}main" title="成绩报表">
							<i class="fa fa-caret-right"></i> 成绩报表
					</a></li>
			</ul>
		</div>
		<div class="user" style="min-width:77px">
			<i class="fa fa-caret-down point"></i> <i class="fa fa-user"></i>
					${user.t_name}
			<ul>
				<li><a target="mainFrame" href="${basePath}page/Admin/pwd.jsp">修改密码</a></li>
				<li><a target="mainFrame" href="${basePath}info.jsp">个人信息</a></li>
				<c:if test="${user.t_isadmin==1}">
					<li><a href="${basePath}page/Admin/index.jsp">切换管理员</a></li>
				</c:if>
				<li><a href="javascript:void(0)" class="logout">退出登录</a></li>
			</ul>
		</div>

	</div>
	<div class="right">
	<div class="location">
			<i class="fa fa-home"></i> <span class="menu_title">简要介绍</span>
		</div>
	<div class="main">
		<iframe name="mainFrame" src="${basePath}page/Teacher/introduce1.jsp"
			width="100%" height="100%" frameborder="0px"></iframe>
	</div>
	</div>
</body>
<style>
.location{
	height: 40px;
	line-height: 40px;
	border-left: 1px solid #f0f0f0;
	border-bottom: 1px solid #f0f0f0;
	border-right: 1px solid #f0f0f0;
	background-color: #FFFFFF;
	padding-left: 10px;
	box-sizing: border-box;
	color: #666666;
}
</style>
</html>
