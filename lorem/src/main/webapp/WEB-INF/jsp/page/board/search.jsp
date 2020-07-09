
<%@page import="com.lorem.ipsum.rangeList"%>
<%@page import="java.util.Collections"%>
<%@page import="com.lorem.ipsum.model.post.PostSearchModel"%>
<%@page import="com.lorem.ipsum.model.post.PostInfoModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lorem.ipsum.model.BoardModel"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lorem.ipsum.commons"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String keyword = (String) request.getAttribute("keyword");
String target = (String) request.getAttribute("target");
ArrayList<BoardModel> boardList = (ArrayList<BoardModel>) request.getAttribute("boardList");
ArrayList<PostSearchModel> searchResult = (ArrayList<PostSearchModel>) request.getAttribute("result");
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

<title>Lorem Ipsum:Search</title>
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/board.css">
<link rel="shortcut icon" href="../source/favi/favicon.ico">
<style type="text/css">
.hl {
	background-color: rgb(150, 255, 230);
}
</style>
</head>

<div class="main">

	<%@include file="/WEB-INF/jsp/part/topMenu.jspf"%>
	<%@include file="/WEB-INF/jsp/part/sideMenu.jspf"%>
	<div id="contents">
		<div class="topspace"></div>
		<div id="main_contents">
			<div id="boardList">

				<p>
					<b>게시판 목록</b>
				</p>
				<%
					for (BoardModel b : boardList) {
				%>
				<p>
					<a
						href="<%=commons.baseUrl%>board?&name=<%=URLEncoder.encode(b.getB_name(), "utf-8")%>"><%=b.getB_name()%></a>
				</p>
				<%
					}
				%>

			</div>
			<div id="con" style="top: 20px; padding-top: 15px">
				<div id="contentsList">
					<h3 class="listHeader"
						style="font-size: 1.2em; padding-bottom: 10px;"><%=target.equals("0") ? "제목+내용" : target.equals("1") ? "제목" : target.equals("2") ? "내용" : "닉네임"%>에서
						"<%=keyword%>" 검색결과
					</h3>

					<%
						if (searchResult == null || searchResult.size() == 0) {
					%>

					<p
						style="font-size: 1em; text-align: center; padding: 100px 0 100px 0;">검색
						결과가 없습니다.</p>

					<%
						} else {
						String[] keywords = keyword.split(" ");

						for (int i = 0; i < searchResult.size(); i++) {
							String css = "";
							String pt = searchResult.get(i).getP_title();
							String pc = searchResult.get(i).getP_contents();
							String pu = searchResult.get(i).getU_nick();
						if (target.equals("0") || target.equals("1")) {
							rangeList rg = new rangeList();
							rg.setLimit(0, pt.length());
							for (String key : keywords) {
								int tg;
								if (key == null || key.equals("") || key.equals(" "))
									continue;
								if ((tg = pt.toLowerCase().indexOf(key.toLowerCase())) != -1) {
									rg.add(tg, key.length());
								}
							}
	
							for (int k = rg.size() - 1; k > -1; k--)
								pt = pt.substring(0, rg.getStartPoint(k)) + "<span class='hl'>" + pt.substring(rg.getStartPoint(k), rg.getEndPoint(k)) + "</span>"
										+ pt.substring(rg.getEndPoint(k));
								
							System.out.println("rg:"+rg);
						}
							
							
							if (pc != null && (target.equals("0") || target.equals("2"))) {
						rangeList kr=new rangeList();
						rangeList wr=new rangeList();
						kr.setLimit(0, pc.length());
						wr.setLimit(0, pc.length());
						String r = "";
						for (String key : keywords) {
							if (key == null || key.equals("") || key.equals(" "))
								continue;
							int ii = 0, tg, klen = key.length();
							for (; (tg = pc.toLowerCase().indexOf(key.toLowerCase(), ii)) != -1; ii = tg + klen) {
								kr.add(tg, tg+key.length());
								wr.add(tg-8,tg+key.length()+8);
							}
						}
						System.out.println(kr);
						System.out.println(wr);
						if (kr.size() == 0) {
							r = pc;
						}
						for (int j = 0; j < kr.size(); j++) {
							for(int e=0; e<wr.size(); e++){
								int sp=wr.getStartPoint(e), ep=wr.getEndPoint(e);
								rangeList gkr=wr.getRangesInRange(sp, ep);
								String t="";
								if(sp!=0)t+="...";
								if(sp!=gkr.getStartPoint(0))
									t+=pc.substring(sp, gkr.getStartPoint(0));
								for(int ee=0; ee<gkr.size(); ee++){
									t+="<span class='hl'>"+pc.substring(gkr.getStartPoint(ee), gkr.getEndPoint(ee))+ "</span>";
									if(ee!=gkr.size()-1)t+=pc.substring(gkr.getEndPoint(ee), gkr.getStartPoint(ee+1));
								}
								if(ep!=gkr.getEndPoint(gkr.size()-1))t+=pc.substring(gkr.getEndPoint(gkr.size()-1), ep);
								r += t;
							}
						}
						pc = r;
							}
							if (pc != null && pc.indexOf("<span class='hl'>") == -1) {
						css = "text-overflow:ellipsis; overflow: hidden;white-space: nowrap;";

							}

							if (target.equals("3")) {
						ArrayList<Integer> sh = new ArrayList<Integer>();
						ArrayList<Integer> eh = new ArrayList<Integer>();
						for (String key : keywords) {
							int tg;
							if (key == null || key.equals("") || key.equals(" "))
								continue;
							if ((tg = pu.toLowerCase().indexOf(key.toLowerCase())) != -1) {
								if (sh.indexOf(tg) == -1 && eh.indexOf(tg) == -1) {
									sh.add(tg);
									eh.add(tg + key.length());
								}
								int ti;
								if ((ti = eh.indexOf(tg)) != -1) {
									eh.remove(ti);
									eh.add(ti, tg + key.length());
								}
							}
						}

						Collections.sort(sh);
						Collections.sort(eh);
						for (int k = sh.size() - 1; k > -1; k--)
							pu = pu.substring(0, sh.get(k)) + "<span class='hl'>" + pu.substring(sh.get(k), eh.get(k)) + "</span>"
									+ pu.substring(eh.get(k));
							}
					%>

					<div
						onclick="location.href='<%=commons.baseUrl%>post?&name=<%=URLEncoder.encode(searchResult.get(i).getB_name(), "utf-8")%>&postId=<%=searchResult.get(i).getP_id()%>&view=search&target=<%=target%>&key=<%=keyword%>'"
						class="post" title='"<%=searchResult.get(i).getP_title()%>"로 이동'>

						<p class="postTitle"
							style="text-overflow: clip; white-space: normal;">
							<span
								style="margin-top: 3px; font-size: 0.8em; font-weight: normal;"><%=searchResult.get(i).getB_name()%>
								> </span><%=pt%>
						</p>
						<%
							if (pc != null) {
						%>
						<p style="font-size:0.8em; word-break:break-all; <%=css%>"><%=pc%></p>
						<%
							}
						%>
						<p class="postWriter" style="display: inline-block;"><%=(searchResult.get(i).getU_nick().length() > 7 ? searchResult.get(i).getU_nick().substring(0, 5) + "..." : pu)
		+ "(" + searchResult.get(i).getU_id().substring(0, 3) + "***)"%></p>
						<div class="postInfo"
							style="display: inline-block; float: right; margin-top: 0;">
							<p><%=searchResult.get(i).getP_date()%></p>
						</div>
					</div>

					<%
						}
					}
					%>

				</div>
				<div id="searchPost" style="margin-top: 10px;">
					<form id="search" action="../board/search">
						<p>
							<select class="search" id="target" name="target">
								<option value=0 <%=target.equals("0") ? "selected" : ""%>>제목+내용</option>
								<option value=1 <%=target.equals("1") ? "selected" : ""%>>제목</option>
								<option value=2 <%=target.equals("2") ? "selected" : ""%>>내용</option>
								<option value=3 <%=target.equals("3") ? "selected" : ""%>>닉네임</option>
							</select> <input type="text" class="search" name="keyword" id="keyword"><input
								class="search" type="submit" value="검색">
						</p>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>