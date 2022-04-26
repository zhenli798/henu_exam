<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="${basePath}static/css/index.css" />
<link rel="stylesheet"
	href="${basePath}static/css/font-awesome-4.7.0/css/font-awesome.min.css" />
<script src="${basePath}static/js/jquery.min.js" type="text/javascript"></script>
</head>
<body style="height: 100%; margin: 0">
	<div class="add">
		<p style="color: green; text-align: center;">
			<%
				if (request.getParameter("msg") != null) {
				out.print(request.getParameter("msg"));
			}
			%>
		</p>
		<form id="updatePwd" action="${basePath}admin?method=updatePwd"
			method="post">
			<input type="hidden" name="id" value="${user.t_id}">
			 <input
				type="hidden" name="t_pwd" value="${user.t_pwd}">
			<table class="tableadd" style="width: 50%;">
				<tr>
					<td>原密码</td>
					<td><input type="password" name="pwd"></td>
				</tr>
				<tr>
					<td>新密码</td>
					<td style="color: red;"><input type="password" name="newPwd"></td>
				</tr>
				<tr>
					<td>确认密码</td>
					<td><input type="password" name="newPwd2"></td>
				</tr>
				<tr>
					<td colspan="4" align="left">
						<button class="remove">
							<i class="fa fa-save"></i> 提交
						</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>