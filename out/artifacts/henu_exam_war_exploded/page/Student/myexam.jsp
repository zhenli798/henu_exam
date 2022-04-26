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
		document.form1.action = "${basePath}student?method=listMyExam"
		document.form1.submit();
	}
	
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
	    fn("时间到，已结束!"); 
	   }  
	  }, 1000); 
	 } 
	
	  
	$(function(){  
		console.log("test2");
		$(".stoptimeDiv").show(function(){
			var s_i = $(this).attr("s_i"); 
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
	    	document.getElementById(s_i).innerHTML = msg;  
		}) 
		})
	})
	
	$(function(){  
		$(".upfileBtn").click(function(){
			var stoptime= new Date($(this).attr("stoptime")).getTime(); 
			var starttime = new Date($(this).attr("starttime")).getTime();
			var nowtime = new Date().getTime();
			console.log(stoptime+" "+nowtime);
			if(nowtime>starttime && nowtime<stoptime){
				var s_i = $(this).attr("s_i");
				var e_id = $(this).attr("e_id");
				$("#fileinp").trigger("click");
				$("#fileinp").change(function(e){
					if($("#fileinp").val()){
						console.log("file:"+$("#fileinp").val());
						document.form3.action = "${basePath}upAnswer?s_i="+s_i+"&e_id="+e_id;
						document.form3.submit(); 
					}
				})
				
			}else if(starttime<nowtime){
				confirm("考试尚未开始");
			}else if(nowtime>stoptime){
				confirm("考试已经结束");
			}
			
			
		})
	})
	


</script>
<body>

	<div style="padding-left: 10px">
		<form name="form1" id="form1" method="post">
			<div class="condition">
				考试名称：<input type="text" name="e_name" size="15" max=30
					value="${exam.e_name}">
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
		<table class="tablelist">
			<thead>
				<tr>
					<th>名称</th>
					<th>开始</th>
					<th>距离结束</th>
					<th>试卷</th>
					<th>答卷</th>
					<th>得分</th>
					<th>评论</th>
				</tr>

			</thead>

			<c:forEach items="${pageInfo.list}" var="exam2">
				<tr>
					<td>${exam2.e_name}</td>
					<td style="font-size: 12px;">${exam2.e_starttime}</td>
					<td style="font-size: 12px;">
						<div style="color:red;font-size:12px;" class="stoptimeDiv" id="${exam2.s_i}" s_i="${exam2.s_i}"
							stoptime="${exam2.e_stoptime}"></div>
					</td>
					<td><a
						href="${basePath}download?filepath=${exam2.q_path}&filename=${exam2.q_name}">${exam2.q_name}</a></td>
					<td><a
						href="${basePath}download?filepath=${exam2.s_fpath}&filename=${exam2.s_fname}">${exam2.s_fname}</a>
						<label for="fileinp">
							<button class="upfileBtn" type="button" e_id="${exam2.e_id}" starttime="${exam2.e_starttime}" stoptime="${exam2.e_stoptime}"
								s_i="${exam2.s_i}">上传(覆盖)</button>
					</label></td>
					<td>${exam2.s_score}</td>
					<td>${exam2.s_comment}</td>

				</tr>
			</c:forEach>
		</table>
		<form style="display: none;" name="form3" action="" method="post"
			enctype="multipart/form-data">
			<input type="file" name="q_name" id="fileinp">
		</form>


		<%@include file="../inc/page.jsp"%>
		<%@include file="mynotice.jsp" %>
	</div>
	
</body>

</html>
