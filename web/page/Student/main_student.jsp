<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
<meta charset="utf-8">
<script type="text/javascript" src="${basePath}static/echarts/echarts.min.js"></script>
</head>
<body style="height: 100%; margin: 0">
	<div id="container1" style="height: 70%; width: 48%; float: left;border: 1px solid #e1e1e1;margin-top: 50px;">
	</div>
	<div id="container2"  style="height: 70%; width: 48%; float: right;border: 1px solid #e1e1e1;margin-top: 50px;">
	</div>
	<script type="text/javascript">
var dom = document.getElementById("container1");
var myChart = echarts.init(dom);
option1 = {
	title: {
        text: '分数柱状图'
    },
	tooltip: {
        trigger: 'axis'
    },
    xAxis: {
        type: 'category',
        axisLabel: {
               interval:0,
               rotate:20
           },
        data: [
        	<c:forEach items="${list}" var="temp">
       		'${temp.e_name}',
       		</c:forEach>
        ]
    },
    yAxis: {
        type: 'value'
    },
    series: [{
        data: [
        	<c:forEach items="${list}" var="temp">
       		${temp.s_score},
       		</c:forEach>
        ],
        type: 'bar',
        showBackground: true,
        backgroundStyle: {
            color: 'rgba(220, 220, 220, 0.8)'
        }
    }]
};
myChart.setOption(option1, true);

var dom2 = document.getElementById("container2");
var myChart2 = echarts.init(dom2);
option2 = {
	title: {
        text: '分数折线图'
    },
	tooltip: {
        trigger: 'axis'
    },
    xAxis: {
        type: 'category',
        axisLabel: {
               interval:0,
               rotate:20
           },
        data: [
        	<c:forEach items="${list}" var="temp">
       		'${temp.e_name}',
       		</c:forEach>
        ]
    },
    yAxis: {
        type: 'value'
    },
    series: [{
        data: [
        	<c:forEach items="${list}" var="temp">
       		${temp.s_score},
       		</c:forEach>
        ],
        type: 'line',
        showBackground: true,
        backgroundStyle: {
            color: 'rgba(220, 220, 220, 0.8)'
        }
    }]
};
;
myChart2.setOption(option2, true);




</script>
</body>
</html>