<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet"
	href="${basePath}static/css/font-awesome-4.7.0/css/font-awesome.min.css" />
<script src="${basePath}static/js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
	//session  里面有exam,question

	$(function() {
		$('.remove')
				.click(
						function() {
							var id = $(this).attr("keyword");
							if (confirm("确定要删除" + id + "吗？")) {
								window.location.href = "${basePath}notice?method=delete&n_id="
										+ id;

							}
						})
	})
</script>
<body>
	<div>
		<p style="color: green; text-align: center;">
			<%
				if (request.getParameter("msg") != null) {
				out.print(request.getParameter("msg"));
			}
			%>
		</p>
		<h3 style="text-align: center; background-color: #ddd;border-radius: 10px;padding:5px;">本场考试：${exam.e_name}</h3>
		<table class="tablelist"
			style="width: 30%; min-width: 500px; margin: 20px">
			<thead>
				<tr>
					<th>时间</th>
					<th>内容</th>
					<th>操作</th>
				</tr>

			</thead>
			<c:forEach items="${noticeList}" var="notice">
				<tr>
					<td style="font-size: 12px;">${notice.n_time}</td>
					<td>${notice.n_text}</td>
					<td>
						<button class="remove" keyword="${notice.n_id}">
							<i class="fa fa-remove"></i> 删除
						</button>
					</td>
				</tr>
			</c:forEach>

			<tr>

				<td colspan="3"><form action="${basePath}notice?method=add" method="post">
						<textarea cols=40 rows=5 maxlength=200 required name="n_text"
							placeholder="请输入您要发送的通知内容..."></textarea>
						<button type="submit" class="btn">发送</button>
					</form></td>

			</tr>

		</table>

	</div>

</body>
<style>
.btn {
	background-color: #0089dd;
	border-radius: 4px;
	color: #fff;
	border: 0;
	margin: 4px;
	padding: 4px 15px;
}

.btn:hover {
	background-color: #3669cc;
	color: #fff;
}

.tablelist {
	margin-top: 10px;
	width: 100%;
	border: 1px solid #e0e0e0;
	background-color: #FFFFFF;
	border-collapse: collapse;
}

.tablelist td, th {
	height: 30px;
	border: 1px solid #e0e0e0;
}

.tablelist th {
	background-color: #F0F0F0;
}

.tablelist td {
	padding: 0px 4px;
	text-align: center;
}

.tablelist tr:nth-child(odd) {
	background-color: #FFFFFF;
}

.tablelist tr:nth-child(even) {
	background-color: #F8F8F8;
}

.tablelist tr:hover {
	background-color: #F2F7FF;
}

/* 上传文件按钮部分 */
label {
	position: relative;
}

#fileinp {
	position: absolute;
	right: 0;
	top: 0;
	opacity: 0;
}

#text {
	font-size: small;
}
</style>
</body>
</html>