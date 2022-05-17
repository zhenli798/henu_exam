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
                                   //评分
									var s_scoreInput = '.s_scoreInput.'
											+ $(this).attr("keyword");
									console.log(s_scoreInput)
									var s_score = $(s_scoreInput).val();
									
									//评语
									var s_commentInput = '.s_commentInput.'
										+ $(this).attr("keyword");
									console.log(s_commentInput)
									var s_comment = $(s_commentInput).val();
									
									//提交
									if(s_score==null||s_score==""){
										window.confirm("请输入分数！")
									}else{
										window.location.href = "${basePath}exam?method=editScore&s_i="
											+ $(this).attr("keyword")
											+ "&s_score="+s_score+"&s_comment="+s_comment;
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


		</div>
	</form>
	<form action="${basePath}exam?method=listScore" id="tableList"
		method="post">
		<input type="hidden" name="pageNo" value="${pageInfo.pageNo}">
		<input type="hidden" name="e_id" value="${student.e_id}"> <input
			type="hidden" name="s_id" value="${student.s_id}"> <input
			type="hidden" name="s_name" value="${student.s_name}"> <input
			type="hidden" name="s_class" value="${student.s_class}">
	</form>
	<table class="tablelist" style="width: 97%;min-width:500px; margin:20px">
		<thead>
			<tr>
				<th>学号</th>
				<th>姓名（班级）</th>
				<th>答卷</th>
				<th>分数</th>
				<th>评语</th>
				<th>操作</th>
			</tr>

		</thead>

		<c:forEach items="${pageInfo.list}" var="student">
			<tr>
				<td>
					<p > ${student.s_id}</p>
					
				</td>
				<td>
					<p>${student.s_name}（${student.s_class}）</p> 
				
					
					<!-- 文件 -->
					<td>
						<a href="${basePath}download?filepath=${student.s_fpath}&filename=${student.s_fname}">
							${student.s_fname}
						</a>
					</td>
					
					<!--分数  -->
					<td ><input required="required"
					class="input s_scoreInput ${student.s_i}" name="s_score" type="number" max=100 min=0
					style="display: none;" value="${student.s_score}">
					<p class="p ${student.s_i}">${student.s_score}
					</p>
					</td>
					
					<!--评语  -->
					<td ><input
					class="input s_commentInput ${student.s_i}" name="s_comment" type="text" 
					style="display: none;" value="${student.s_comment}">
					<p class="p ${student.s_i}">${student.s_comment}
					</p>
					</td>
				
					
				<td class="optionTd">
					<button class="edit toEdit ${student.s_i}" keyword="${student.s_i}">
						<i class="fa fa-edit"></i> 录入分数
					</button>
					<button class="edit doEdit ${student.s_i}" style="display: none;"
						keyword="${student.s_i}">
						<i class="fa fa-upload"></i> 确定录入
					</button>
				</td>

			</tr>

		</c:forEach>
	</table>
	<%@include file="../inc/page.jsp"%>

</body>

</html>
