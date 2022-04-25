<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
<meta charset="utf-8">
<link  rel="stylesheet"  href="${basePath}static/css/index.css" />
		<link rel="stylesheet"  href="${basePath}static/css/font-awesome-4.7.0/css/font-awesome.min.css" />
		<script  src="${basePath}static/js/jquery.min.js" type="text/javascript"></script>
</head>
<body style="height: 100%; margin: 0">
<div class="add">
	<table class="tablelist" style="width: 30%;margin-left:50px">
		<c:if test="${type != 0}">
			<tr>
				<td  >工号:</td>
				<td  >${user.t_id}</td>
			</tr>
			<tr>
				<td  >姓名:</td>
				<td  >${user.t_name}</td>
			</tr>
			<tr>
				<td  >是否为管理员:</td>
				<td  >${user.t_isadmin}</td>
			</tr>
		</c:if>
		<c:if test="${type == 0}">
			<tr>
				<td  >学号:</td>
				<td  >${user.s_id}</td>
			</tr>
			<tr>
				<td  >姓名</td>
				<td  >${user.s_name}</td>
			</tr>
			<tr>
				<td  >班级</td>
				<td  >${user.s_class}</td>
			</tr>
		</c:if>
	</table>
	</div>
</body>
</html>