<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="${basePath}static/js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
//session 里面有 exam,question
$(function(){
	$("#fileinp").change(function () {
		var file = $("#fileinp").val();
		 var pos=file.lastIndexOf("\\");//查找最后一个\的位置
	      //截取最后一个\位置到字符长度，也就是截取文件名 
	        $("#text").html(file.substring(pos+1));
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
	<form action="${basePath}updateExam" method="post" enctype="multipart/form-data">
	<table class="tablelist" style="width: 30%;min-width:500px; margin:20px">
		<thead>
			<tr>
				<th>项目</th>
				<th>内容</th>
			</tr>

		</thead>
	
				<tr>
					<td>考试名称:</td>
					<td>
					<input name="e_name" type="text" min="1" max="100"size="25"value="${exam.e_name}">
					</td>
				</tr>
				<tr>
					<td>开始时间:</td>
					<td><input  name="e_starttime" type="datetime-local" value="${exam.e_starttime}"></td>
				</tr>
				<tr>
					<td>结束时间: </td>
					<td><input name="e_stoptime" type="datetime-local" value="${exam.e_stoptime}"></td>
				</tr>
				<tr>
					<td>是否自动开始:</td>
					<td>
					<input name="e_autostart"  ${exam.e_autostart==1?'checked':''}  type="checkbox">
					(选中表示自动开始)</td>
				</tr>
				<tr>
					<td>上传试卷:</td>
					
					<td>
						<label for="fileinp">
					        <button type="button" id="btn">点我上传</button>
					        <span id="text">${exam.q_name==null ? "未上传试题" : exam.q_name}
					        </span>
							<input type="file" name="q_name" id="fileinp">
						</label>
						<a href="${basePath}download?filepath=${exam.q_path}&filename=${exam.q_name}">下载</a>
					</td>
					
				</tr>
				<tr>
					<td colspan="2"><button type="submit" class="btn">修改</button></td>
				</tr>
				
	</table>
	<input type="file"  id="fileinp">
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
.tablelist{
	margin-top: 10px;
	width: 100%;
	border: 1px solid #e0e0e0;
	background-color: #FFFFFF;
	border-collapse: collapse;
}
.tablelist td,th{
	height: 30px;
	border: 1px solid #e0e0e0;
}
.tablelist th{
	background-color: #F0F0F0;
}
.tablelist td{
	padding: 0px 4px;
	text-align:center;
}

.tablelist tr:nth-child(odd){
	background-color: #FFFFFF;
}

.tablelist tr:nth-child(even){
	background-color: #F8F8F8;
}
.tablelist tr:hover{
	background-color: #F2F7FF;
}


/* 上传文件按钮部分 */
label{
    position: relative;
}
#fileinp{
    position: absolute;
    right: 0;
    top: 0;
    opacity: 0;
}
#text{
font-size: small;
}
</style>
</body>
</html>