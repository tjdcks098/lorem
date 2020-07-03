<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String u_id=(String)request.getAttribute("u_id");
String u_nick=(String)request.getAttribute("u_nick");
String u_intro=(String)request.getAttribute("u_intro");
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
<script type="text/javascript">nick="<%=u_nick%>"</script>
<script src="../js/jquery-3.5.0.js"></script>
<script src="../js/intro.js"></script>
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/info.css">
<link rel="shortcut icon" href="../source/favi/favicon.ico">
<style>
	th{
		text-align: right;
		padding-right:10px;
	}
</style>
<title>개인정보</title>
</head>
<body>
	<div id="top"></div>
		<%@include file="/WEB-INF/jsp/part/topMenu.jspf"%>
		<%@include file="/WEB-INF/jsp/part/sideMenu.jspf"%>
	<div class="main">
		<div id="contents">
			<div class="topspace"></div>
			<div id="main_contents">
				<div id="con">
					<h1>사용자 조회</h1>
					<br>
					<br>
					<div id="pubInf" class="dashedCon">
						<table class="paddingTable" style="width:100%">
							<tr>
								<td colspan="2" style="text-align: center;"><h3>사용자 정보</h3></td>
							</tr>
							<tr>
								<th>사용자</th>
								<td><%=u_nick%>(<%=u_id.substring(0,3)+"***"%>)</td>
							</tr>
							<tr>
								<th>가입일</th>
								<td><%=u_joindate==null?"정보없음":("20"+u_joindate.split(" ")[0].split("/")[0]+"년 "+u_joindate.split(" ")[0].split("/")[1]+"월 "+u_joindate.split(" ")[0].split("/")[2]+"일")%></td>
							</tr>
							<tr>
								<th>회원등급</th>
								<td><%=commons.USER_LEVEL.valueOf(Integer.valueOf(u_level))%></td>
							</tr>
							<tr>
							<td colspan="2"><hr></td>
							</tr>
							<tr>
								<th colspan="2" style="text-align: center;">소개글</th>
							</tr>
							<tr>
								<td colspan = "2" style="padding-top:0"><pre><%=u_intro==null?"소개글을 작성하지 않았습니다.":u_intro%></pre></td>
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