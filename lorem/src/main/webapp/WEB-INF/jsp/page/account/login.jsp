
<%@page import="java.util.ArrayList"%>
<%@page import="com.lorem.ipsum.model.BoardModel"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lorem.ipsum.commons"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String msg=(String)request.getAttribute("msg");
	request.removeAttribute("msg");
	if(msg!=null){
	%><script>
	alert(<%="\'"+msg+"\'"%>);
	history.replaceState(
			{},
			null,
			'<%=commons.baseUrl%>login');
	history.go(0);
	</script><%	
	}
%>



<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=no,initial-scale=1, maximum-scale=1">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" href="../css/login.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="shortcut icon" href="../source/favi/favicon.ico">
<script src="../js/jquery-3.5.0.js"></script>
<script>
	$(window).bind("pageshow", function(event) {
		//back 이벤트 일 경우
		if (event.originalEvent && event.originalEvent.persisted) {
			window.location.reload(true);
		}
	});
	function in_del(inp) {
		var temp = document.getElementById(inp);
		temp.value = '';
		$("#"+inp).parent().children('*:nth-child(1)').focus();
	}

	$(document).ready(function() {
		$("form").submit(function() {
			let ls = $('#id').val();
			let ps = $('#pw').val();
			let warn = document.getElementById('info');
			if (ls == "" || ls == null) {
				warn.innerHTML = new String("아이디를 입력해 주세요.");
				$("#id").focus();
				return false;
			}
			if (ps == "" || ps == null) {
				warn.innerHTML = new String("비밀번호를 입력해 주세요.");
				$("#pw").focus();
				return false;
			}
			return true;
		});
	});
</script>
<title>Lorem Ipsum:Login</title>
</head>
<body>
	<div id="top"></div>
	<%@ include file="/WEB-INF/jsp/part/topMenu.jspf"%>
	<%@ include file="/WEB-INF/jsp/part/sideMenu.jspf"%>
	<div class="main">
		<div id="contents">
			<div class="topspace"></div>
			<div id="main_contents">
				<div id="con">
					<form id="submit" action="<%=commons.baseUrl%>login.do" method="post">
						<ul>
							<li><h1 style="font-size: 5em;">Login</h1></li>
							<li><br> <br></li>
							<li><label id="info"></label></li>
							<li><div class="putd">
									<input type="text" id="id" placeholder="아이디" name="id" autofocus="autofocus" tabindex="1">
									<input type="button" class="rxb" value="X" onclick="in_del('id')">
								</div></li>
							<li><div class="putd">
									<input type="password" id="pw" placeholder="비밀번호" name="pw"tabindex="2"><input
										type="button" class="rxb" value="X" onclick="in_del('pw')">
								</div></li>
							<li style="text-align: right;"><input type="checkbox"
								id="useCookie" tabindex="3"><label for="useCookie">로그인 상태 유지</label></li>
							<li><br></li>
							<li class="inli"><input type="submit" id="login_btn"
								value="로그인" tabindex="4"></li>
							<li class="inli" tabindex="5"><input type="button" id="join_btn"
								value="회원가입"
								onclick="location.href='<%=commons.baseUrl%>join/policy'"></li>
							<li class="inli"><input type="button" id="find_btn"
								value="ID/PW찾기" onclick="location.href='<%=commons.baseUrl%>find'" tabindex="6"></li>
						</ul>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div id="bot"></div>
</body>