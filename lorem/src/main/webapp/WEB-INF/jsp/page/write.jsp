
<%@page import="com.lorem.ipsum.commons"%>
<%@page import="com.lorem.ipsum.model.logon.UserModel"%>
<%@page import="com.lorem.ipsum.model.BoardModel"%>
<%@page import="javax.tools.DocumentationTool.Location"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
String type=(String) request.getAttribute("postType");
UserModel userck = (UserModel) session.getAttribute("user");
String board = (String) request.getAttribute("name");
String msg=(String)request.getAttribute("logonMsg");
ArrayList<BoardModel> boardList = null;
if (userck == null) {
	if(msg!=null){
		%>
		<script>alert('<%=msg%>');</script>
		<%
	}
%>
	<script>
		if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
			location.href="<%=commons.baseUrl%>login";
		} else {
			location.href="<%=commons.baseUrl%>board?&name=<%=board%>";
		}
	</script>
<%

	return;
} else {
	boardList = (ArrayList<BoardModel>) request.getAttribute("boardList");
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=no,initial-scale=1, maximum-scale=1">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<script src="../js/jquery-3.5.0.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src="js/post_submit.js"></script>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/board.css">
<link rel="stylesheet" href="css/post_submit.css">
<link rel="shortcut icon" href="../source/favi/favicon.ico">
<title>Lorem Ipsum:Write</title>

</head>
<body>
	<div id="top"></div>
	<%@include file="../part/topMenu.jspf"%>
	<%@include file="../part/sideMenu.jspf"%>
<div class="main">
	<div id="contents">
		<div class="topspace"></div>
		<div id="main_contents">
			<div id="boardList">

				<p>
					<b>게시판 목록</b>
				</p>
				<%
					for (BoardModel b : boardList) {
					String tstr = b.getB_name().equals(board) ? "style='font-weight:bold;'" : "";
				%>
				<p>
					<a
						href="<%=commons.baseUrl%>/board?&name=<%=URLEncoder.encode(b.getB_name(), "utf-8")%>"
						<%=tstr%>><%=b.getB_name()%></a>
				</p>
				<%
					}
				%>

			</div>
			<div id="boardInfo">
				<h3><%=board%></h3>
			</div>
			<div id="con">
				<form id="frm" method="post" enctype="multipart/form-data" action="../write.do">
					<div id="setTitle">
						<h3
							style="text-align: center; margin-bottom: 10px; border-bottom: 2px solid #808080">새
							게시글 작성</h3>
						<p>
							제목<input type="text" name="title" id="title">
						</p>
					</div>
					<div id="setContents">
						<p>내용</p>
						<textarea id="contents" name="contents"></textarea>
					</div>
					<%if(type==null||type.equals("noFile")){ %>
					<div id="setFile">
						<div id="imageName">선택된 파일이 없습니다.</div>
						<p>
							<label for="image">사진 추가</label>
						</p>
						<%if(type==null){ %>
						<br>
						<div id="fileName">선택된 파일이 없습니다.</div>
						<p>
							<label for="file">파일 첨부</label>
						</p>
						<%} %>
					</div>
					<%} %>
					<div style="text-align: center; height: 80px; margin-top: 20px;">
						<input class="writeBtn" type="button" value="취소"
							onclick="location.href=document.referrer;"> <input
							class="writeBtn" type="submit" value="게시하기">
					</div> 
					<input type="hidden" id="board" value="<%=URLEncoder.encode(board)%>">
				</form>
				<% if(type==null||type.equals("noFile")){ %>
				<input type="file" accept="image/*" multiple="multiple" id="image">
				<%
					}
					if(type==null){
				%>
				<input type="file" multiple="multiple" id="file">
				<%} %>
			</div>
		</div>
	</div>
</div>
	<div id="bot"></div>
</body>
