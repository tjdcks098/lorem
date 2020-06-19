<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String u_id=(String)request.getAttribute("u_id");
String u_nick=(String)request.getAttribute("u_nick");
String u_email=(String)request.getAttribute("u_email");
String u_phnum=(String)request.getAttribute("u_phnum");
String u_intro=(String)request.getAttribute("u_intro");
String u_name=(String)request.getAttribute("u_name");
String u_birth=(String)request.getAttribute("u_birth");
String u_joindate=(String)request.getAttribute("u_joindate");
String u_level=(String)request.getAttribute("u_level");
%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=no,initial-scale=1, maximum-scale=1">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<script src="../js/jquery-3.5.0.js"></script>
<script src="../js/info.js"></script>
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/info.css">
<link rel="shortcut icon" href="../source/favi/favicon.ico">
<title>개인정보</title>
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
					<h1>개인정보 조회</h1>
					<br>
					<br>
					<div id="pubInf" class="dashedCon">
						<table class="paddingTable">
							<tr>
								<td colspan="2" style="text-align: center;"><h3>가입정보</h3></td>
							</tr>
							<tr>
								<td>아이디</td>
								<td><%=u_id.substring(0,3)+"***"%></td>
							</tr>
							<tr>
								<td>닉네임</td>
								<td><%=u_nick%></td>
							</tr>
							<tr>
								<td>이메일</td>
								<td><%=u_email==null?"정보없음":(u_email.split("@")[0].substring(0,3)+"*****@"+u_email.split("@")[1])%></td>
							</tr>
							<tr>
								<td>전화번호</td>
								<td><%=u_phnum==null?"정보없음":(u_phnum.substring(0, 7)+"****")%></td>
							</tr>
							<tr>
								<td>소개글</td>
								<td><%=u_intro==null?"소개글을 작성하지 않았습니다.":u_intro%></td>
							</tr>
							<tr>
								<td>이름</td>
								<td><%=u_name.substring(0, 1)+"**"%></td>
							</tr>
							<tr>
								<td>생년월일</td>
								<td><%=u_birth==null?"정보없음":u_birth%></td>
							</tr>
							<tr>
								<td>가입일</td>
								<td><%=u_joindate==null?"정보없음":u_joindate%></td>
							</tr>
							<tr>
								<td>회원등급</td>
								<td><%=commons.USER_LEVEL.valueOf(Integer.valueOf(u_level))+"("+u_level+"등급)"%></td>
							</tr>
							<tr>
								<td><input class="roundBtn" type="button" value="정보수정" onclick="location.href='../info/edit'"></td>
								<td></td>
							</tr>
						</table>
					</div>
					<br>
					<div id="postInfo" class="dashedCon">
					<h3>작성한 글 목록</h3>
					<div id="myPostList">
					<input type="button" class="roundBtn" value="조회하기" onclick="getMyPost()">
					</div>
					</div>
					<br>
					<div id="replyInfo" class="dashedCon">
					<h3>작성한 댓글 목록</h3>
					<div id="myReplyList">
					<input type="button" class="roundBtn" value="조회하기" onclick="getMyReply()">
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="bot"></div>
</body>
</html>