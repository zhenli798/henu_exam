<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title >功能介绍</title>
   <style>
	    ul, li {  
			list-style: disc;
	    }
        .css{
			width:20%; 
			height:350px;
			margin:10px;
			background:#E6E6FA;
			float: left;
        }
   </style>
</head>
<body>
    <ul class="css"  style="padding-right: 30px">
        <p></p>
        <strong style="margin-left: 20px; font-size: 18px">教师管理</strong>
        <p>
            <li>可以对教师用户进行增删改查操作，并且支持模糊查询</li>
        </p>
        <p>
            <li>系统可以有多个管理员</li >
        </p>
         <p>
            <li>系统管理员可以对老师进行重置密码</li >
        </p>
        <p>
            <li>默认密码为：123456</li>
        </p>
    </ul >
    
    <ul class="css" style="padding-right: 30px">
        <p>
            <strong style="margin-left: 20px; font-size: 18px">考试统计</strong>
        </p>
        <p>
            <li>各门科目的分数区间统计</li>
        </p>
        <p>
            <li>各门科目的及格率统计</li >
        </p>
        <p>
            <li>各门科目的成绩报表</li >
        </p>
    </ul >
    
    <ul class="css" style="padding-right: 30px">
        <p>
            <strong style="margin-left: 20px; font-size: 18px">系统相关</strong>    
        </p>
        <p> 
            <li>设置一些全局性的系统选项，包括后台任务的时间周期，分页查询时的每页记录数，手动开启考试的时间阈值，学生上传文件字数的有限范围等</li>
        </p>
        <p>
            <li>查看系统服务器的资源情况</li>
        </p>
    </ul>
</body>
</html>