
<%@page import="com.lorem.ipsum.model.post.PostInfoModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lorem.ipsum.model.BoardModel"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lorem.ipsum.commons"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String type=(String)request.getAttribute("postType");
	String errMsg = (String) request.getAttribute("errMsg");
ArrayList<BoardModel> boardList = (ArrayList<BoardModel>) request.getAttribute("boardList");
String boardName = (String) request.getAttribute("name");
int pageNum = -1;
int postCount = -1;
ArrayList<PostInfoModel> postList = new ArrayList<PostInfoModel>();
if (errMsg == null) {
	postCount = Integer.valueOf((String) request.getAttribute("postCount"));
	pageNum = Integer.valueOf((String) request.getAttribute("pageNum"));
	postList = (ArrayList<PostInfoModel>) request.getAttribute("postList");
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
<script>
	$(document).ready(function() {
		$("#search").submit(function() {
			if ($("#keyword").val().length < 1) {
				alert("검색 키워드를 입력해주세요.");
				return false;
			}
		});
	});
</script>

<title>Lorem Ipsum:<%=boardName%></title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/board.css">
<link rel="shortcut icon" href="../source/favi/favicon.ico">

</head>

<div class="main">

	<%@include file="../part/topMenu.jspf"%>
	<%@include file="../part/sideMenu.jspf"%>
	<div id="contents">
		<div class="topspace"></div>
		<div id="main_contents">
			<div id="boardList">

				<p>
					<b>게시판 목록</b>
				</p>
				<%
					for (BoardModel b : boardList) {
					String tstr = b.getB_name().equals(boardName) ? "style='font-weight:bold;'" : "";
				%>
				<p>
					<a
						href="<%=commons.baseUrl%>board?&name=<%=URLEncoder.encode(b.getB_name(), "utf-8")%>"
						<%=tstr%>><%=b.getB_name()%></a>
				</p>
				<%
					}
				%>

			</div>
			<div id="boardInfo">
				<h3><%=boardName%></h3>
			</div>
			<div id="con">
				<div id="contentsList">
					<p class="listHeader">Post List</p>

					<%
						if (postCount == 0) {
					%>

					<p
						style="font-size: 1em; text-align: center; padding: 100px 0 100px 0;">게시글이
						없습니다.</p>

					<%
						} else if (errMsg != null) {
					%>
					<p
						style="font-size: 1em; text-align: center; padding: 100px 0 100px 0;"><%=errMsg%></p>

					<%
						} else {
						for (int i = 0; i < (postCount > 20 ? 20 : postCount); i++) {
					%>

					<div <%=(type!=null&&type.equals("noContents"))?"":(postList.get(i).getP_lock().equals("y") ? 
										"style='color:#707070'" 
										: ("onclick=\"location.href=\'" + commons.baseUrl + "post?&name=" + URLEncoder.encode(boardName, "utf-8")
													+ "&postId=" + postList.get(i).getP_id() + "&view=new\'\""))%> 
							class="post" 
							title='<%=(type!=null&&type.equals("noContents"))?"":("\""+postList.get(i).getP_title() 
								+ (postList.get(i).getP_lock().equals("y") ? "*잠긴글*" : "")+"\"로 이동")%>'>
						
						<p class="postTitle">
							<%=postList.get(i).getP_title() 
							+ (postList.get(i).getP_update() == null ? 
									"" 
									: "<span style='font-size:0.5em;color:#808080'>(수정됨)</span>")
							+ (postList.get(i).getP_lock().equals("y") ? "*잠긴글*" : "")%>

						</p>
						<%=postList.get(i).getHasClip().equals("true") ? "<img class='postClip' src='../source/clip_50x50.png'>" : ""%>
						<%=postList.get(i).getHasImg().equals("true") ? "<img class='postImg' src='../source/image_icon_50x50.png'>" : ""%>

						<p class="postWriter"<%=type!=null&&type.equals("noContents")?"style='display:inline-block'":"" %>><%=(postList.get(i).getU_nick().length() > 5 ? postList.get(i).getU_nick().substring(0, 6) + "..."
		: postList.get(i).getU_nick()) + "(" + postList.get(i).getU_id().substring(0, 3) + "***)"%></p>
						<div class="postInfo" <%=type!=null&&type.equals("noContents")?"style='display:inline-block; float:right'":"" %>>
							<%if(type==null||!type.equals("noContents")){ %>
							<p>
								좋아요:
								<%=postList.get(i).getP_like()%>&nbsp;&nbsp;조회수:
								<%=postList.get(i).getP_view()%></p>
							<%} %>
							<p><%=postList.get(i).getP_date()%></p>
						</div>
					</div>

					<%
						}
					}
					%>

				</div>
				<div id="write">
				<%if(type!=null&&type.equals("noContents")){ %>
				<form action="../write.do">
					<input type="hidden" id="board" name="board" value="<%=URLEncoder.encode(boardName)%>">
					<input type="text"  name="title" style="padding:0 5px; width:calc(100% - 90px);"  class="search">
					<input type="submit" class="search" style="padding:0 5px" value="글쓰기">
				</from>
				<%}else{ %>
					<a href="<%=commons.baseUrl%>write?&name=<%=URLEncoder.encode(boardName, "utf-8")%>">글쓰기</a>
				<%} %>
				</div>
				<div class="contentsPage">
					<%
						int st = 1;
					if (Integer.valueOf(pageNum) > 3)
						st = Integer.valueOf(pageNum) - 3;
					if (pageNum != 1 && pageNum > 0) {
					%>
					◀<a class="page" id="pre_btn"
						href="<%=commons.baseUrl%>board?&name=<%=URLEncoder.encode(boardName, "utf-8")%>&pageNum=<%=Integer.valueOf(pageNum) - 1%>">이전</a>&nbsp;&nbsp;
					<%
						} else {
					%>
					<a style="color: rgba(0, 0, 0, 0)">◀이전</a>&nbsp;&nbsp;

					<%
						}
					int end = postCount / 20;
					for (int i = st; i < end + 1; i++) {
						String tstr = (pageNum == i) ? "style='font-weight:bold;'" : "";
					%>
					<a class="page" id="page<%=i%>"
						href="<%=commons.baseUrl%>board?&name=<%=URLEncoder.encode(boardName, "utf-8")%>&pageNum=<%=i%>"
						<%=tstr%>><%=i%></a>
					<%
						}
					if (pageNum != end && end > 0) {
					%>
					&nbsp;&nbsp;<a class="page" id="nxt_btn"
						href="<%=commons.baseUrl%>board?&name=<%=URLEncoder.encode(boardName, "utf-8")%>&pageNum=<%=Integer.valueOf(pageNum) + 1%>">다음</a>▶
					<%
						} else {
					%>
					&nbsp;&nbsp;<a style="color: rgba(0, 0, 0, 0)">다음▶</a>

					<%
						}
					%>

				</div>
				<div id="searchPost">
					<form id="search" action="../board/search">
						<p>
							<select class="search" id="target" name="target">
								<option value=0 selected>제목+내용</option>
								<option value=1>제목</option>
								<option value=2>내용</option>
								<option value=3>닉네임</option>
							</select> <input type="text" class="search" name="keyword" id="keyword"><input
								class="search" type="submit" value="검색">
						</p>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>