<%@page contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
<meta charset="utf-8">
<script type="text/javascript" src="${basePath}static/echarts/echarts.min.js"></script>
</head>
<body style="height: 100%; margin: 0">
	<div id="container1" style="height: 45%; width: 48%; float: left;border: 1px solid #e1e1e1;margin-top: 10px;">
	</div>
	<div id="container2"  style="height: 45%; width: 48%; float: right;border: 1px solid #e1e1e1;margin-top: 10px;">
	</div>
	<div id="container3"  style="height: 45%; width: 48%; float: left;border: 1px solid #e1e1e1;margin-top: 10px;">
	</div>
	<div id="container4" style="height: 45%; width: 48%; float: right;border: 1px solid #e1e1e1;margin-top: 10px;">
	</div>
	<script type="text/javascript">
var dom = document.getElementById("container1");
var myChart = echarts.init(dom);
option1 = {
	title: {
        text: '及格率柱状图'
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
       		${temp.jgl},
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
        text: '及格率折线图'
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
       		${temp.jgl},
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



var dom3 = document.getElementById("container3");
var myChart3 = echarts.init(dom3);
option3 = {
	title: {
        text: '总分排行'
    },
	tooltip: {
        trigger: 'axis'
    },
    xAxis: {
        type: 'category',
        axisLabel: {
               interval:0,
              
           },
        data: [
        	<c:forEach items="${top5List}" var="temp">
       		'${temp.s_name}',
       		</c:forEach>
        ]
    },
    yAxis: {
        type: 'value'
    },
    series: [{
        data: [
        	<c:forEach items="${top5List}" var="temp">
       		${temp.sumx},
       		</c:forEach>
        ],
        type: 'bar',
        showBackground: true,
        backgroundStyle: {
            color: 'rgba(220, 220, 220, 0.8)'
        }
    }]
};
;
myChart3.setOption(option3, true);

var dom4 = document.getElementById("container4");
var myChart4 = echarts.init(dom4);
option4 = {
	title: {
        text: '及格率饼图'
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
       		${temp.jgl},
       		</c:forEach>
        ],
        type: 'pie',
        showBackground: true,
        backgroundStyle: {
            color: 'rgba(220, 220, 220, 0.8)'
        }
    }]
};
;
myChart4.setOption(option4, true);


</script>
</body>
</html>