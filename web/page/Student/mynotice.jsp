
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>通知</title>
<script src="${basePath}static/js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
	/*第一次读取最新通知*/
	setTimeout(function() {
		Push();
		console.log("push()...")
	}, 200);
	/*1轮询读取函数*/
	setInterval(function() {

		Push();
		console.log("push()...")

	}, 30000);

	function Push() {
		$.ajax({
			//type: "POST",
			url : "${basePath}/StudentNoticeServlet", //获取链接
			data : {
			//    e: 3 //传递的参数这里我没有传递
			},
			async : true, //异步获取
			dataType : 'json',
			success : function(data) {
				console.log(data);
				var html = "";
				for (var i = 0; i < data.length - 1; i++) {
					html += "<tr>" + "<td>" + data[data.length - 1].n_text + //这里直接调用e_id属性获取到相应的getE_id方法，如果现实考试名的话根据vo类里的更改为e_name即可下面依次
					"</td><td>" + data[i].n_time + "</td><td>" + data[i].n_text
							+ "</td>></tr>";

				}

				$("#content").html(html);
			}

		});
	};
</script>
<style>
#test2 tr td {
	width: 200px;
	color: red;
}
</style>
</head>
<body>
	<div id="test"
		style="width: 500px; height: 200px; overflow: auto; right: 0px; position: fixed; bottom: 0px; background: opacity:1;">
		<table id="test2">

			<tbody id="content">
			</tbody>
		</table>
	</div>
</body>

</html>