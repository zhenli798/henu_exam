<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${basePath}static/css/index.css" />
<link rel="stylesheet"
	href="${basePath}static/css/font-awesome-4.7.0/css/font-awesome.min.css" />
<script src="${basePath}static/js/jquery.min.js" type="text/javascript"></script>
<meta charset="UTF-8">
</head>
<body>
<div>
<p style="color:green;text-align: center;">
<%
if(request.getParameter("msg")!=null){
	out.print(request.getParameter("msg"));
}
%>

</p>
	<form action="${basePath}admin?method=updateGlobal" method="post">
	<table class="tablelist" style="width: 30%;min-width:500px; margin:20px">
		<thead>
			<tr>
				<th>变量</th>
				<th>取值</th>
			</tr>

		</thead>
	
				<tr>
					<td>后台任务间隔时间:</td>
					<td>
					<input name="task_interval" type="number" min="1" max="100" value="${global.task_interval}">（单位：s）
					</td>
				</tr>
				<tr>
					<td>分页查询记录条数:</td>
					<td><input name="record_number" type="number" min="5" max="200" value="${global.record_number}">（单位：条数）</td>
				</tr>
				<tr>
					<td>最早提前多久开始考试: </td>
					<td><input name="max_advance_time" type="number" min="1" max="1000" value="${global.max_advance_time}">（单位：min）</td>
				</tr>
				<tr>
					<td>学生上传文件下限:</td>
					<td><input name="min_file_size" type="number" min="1" max="1000" value="${global.min_file_size}">（单位：kb）</td>
				</tr>
				<tr>
					<td>学生上传文件上限:</td>
					<td><input name="max_file_size" type="number" min="1" max="1000" value="${global.max_file_size}">（单位：mb）</td>
				</tr>
				<tr>
					<td>教师可以清理和删除考试: </td>
					<td><input type="checkbox" id="can_clean"  ${global.teacher_can_clean==1?'checked':''} name="teacher_can_clean">（勾选代表可以）</td>
				</tr>
				<tr>
				<td colspan="2"><button type="submit" class="btn">修改</button></td>
				</tr>
				
	</table>
	</form>
</div>

</body>
<style>
.btn{
	background-color:#0089dd;
	border-radius:4px;
	color:#fff;
	border:0;
	margin:4px;
	padding:4px 15px;
}
.btn:hover{
	background-color:#3669cc;
	color:#fff;
}
</style>
</html>
