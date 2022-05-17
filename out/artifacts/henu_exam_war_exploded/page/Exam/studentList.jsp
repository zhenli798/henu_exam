<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>列 表</title>
<link rel="stylesheet" href="${basePath}static/css/index.css" />
<link rel="stylesheet"
	href="${basePath}static/css/font-awesome-4.7.0/css/font-awesome.min.css" />
<script src="${basePath}static/js/jquery.min.js" type="text/javascript"></script>

</head>
<script type="text/javascript">
	function search() {
		console.log("search");
		document.form1.action = "${basePath}exam?method=listStudent"
		document.form1.submit();
	}
	function add() {
		var e_id = $('input[name="e_id"]').val();
		var s_name = $('input[name="s_name"]').val();
		var s_class = $('input[name="s_class"]').val();
		console.log(e_id, s_name, s_class);

		if (e_id != "" && s_name != "" && s_class != "") {
			document.form1.action = "${basePath}exam?method=add";
			document.form1.submit();
		} else {
			confirm("您还未输入要添加的信息");
		}
	}
	$(function() {
		$('.remove')
				.click(
						function() {
							var s_i = $(this).attr("keyword");
							if (confirm("确定要删除此考生吗？")) {
								window.location.href = "${basePath}exam?method=delete&s_i="
										+ s_i;

							}
						})
	})

	$(function() {
		$('.toEdit').click(function() {
			var p = '.p.' + $(this).attr("keyword");
			var input = '.input.' + $(this).attr("keyword");
			var toEditBtn = '.toEdit.' + $(this).attr("keyword");
			var doEditBtn = '.doEdit.' + $(this).attr("keyword");
			$(p).hide();
			$(toEditBtn).hide();
			$(input).show();
			$(doEditBtn).show();
		})
	})
	$(
			function() {
				$('.doEdit')
						.click(
								function() {

									var s_idInput = '.s_idInput.'
											+ $(this).attr("keyword");
									var s_nameInput = '.s_nameInput.'
											+ $(this).attr("keyword");
									var s_classInput = '.s_classInput.'
											+ $(this).attr("keyword");

									var s_id = $(s_idInput).val();
									var s_name = $(s_nameInput).val();
									var s_class = $(s_classInput).val();
									
									if (confirm("确定修改此考生吗？")) {
										console.log("update");
										window.location.href = "${basePath}exam?method=update&s_i="
												+ $(this).attr("keyword")
												+ "&s_id="+ s_id
												+ "&s_name="+s_name
												+ "&s_class=" + s_class;
									} else {
										confirm("请补全您要修改的信息！");
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




	<form name="form1" id="form1" method="post">
		<div class="condition">
			<input type="hidden" name="e_id" value="${exam.e_id}"> 学号：<input
				type="text" name="s_id" size="15" value="${student.s_id}">
			姓名：<input type="text" name="s_name" size="15"
				value="${student.s_name}"> 班级：<input type="text" size="15"
				name="s_class" value="${student.s_class}">
			<button type="button" onclick="search()">
				<i class="fa fa-search"></i> 查询
			</button>
			<button type="button" onclick="add()">
				<i class="fa fa-plus"></i> 新增
			</button>


		</div>
	</form>
	<div class="condition">
	<form action="${basePath}readXlsx" method="post" enctype="multipart/form-data"> 
		<input type="file" name="studentXlsx" required="required">
		<button type="submit" >导入</button> 学生名单（学号，姓名，班级）
	</form> 
	</div>
	<form action="${basePath}exam?method=listStudent" id="tableList"
		method="post">
		<input type="hidden" name="pageNo" value="${pageInfo.pageNo}">
		<input type="hidden" name="e_id" value="${student.e_id}"> <input
			type="hidden" name="s_id" value="${student.s_id}"> <input
			type="hidden" name="s_name" value="${student.s_name}"> <input
			type="hidden" name="s_class" value="${student.s_class}">
	</form>
	<table class="tablelist">
		<thead>
			<tr>
				<th>学号</th>
				<th>姓名</th>
				<th>班级</th>
				<th width="120px">操作</th>
			</tr>

		</thead>

		<c:forEach items="${pageInfo.list}" var="student">
			<tr>
				<td style="width: 20%;">
					<p class="p ${student.s_i}"> ${student.s_id}</p>
					<input class="input s_idInput ${student.s_i}" size="12" required
						type="text" name="s_name" style="display: none;"
						value="${student.s_id}">
				</td>
				<td style="width: 20%;">
					<p class="p ${student.s_i}">${student.s_name}</p> 
					<input
					class="input s_nameInput ${student.s_i}" type="text" size="12" required
					name="s_name" style="display: none;" 
					value="${student.s_name}">
				</td>
				<td style="width: 20%;"><input
					class="input s_classInput ${student.s_i}" name="s_class" size="12" required
					style="display: none;" value="${student.s_class}">
					<p class="p ${student.s_i}">${student.s_class}</p></td>
				<td class="optionTd">
					<button class="edit toEdit ${student.s_i}" keyword="${student.s_i}">
						<i class="fa fa-edit"></i> 修改
					</button>
					<button class="edit doEdit ${student.s_i}" style="display: none;"
						keyword="${student.s_i}">
						<i class="fa fa-upload"></i> 确定修改
					</button>
					<button class="remove" keyword="${student.s_i}">
						<i class="fa fa-remove"></i> 删除
					</button>
				</td>

			</tr>

		</c:forEach>
	</table>
	<%@include file="../inc/page.jsp"%>

</body>

</html>
