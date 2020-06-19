
<%@page import="java.util.ArrayList"%>
<%@page import="com.lorem.ipsum.model.BoardModel"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lorem.ipsum.commons"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	



	ArrayList<BoardModel> boardList = (ArrayList<BoardModel>) request.getAttribute("boardList");
//System.out.println(request.getAttribute("boardList"));
	boolean tgRain = session.getAttribute("rain") == null ? true : (boolean) session.getAttribute("rain");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=no,initial-scale=1, maximum-scale=1">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/welcome.css">
<link rel="shortcut icon" href="../source/favi/favicon.ico">

<script src="../js/jquery-3.5.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if(!rain){
		$("#toggleRain").prop("checked", true);
	}
	
	tgRain($("#toggleRain"));
});
</script>
<title>Lorem Ipsum:Welcome</title>

</head>
<body>
	<div id="top"></div>
	<%@include file="../part/topMenu.jspf"%>
	<%@include file="../part/sideMenu.jspf"%>
	<%@include file="../part/firstView.jspf"%>
	<div id="main">
		<div id="main_contents">
			<div class="left_menu">
				<ul>
					<li><b>MENU</b></li>
					<%
						for (BoardModel b : boardList) {
					%>
					<li><div class="lb">
							<a
								href="<%=commons.baseUrl%>board?&name=<%=URLEncoder.encode(b.getB_name(), "utf-8")%>"><%=b.getB_name()%></a>
						</div></li>
					<%
						}
					%>
				</ul>
			</div>
			<div class="contents">
				<h1 id="h1">What is lorem ipsum?</h1>
				<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.
					Voluptatum, animi autem. Unde nulla eos iste sequi, consequatur
					impedit sit molestias rem, voluptatem ipsa sapiente nostrum
					praesentium, et eveniet consectetur itaque!</p>
				<p>Culpa labore enim minim nisi qui sunt dolor nostrud
					reprehenderit nulla sint aliquip et ea. Pariatur duis do id
					exercitation laboris aliqua sit cupidatat commodo do excepteur. Qui
					minim sint sunt non laboris occaecat consectetur deserunt quis
					aliquip duis. Nisi cillum nisi magna occaecat irure commodo minim
					enim ipsum do excepteur officia. Dolore magna non officia amet ad
					qui quis quis.</p>
				<p>Sint do nostrud ullamco nostrud ea excepteur. Consectetur est
					voluptate non cillum officia eu Lorem laborum. Anim elit magna eu
					in dolore aliquip sit. Exercitation non esse anim magna voluptate
					deserunt reprehenderit tempor ad irure ea laboris.</p>
				<p>Occaecat sunt velit id reprehenderit fugiat ullamco culpa
					laborum id sint aute. Velit consequat ea mollit consequat consequat
					eu. Tempor fugiat pariatur id cupidatat mollit voluptate.</p>
				<p>Laboris ut quis reprehenderit sit exercitation eu
					adipisicing. Aliqua eiusmod velit velit Lorem reprehenderit.
					Consequat aliqua nisi quis et.</p>
				<p>Do aliqua cillum consequat in nostrud pariatur velit duis
					irure ullamco exercitation. Id non Lorem consequat sunt minim et
					sunt irure sit deserunt. Sunt nulla aute eiusmod voluptate officia
					quis minim cillum reprehenderit.</p>
				<p>Ipsum quis esse Lorem eu. Do non deserunt ex sunt nisi Lorem
					sit labore officia consequat deserunt. Ullamco esse amet dolore
					irure velit. Aliqua dolore aliquip consectetur qui irure laborum ea
					laborum esse aliquip fugiat veniam esse in. Est duis cupidatat
					tempor est laborum pariatur magna commodo dolore labore sunt Lorem.
					Et nulla elit ipsum enim labore non nostrud elit ex sint sunt
					aliquip ut consequat.</p>
				<p>Nulla et eiusmod officia consequat consequat veniam ut culpa
					sunt nostrud exercitation veniam. Cupidatat cupidatat aliquip
					occaecat aute sunt laboris est velit adipisicing quis. Officia
					laborum et veniam adipisicing irure cillum pariatur labore culpa
					fugiat culpa cupidatat.</p>
				<p>Cillum aliquip irure nisi labore qui esse culpa tempor
					exercitation ullamco voluptate est adipisicing ex. Fugiat officia
					reprehenderit aute et velit culpa in exercitation in ut mollit
					laboris deserunt. Aliquip enim velit enim minim ad ex dolor aliqua
					reprehenderit esse dolore est id. Laborum sit voluptate laboris
					elit quis sunt ad nostrud qui laboris. Anim laborum incididunt
					officia incididunt nulla do consectetur.</p>
				<p>Lorem ipsum dolor sit amet consectetur adipisicing elit.
					Voluptatum, animi autem. Unde nulla eos iste sequi, consequatur
					impedit sit molestias rem, voluptatem ipsa sapiente nostrum
					praesentium, et eveniet consectetur itaque!</p>
				<p>Culpa labore enim minim nisi qui sunt dolor nostrud
					reprehenderit nulla sint aliquip et ea. Pariatur duis do id
					exercitation laboris aliqua sit cupidatat commodo do excepteur. Qui
					minim sint sunt non laboris occaecat consectetur deserunt quis
					aliquip duis. Nisi cillum nisi magna occaecat irure commodo minim
					enim ipsum do excepteur officia. Dolore magna non officia amet ad
					qui quis quis.</p>
				<p>Sint do nostrud ullamco nostrud ea excepteur. Consectetur est
					voluptate non cillum officia eu Lorem laborum. Anim elit magna eu
					in dolore aliquip sit. Exercitation non esse anim magna voluptate
					deserunt reprehenderit tempor ad irure ea laboris.</p>
				<p>Occaecat sunt velit id reprehenderit fugiat ullamco culpa
					laborum id sint aute. Velit consequat ea mollit consequat consequat
					eu. Tempor fugiat pariatur id cupidatat mollit voluptate.</p>
				<p>Laboris ut quis reprehenderit sit exercitation eu
					adipisicing. Aliqua eiusmod velit velit Lorem reprehenderit.
					Consequat aliqua nisi quis et.</p>
				<p>Do aliqua cillum consequat in nostrud pariatur velit duis
					irure ullamco exercitation. Id non Lorem consequat sunt minim et
					sunt irure sit deserunt. Sunt nulla aute eiusmod voluptate officia
					quis minim cillum reprehenderit.</p>
				<p>Ipsum quis esse Lorem eu. Do non deserunt ex sunt nisi Lorem
					sit labore officia consequat deserunt. Ullamco esse amet dolore
					irure velit. Aliqua dolore aliquip consectetur qui irure laborum ea
					laborum esse aliquip fugiat veniam esse in. Est duis cupidatat
					tempor est laborum pariatur magna commodo dolore labore sunt Lorem.
					Et nulla elit ipsum enim labore non nostrud elit ex sint sunt
					aliquip ut consequat.</p>
				<p>Nulla et eiusmod officia consequat consequat veniam ut culpa
					sunt nostrud exercitation veniam. Cupidatat cupidatat aliquip
					occaecat aute sunt laboris est velit adipisicing quis. Officia
					laborum et veniam adipisicing irure cillum pariatur labore culpa
					fugiat culpa cupidatat.</p>
				<p>Cillum aliquip irure nisi labore qui esse culpa tempor
					exercitation ullamco voluptate est adipisicing ex. Fugiat officia
					reprehenderit aute et velit culpa in exercitation in ut mollit
					laboris deserunt. Aliquip enim velit enim minim ad ex dolor aliqua
					reprehenderit esse dolore est id. Laborum sit voluptate laboris
					elit quis sunt ad nostrud qui laboris. Anim laborum incididunt
					officia incididunt nulla do consectetur.</p>
			</div>
		</div>
	</div>
	<div id="bot"></div>
</body>