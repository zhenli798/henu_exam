<%@page contentType="text/html; charset=utf-8"%>
<!doctype html>
<html>
<head>

<title></title>
<link href="https://fonts.googleapis.com/css?family=Muli&display=swap"
	rel="stylesheet">

<link rel="stylesheet" type="text/css"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<style>
.b-skills {
	border-top: 1px solid #f9f9f9;
	padding-top: 10px;
	text-align: center;
}

.b-skills:last-child {
	margin-bottom: -30px;
}

.b-skills h2 {
	margin-bottom: 50px;
	font-weight: 900;
	text-transform: uppercase;
}

.skill-item {
	position: relative;
	max-width: 250px;
	width: 100%;
	margin-bottom: 30px;
	color: #555;
}

.chart-container {
	position: relative;
	width: 100%;
	height: 0;
	padding-top: 100%;
	margin-bottom: 27px;
}

.skill-item .chart, .skill-item .chart canvas {
	position: absolute;
	top: 0;
	left: 0;
	width: 100% !important;
	height: 100% !important;
}

.skill-item .chart:before {
	content: "";
	width: 0;
	height: 100%;
}

.skill-item .chart:before, .skill-item .percent {
	display: inline-block;
	vertical-align: middle;
}

.skill-item .percent {
	position: relative;
	line-height: 1;
	font-size: 40px;
	font-weight: 900;
	z-index: 2;
}

.skill-item  .percent:after {
	content: attr(data-after);
	font-size: 20px;
}

p {
	font-weight: 900;
}
</style>
</head>
<script type="text/javascript">




</script>
<body>
	<section id="s-team" class="section">

		<div class="b-skills">
			<div class="container">
				<h2>资源占用率</h2>
				<div class="row">
					<div class="col-xs-12 col-sm-6 col-md-4">
						<div class="skill-item center-block">
							<div class="chart-container">
								<div class="chart r1" data-percent="50" data-bar-color="#23afe3">
									<span class="percent sr1" data-after="%">50</span>
								</div>
							</div>
							<p>CPU</p>
						</div>
					</div>
					<div class="col-xs-12 col-sm-6 col-md-4">
						<div class="skill-item center-block">
							<div class="chart-container">
								<div class="chart r2" data-percent="60" data-bar-color="#a7d212">
									<span class="percent sr2" data-after="%">60</span>
								</div>
							</div>

							<p>内存</p>
						</div>
					</div>

					<div class="col-xs-12 col-sm-6 col-md-4">
						<div class="skill-item center-block">
							<div class="chart-container">
								<div class="chart r3" data-percent="70" data-bar-color="#ff4241">
									<span class="percent sr3" data-after="%">70</span>
								</div>
							</div>

							<p>硬盘</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script src="${basePath}static/js/jquery-2.2.4.min.js"></script>
	<script src="${basePath}static/js/jquery.appear.min.js"></script>
	<script src="${basePath}static/js/jquery.easypiechart.min.js"></script>

	<script>
		'use strict';

		var $window = $(window);

		function run() {
			var fName = arguments[0], aArgs = Array.prototype.slice.call(
					arguments, 1);
			try {
				fName.apply(window, aArgs);
			} catch (err) {

			}
		};

		/* chart
		 ================================================== */
		function _chart() {
			$('.b-skills')
					.appear(
							function() {
								setTimeout(
										function() {
											$('.chart')
													.easyPieChart(
															{
																easing : 'easeOutElastic',
																delay : 3000,
																barColor : '#369670',
																trackColor : '#fff',
																scaleColor : false,
																lineWidth : 21,
																trackWidth : 21,
																size : 250,
																lineCap : 'round',
																onStep : function(
																		from,
																		to,
																		percent) {
																	this.el.children[0].innerHTML = Math
																			.round(percent);
																}
															});
										}, 150);
							});
		};

	function randomNum(minNum,maxNum){ 
    switch(arguments.length){ 
        case 1: 
            return parseInt(Math.random()*minNum+1,10); 
        break; 
        case 2: 
            return parseInt(Math.random()*(maxNum-minNum+1)+minNum,10); 
        break; 
            default: 
                return 0; 
            break; 
    } 
} 

	
(function change(){

	var r1 = randomNum(15,60);
	var r2 = randomNum(30,60);
	var r3 = randomNum(20,25);
	$(".r1").attr("data-percent",r1);
	$(".sr1").text(r1);
	$(".r2").attr("data-percent",r2);
	$(".sr2").text(r2);
	$(".r3").attr("data-percent",r3);
	$(".sr3").text(r3);
		run(_chart);
})()
	
	
	</script>


</body>

</html>
