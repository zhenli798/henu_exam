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
		document.form1.action = "${basePath}teacher?method=list"
		document.form1.submit();
	}
	function add() {
		var e_name = $('input[name="e_name"]').val();
		var e_starttime = $('input[name="e_starttime"]').val();
		var e_stoptime = $('input[name="e_stoptime"]').val();
		var e_autostart = $('input[name="e_autostart"]').val();

		console.log(e_name, e_starttime, e_stoptime, e_autostart);

		if (e_name != "" && e_starttime != "" && e_stoptime != "") {
			document.form1.action = "${basePath}teacher?method=add";
			document.form1.submit();
		} else {
			confirm("您还未输入要添加的信息");
		}
	}
	$(function() {
		$('.remove')
				.click(
						function(event) {
							event.stopPropagation()
							var id = $(this).attr("keyword");
							if (confirm("确定要删除此考试吗？")) {
								window.location.href = "${basePath}teacher?method=delete&e_id="
										+ id;
							}
						})
	})
	$(
			function() {
				$(".examline")
						.click(
								function() {
									var e_id = $(this).attr("e_id");//进入exam servlet进行操作。
									window.location.href = "${basePath}exam?method=detail&e_id="
											+ e_id;
								})
			})
			
			 function countDown( maxtime,fn ) {  
	  var timer = setInterval(function() { 
	    if(maxtime>0 ){  
	     var day = Math.floor(maxtime / 86400),
	     hour = Math.floor((maxtime % 86400) / 3600),
	    minutes = Math.floor((maxtime % 3600) / 60), 
	    seconds = Math.floor(maxtime%60), 
	    msg = day+"天"+hour+"时"+minutes+"分"+seconds+"秒";  
	    fn( msg ); 
	    --maxtime;  
	   } else {  
	    clearInterval( timer ); 
	    fn("已结束!"); 
	   }  
	  }, 1000); 
	 } 
	
	  
	$(function(){  
		console.log("test2");
		$(".stoptimeDiv").show(function(){
			var e_id = $(this).attr("e_id"); 
			var stoptime = $(this).attr("stoptime");
			 //获取当前时间  
	        var date = new Date();  
	        var now = date.getTime();  
	        console.log("now",now);
	      //设置截止时间 
			var endDate = new Date(stoptime); 
	        var end = endDate.getTime(); 
	        
	        var stoptime= $(this).attr("stoptime"); 
	        //时间差  
	
	        var leftTime = (end-now)/1000; 
	        console.log(leftTime);
	       countDown( leftTime,function( msg ) { 
	    	document.getElementById(e_id).innerHTML = msg;  
		}) 
		})
	})
	$(function(){  
		$(".statusTd1").show(function(){
			var e_id = $(this).attr("e_id"); 
			var stoptime = new Date($(this).attr("stoptime")).getTime();
			var starttime = new Date($(this).attr("starttime")).getTime();
			var nowtime = new Date().getTime();
			console.log("time:", stoptime," ",starttime," ",nowtime);
			 //获取当前时间  
			 var td1 = ".statusTd1."+e_id
			 var td2= ".statusTd2."+e_id
			 console.log(td1);
			 console.log(td2);
	        if(nowtime<starttime){
	        	$(td1).text("未开始");
	        	$(td2).text("暂无文件");
	        	
	        }else if(nowtime<stoptime){
	        	$(td1).text("进行中...");
	        	$(td2).text("收集中...");
	        }else{
	        	$(td1).text("已结束");
	        	//$(".downBtn."+e_id).show();
	        	//$(btn).html('');
	        	//$(btn).html('<button type="button" onclick="downZip()">打包下载</button>');
	        }
		}) 
	})
	$(function() {
		$('.downBtn')
				.click(
						function() {
							event.stopPropagation();
							console.log(this)
							var e_id = $(this).attr("e_id");
							var e_name = $(this).attr("e_name");
							console.log(e_id);
							console.log(e_name);
							window.location.href = 'zip?e_name='+e_name+"&e_id="+e_id;
						})
	})

</script>
<body>

	<div style="padding-left: 10px">
		<p style="color: green; text-align: center;">
		${msg }
			<%
				if (!request.getParameter("msg").equals("null")&&!request.getParameter("msg").equals("")) {
				out.print(request.getParameter("msg"));
			}
			%>
		</p>
		<form name="form1" id="form1" method="post">
			<div class="condition">
				<p style="padding: 6px 0;">
					开始时间：<input type="datetime-local" name="e_starttime" value="">

					结束时间：<input type="datetime-local" name="e_stoptime" value="">
				</p>
				考试名称：<input type="text" name="e_name" size="15" max=30
					value="${exam.e_name}"> 自动开始：<input type="checkbox" value=1
					${exam.e_autostart==1?'checked':''} name="e_autostart"> <input
					type="hidden" name="t_id" value="${user.t_id}" />

				<button style="margin-left: 118px;" type="button" onclick="search()">
					<i class="fa fa-search"></i> 查询
				</button>
				<button type="button" onclick="add()">
					<i class="fa fa-plus"></i> 新增
				</button>
			</div>
		</form>
	<%-- 	<form action="${basePath}teacher?method=list" id="tableList"
			method="post">
			<input type="hidden" name="pageNo" value="${pageInfo.pageNo}">
			<input type="hidden" name="t_id" value="${exam.t_id}">
		</form> --%>
		<table class="tablelist">
			<thead>
				<tr>
					<th>名称</th>
					<th>距离开始时间</th>
					<th>距离结束时间</th>
					<th>试卷</th>
					<th>自动开始</th>
					<th>考试状态</th>
					<!--待开始，进行中，已结束  -->
					<th>归档下载</th>
					<!--待下载，待清理，  -->
					<th>编辑考试</th>
				</tr>

			</thead>

			<c:forEach items="${pageInfo.list}" var="exam">
				<tr class="examline" e_id="${exam.e_id}">
					<td>${exam.e_name}</td>
					<td style="font-size: 12px;">${exam.e_starttime}</td>
					<td style="font-size: 12px;">
					<div style="color:purple;font-size:12px;" class="stoptimeDiv" id="${exam.e_id}" e_id="${exam.e_id}"
							stoptime="${exam.e_stoptime}"></div>
					</td>
					<td><a
						href="${basePath}download?filepath=${exam.q_path}&filename=${exam.q_name}">${exam.q_name}</a></td>
					<td>${exam.e_autostart}</td>
					<td class="statusTd1 ${exam.e_id}" e_id="${exam.e_id}" starttime="${exam.e_starttime}"
							stoptime="${exam.e_stoptime}"></td>
					<td class="statusTd2 ${exam.e_id}">
					
					<button type="button" class="downBtn" e_name="${exam.e_name}" e_id="${exam.e_id}">打包下载</button>
					</td>
					
					<td>
						<button class="remove" type="button" keyword="${exam.e_id}">
							<i class="fa fa-remove"></i> 删除
						</button>
					</td>
				</tr>
			</c:forEach>
		</table>
		<%@include file="../inc/page.jsp"%>
	</div>
</body>

</html>
