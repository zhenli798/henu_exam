<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>列表</title>
<link rel="stylesheet" href="${basePath}static/css/index.css" />
<link rel="stylesheet"
	href="${basePath}static/css/font-awesome-4.7.0/css/font-awesome.min.css" />
<script src="${basePath}static/js/jquery.min.js" type="text/javascript"></script>

</head>
<script type="text/javascript">
	function search() {
		console.log("search");
		document.form1.action = "${basePath}admin?method=list"
		document.form1.submit();
	}
	function add() {
		var t_id = $('input[name="t_id"]').val();
		var t_name = $('input[name="t_name"]').val();
		var t_isadmin = $('input[name="t_isadmin"]').val();
		console.log(t_id, t_name, t_isadmin);

		if (t_id != "" && t_name != "" && t_isadmin != "") {
			document.form1.action = "${basePath}admin?method=add";
			document.form1.submit();
		} else {
			confirm("您还未输入要添加的信息");
		}
	}
	$(function() {
		$('.remove').click(function() {
			var id = $(this).attr("keyword");
			if (confirm("确定要删除"+id+"吗？")) {
				window.location.href = "${basePath}admin?method=delete&t_id="
						+id;
				
			}
		})
	})
	$(function() {
		$('.resetPwd').click(function() {
			var id = $(this).attr("keyword");
			if (confirm("确定要重置"+id+"的密码吗？")) {
				window.location.href = "${basePath}admin?method=resetPwd&t_id="
						+id
						+"&t_pwd=123456";
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
	$(function() {
		$('.doEdit').click(function() {
			
			var t_isadminInput = '.t_isadminInput.' + $(this).attr("keyword");
			var t_nameInput = '.t_nameInput.' + $(this).attr("keyword");

			var t_isadmin = $(t_isadminInput).val();
			var t_name = $(t_nameInput).val();

			if (t_name != "" && t_isadmin != "") {
				console.log("update");
				window.location.href="${basePath}admin?method=update&t_id="+$(this).attr("keyword")
						+"&t_name="+t_name
						+"&t_isadmin="+t_isadmin;
			} else {
				confirm("请补全您要修改的信息！");
			}
		})
	})

</script>
<body>
<p style="color:green;text-align: center;">
<%
if(request.getParameter("msg")!=null){
	out.print(request.getParameter("msg"));
}
%>
</p>




	<form name="form1" id="form1" method="post">
		<div class="condition">
			工号：<input type="text" name="t_id" size="8" value="${teacher.t_id}">
			姓名：<input type="text" name="t_name" size="8"
				value="${teacher.t_name}"> 管理：<input type="number" min="0" max="1"
				name="t_isadmin"  value="${teacher.t_isadmin}">
			<button type="button" onclick="search()">
				<i class="fa fa-search"></i> 查询
			</button>
			<button type="button" onclick="add()">
				<i class="fa fa-plus"></i> 新增
			</button>
			（默认密码：123456）

		</div>
	</form>
	<form action="${basePath}admin?method=list" id="tableList"
		method="post">
		<input type="hidden" name="pageNo" value="${pageInfo.pageNo}">
		<input type="hidden" name="t_id" value="${teacher.t_id}"> <input
			type="hidden" name="t_name" value="${teacher.t_name}"> <input
			type="hidden" name="t_isadmin" value="${teacher.t_isadmin}">
	</form>
	<table class="tablelist">
		<thead>
			<tr>
				<th>工号</th>
				<th>姓名</th>
				<th>管理</th>
				<th width="120px">操作</th>
			</tr>

		</thead>

		<c:forEach items="${pageInfo.list}" var="teacher">
			<tr>
				<td style="width: 20%;">
				${teacher.t_id}</td>
				<td style="width: 20%;">
					<p class="p ${teacher.t_id}">${teacher.t_name}</p> <input
					class="input t_nameInput ${teacher.t_id}" type="text" name="t_name"
					style="display: none;" size="9" value="${teacher.t_name}">
				</td>
				<td style="width: 20%;"><input
					class="input t_isadminInput ${teacher.t_id}" type="number" min="0" max="1"
					name="t_isadmin" style="display: none;" 
					value="${teacher.t_isadmin}">
					<p class="p ${teacher.t_id}">${teacher.t_isadmin}</p></td>
				<td class="optionTd">
					<button class="edit toEdit ${teacher.t_id}" 
						keyword="${teacher.t_id}">
						<i class="fa fa-edit"></i> 修改
					</button>
					<button class="edit doEdit ${teacher.t_id}" style="display: none;"
						 keyword="${teacher.t_id}">
						<i class="fa fa-upload"></i> 确定修改
					</button>
					<button class="remove" keyword="${teacher.t_id}">
						<i class="fa fa-remove"></i> 删除
					</button>
					<button class="resetPwd" keyword="${teacher.t_id}">
						<i class="fa fa-refresh"></i> 重置密码
					</button>
				</td>
				
			</tr>
			
		</c:forEach>
	</table>
	<%@include file="../inc/page.jsp"%>

</body>

</html>
