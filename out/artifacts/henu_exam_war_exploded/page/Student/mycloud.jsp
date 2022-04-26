<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>列表 </title>
<link rel="stylesheet" href="${basePath}static/css/index.css" />
<link rel="stylesheet"
	href="${basePath}static/css/font-awesome-4.7.0/css/font-awesome.min.css" />
<script src="${basePath}static/js/jquery.min.js" type="text/javascript"></script>

</head>
<script type="text/javascript">
function search() {
	console.log("search");
	document.form1.action = "${basePath}myfile?method=list&msg=' '"
	document.form1.submit();
}
	$(
			
			function() {

				
				$(function() {
					$(".upfileBtn")
							.click(
									function() {
										var s_id = $(this).attr("s_id");
										$("#fileinp").trigger("click");
										$("#fileinp")
												.change(
														function(e) {
															if ($("#fileinp")
																	.val()) {
																console
																		.log("file:"
																				+ $(
																						"#fileinp")
																						.val());
																document.form3.action = "${basePath}upFile?s_id="
																		+ s_id;
																document.form3
																		.submit();
															}
														})

									})
				})
				$('.remove')
						.click(
								function(event) {
									event.stopPropagation()
									var f_id = $(this).attr("keyword");
									if (confirm("确定要删除此文件吗？")) {
										window.location.href = "${basePath}myfile?method=delete&f_id="
												+ f_id;
									}
								})
			})
</script>
<body>
	<p style="color: green; text-align: center;">
			<%
				if (request.getParameter("msg") != null) {
				out.print(request.getParameter("msg"));
			}
			%>
		</p>
	<div style="padding-left: 10px">
		<form name="form1" id="form1" method="post">
			<div class="condition">
				文件名称：<input type="text" name="f_name" size="15" max=30
					value="${file.f_name}">
				<button style="margin-left: 118px;" type="button" onclick="search()">
					<i class="fa fa-search"></i> 查询
				</button>
			</div>
		</form>
		<%-- 		<form action="${basePath}student?method=listMyExam" id="tableList"
			method="post">
			<input type="hidden" name="pageNo" value="${pageInfo.pageNo}">
			<input type="hidden" name="t_id" value="${exam2.s_id}">
		</form> --%>
		<table class="tablelist"
			style="width: 50%; min-width: 500px;">
			<thead>
				<tr>
					<th>名称</th>
					<th>上传时间</th>
					<th>操作</th>
				</tr>

			</thead>

			<c:forEach items="${pageInfo.list}" var="file">
				<tr>
					<td><a href="${basePath}download?filepath=${file.f_path}&filename=${file.f_name}">${file.f_name}</a></td>
					<td>${file.f_time}</td>
					<td>
						<button class="remove" keyword="${file.f_id}"  type="button"  >
							<i class="fa fa-remove"></i> 删除
						</button>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="3"><label for="fileinp">
						<button class="upfileBtn" type="button" s_id="${user.s_id}">上传文件</button>
				</label></td>
			</tr>
		</table>
		<form style="display: none;" name="form3" action="" method="post"
			enctype="multipart/form-data">
			<input type="file" name="q_name" id="fileinp">
		</form>



		<%@include file="../inc/page.jsp"%>
	</div>
</body>

</html>
