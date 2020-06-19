
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=no,initial-scale=1, maximum-scale=1">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<script src="../js/jquery-3.5.0.js"></script>
<link rel="stylesheet" href="../css/common.css">
<link rel="shortcut icon" href="../source/favi/favicon.ico">
<style>
input:focus {
	outline: none;
}

#main_contents ul {
	list-style: none;
	text-align: left;
	display: inline;
	position: relative;
}

#main_contents li:first-child h1 {
	font-size: 3em;
	transition: all .05s;
}

#main_contents li:nth-child(2) b {
	font-size: 2em;
	transition: all .05s;
}



.topspace {
	height: calc(10vw + 5vh);
	min-height: 60px;
	max-height: 180px;
}

#next_btn {
	float: right;
	background-color: rgb(250, 250, 250);
	border: 0;
	width: 150px;
	height: 52px;
	transition: all .5s;
	margin: 5px 10px 10px 10px;
	cursor: pointer;
	border-radius: 50px;
	box-shadow: 0 10px 0 0 rgb(150, 150, 150);
	transition: all .3s;
}

#next_btn:hover {
	margin-top: 7px;
	box-shadow: 0 8px 0 0 rgb(150, 150, 150);
}

#next_btn:active {
	background-color: rgb(230, 230, 230);
	margin-top: 13px;
	box-shadow: 0 2px 0 0 rgb(150, 150, 150);
	transition: all .05s;
}

@media screen and (max-width: 650px) {
	#main_contents li:first-child h1 {
		font-size: 1.6em;
		transition: all .05s;
	}
	#main_contents li:nth-child(2) b {
		font-size: 1.4em;
		transition: all .05s;
	}
	#main_contents li h1 {
	font-size: 1.4em;
	transition: all .05s;
}
}
</style>

<title>Lorem Ipsum:SUPPORT</title>
</head>
<body>
	<div id="top"></div>
		<%@include file="../part/topMenu.jspf"%>
		<%@include file="../part/sideMenu.jspf"%>
	<div class="main">
		<div id="contents">
			<div class="topspace"></div>
			<div id="main_contents">
				<div id="con">
					<ul>
						<li><h1>Customer Support</h1></li>
						<li><b>고객지원</b></li>
						<li><br> <br> <br></li>
						<li><h1>Q&amp;A - 자주 묻는 질문</h1></li>
						<li><br></li>
						<li><b>Q) what is lorem ipsum?</b></li>
						<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit.
							A, reiciendis quisquam! Error consectetur dignissimos architecto,
							deserunt unde numquam corrupti, dolore rem voluptatem aliquam hic
							voluptas fuga placeat quae quos fugiat.</li>
						<li><br></li>
						<li><b>Q) what is lorem ipsum?</b></li>
						<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit.
							A, reiciendis quisquam! Error consectetur dignissimos architecto,
							deserunt unde numquam corrupti, dolore rem voluptatem aliquam hic
							voluptas fuga placeat quae quos fugiat.</li>
						<li><br></li>
						<li><b>Q) what is lorem ipsum?</b></li>
						<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit.
							A, reiciendis quisquam! Error consectetur dignissimos architecto,
							deserunt unde numquam corrupti, dolore rem voluptatem aliquam hic
							voluptas fuga placeat quae quos fugiat.</li>
						<li><br></li>
						<li><b>Q) what is lorem ipsum?</b></li>
						<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit.
							A, reiciendis quisquam! Error consectetur dignissimos architecto,
							deserunt unde numquam corrupti, dolore rem voluptatem aliquam hic
							voluptas fuga placeat quae quos fugiat.</li>
						<li><br></li>
						<li><b>Q) what is lorem ipsum?</b></li>
						<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit.
							A, reiciendis quisquam! Error consectetur dignissimos architecto,
							deserunt unde numquam corrupti, dolore rem voluptatem aliquam hic
							voluptas fuga placeat quae quos fugiat.</li>
						<li><br></li>
						<li><b>Q) what is lorem ipsum?</b></li>
						<li>Lorem ipsum dolor sit, amet consectetur adipisicing elit.
							A, reiciendis quisquam! Error consectetur dignissimos architecto,
							deserunt unde numquam corrupti, dolore rem voluptatem aliquam hic
							voluptas fuga placeat quae quos fugiat.</li>

					</ul>
				</div>
			</div>
		</div>
	</div>
	<div id="bot"></div>
</body>