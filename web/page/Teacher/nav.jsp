<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-M/bootstrap/4.5.3/css/bootstrap.min.css"
          >

    <link rel="stylesheet" href="${basePath}static/css/nav.css" ></link>
	<link rel="stylesheet" href="${basePath}static/css/font-awesome-4.7.0/css/font-awesome.min.css" />
	<script src="${basePath}static/js/jquery.min.js" type="text/javascript"></script>
  	<script src="${basePath}static/js/nav.js" type="text/javascript"></script>
    <script src="https://lf6-cdn-tos.bytecdntp.com/cdn/expire-1-M/bootstrap/4.5.3/js/bootstrap.min.js"
           ></script>
</head>
<body>
    <nav class="navbar navbar-expand navbar-mainbg">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <i class="fas fa-bars text-white"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <div class="hori-selector"><div class="left"></div><div class="right"></div></div>
                <li class="nav-item active">
                    <a target="subFrame" href="${basePath}page/Exam/editExam.jsp" class="nav-link"><i class="fa fa-edit"></i>考试编辑</a>
                </li>
               <li class="nav-item">
                    <a target="subFrame"  href="${basePath}exam?method=listStudent" class="nav-link"><i class="fa fa-address-book-o"></i>考生管理</a>
                </li>
                <li class="nav-item ">
                    <a target="subFrame" href="${basePath}notice?method=listNotice"class="nav-link"><i class="fa fa-commenting-o"></i>通知管理</a>
                </li>
               <li class="nav-item">
                    <a target="subFrame" href="${basePath}exam?method=listScore" class="nav-link"><i class="fa fa-graduation-cap"></i>评分管理</a>
                </li>
             <!--    <li class="nav-item">
                    <a class="nav-link"><i class="fa fa-bar-chart-o"></i>成绩统计</a>
                </li> -->
            </ul>
        </div>
    </nav>
    <div class="main">

    <iframe name="subFrame" src="${basePath}page/Exam/editExam.jsp"
			width="100%" height="100%" frameborder="0px"></iframe>
	</div>
</body>

</html>