<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>选课</title>
		<link  rel="stylesheet"  href="${basePath}static/css/index.css" />
		<link rel="stylesheet"  href="${basePath}static/css/font-awesome-4.7.0/css/font-awesome.min.css" />
		<script  src="${basePath}static/js/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript">
		</script>
	</head>
	<body>
		<table class="tablelist" style="width: 70%;min-width:600px; margin:20px">
			<thead>
				<tr>
					<th>ID</th>
					<th>课程名</th>
					<th>及格人数</th>
					<th>总人数</th>
					<th>及格率</th>
				</tr>
			</thead>
			<c:forEach items="${list}" var="temp">
			<tr>
				<td>${temp.e_id}</td>
				<td>${temp.e_name}</td>
				<td>${temp.jgnum}</td>
				<td>${temp.allnum}</td>
				<td>${temp.jgl}%</td>
			</tr>
			</c:forEach>
		</table>
		<%-- <%@include file="../inc/page.jsp"%> --%>
	</body>
</html>
