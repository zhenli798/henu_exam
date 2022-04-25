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
        <strong style="margin-left: 20px; font-size: 18px">所有考试列表</strong>
        <p>
            <li>教师可以对考试进行增删改查操作（支持模糊查询）</li>
        </p>
        <p>
            <li>老师上传试卷，设置考试试卷，导入学生名单xlsx文件</li >
        </p>
        <p>
            <li>老师对考试添加通知，下载打包学生上传的试卷</li>
        </p>
          <p>
            <li>老师给学生提交的考卷/作业进行评分</li>
        </p>
    </ul >
    
    <ul class="css" style="padding-right: 30px">
        <p>
            <strong style="margin-left: 20px; font-size: 18px">成绩统计</strong>
        </p>
        <p>
            <li>此老师创建的考试的分数段人数统计</li>
        </p>
        <p>
            <li>此老师创建的考试的及格率统计</li >
        </p>
    </ul >
    
    <ul class="css" style="padding-right: 30px">
        <p>
            <strong style="margin-left: 20px; font-size: 18px">其他功能</strong>    
        </p>
        <p> 
            <li>支持一键切换管理员身份（如果该老师具有管理员资格）</li>
        </p>
        <p>
            <li>修改自己的密码，查看自己的个人信息</li>
        </p>
    </ul>
</body>
</html>