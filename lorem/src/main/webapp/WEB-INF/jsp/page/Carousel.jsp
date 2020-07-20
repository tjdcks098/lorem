<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	ArrayList<String> urls = (ArrayList<String>) request.getAttribute("imgUrls");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.5.0.js"></script>
<script type="text/javascript">
	image=[];
	imgIndex=0;
	<%for (int i = 0; i < urls.size(); i++) {%>
		image.push("<%=urls.get(i)%>");
<%}%>
	function next() {
		go(imgIndex + 1);
	}
	function prev() {
		go(imgIndex - 1);
	}
	function go(target) {
		if (target < 0)
			target = image.length - 1;
		if (target > image.length - 1)
			target = 0;
		prvIndex=imgIndex;
		imgIndex = target;
		$("#showingImg").attr('src', image[imgIndex]);
		$(".bar").css('opacity','0.3');
		$(".bar:nth-child("+(imgIndex+1)+")").css('opacity','0.9');
	}
	$(document).ready(function() {
		$("#showingImg").attr('src', image[imgIndex]);
		hstr = "";
		for (i = 0; i < image.length; i++) {
			hstr += "<div class='bar index_"+i+"' onclick='go("+i+");'></div>";
		}
		$(".Bars").html(hstr);
		$(".bar:nth-child("+(imgIndex+1)+")").css('opacity','0.9');
	});
</script>
<style>
.bar {
	opacity: 0.3;
	z-index: 100;
	text-align: center;
	display: inline-block;
	height: 6px;
	width: calc(100% / <%=urls.size()%> - 24px);
	background-color: rgb(255, 255, 255);
	border: 1px solid rgb(255, 255, 255);
	border-radius: 10px;
	margin: 0 10px;
}
.bar:hover{
	cursor: pointer;
}
.carouselContainer {
	margin: 150px auto 0;
	width: 800px;
	height: 450px;
	background-color: gray;
	overflow: hidden;
	border-radius: 20px;
}

#showingImg {
	width: 100%;
	transform: translateY(calc(-50% - 225px));
	z-index: 1;
}

.customButton {
	border: 0;
	outline: 0;
}

.Arrow {
	padding: 0 30px;
	position: relative;
	height: 100%;
	width: 120px;
	z-index: 100;
	font-size: 6em;
	font-weight: bold;
	background-color: rgba(0, 0, 0, 0);
	color: rgba(255, 255, 255);
	opacity: 0;
	transition: .3s;
}

.Arrow:hover {
	cursor: pointer;
	opacity: 0.6;
	transition: .3s;
}

.Left {
	float: left;
	left: 0px;
}

.Right {
	float: Right;
	right: 0px;
}

.Bars {
	position: relative;
	top: calc(100% - 50px);
	width: calc(100% - 240px);
	margin: 0 auto;
	height: 40px;
	z-index: 100;
	text-align: center;
}
</style>

</head>
<body>

	<div class="carouselContainer">
		<input type="button" class="Arrow Left customButton" value="&lt;"
			onclick="prev();"> <input type="button"
			class="Arrow Right customButton" value="&gt;" onclick="next();">
		<div class="Bars"></div>
		<img id="showingImg">
	</div>

</body>
</html>