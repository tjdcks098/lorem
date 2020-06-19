
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
String keyword=(String)request.getAttribute("keyword");
String target=(String)request.getAttribute("target");
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
	.hl{
		background-color:rgb(150,255,230);
	}
</style>
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
				%>
				<p>
					<a href="<%=commons.baseUrl%>board?&name=<%=URLEncoder.encode(b.getB_name(), "utf-8")%>"><%=b.getB_name()%></a>
				</p>
				<%
					}
				%>

			</div>
			<div id="con" style="top:20px; padding-top:15px">
				<div id="contentsList">
					<h3 class="listHeader" style="font-size:1.2em; padding-bottom:10px;"><%=target.equals("0")?"제목+내용":target.equals("1")?"제목":target.equals("2")?"내용":"닉네임"%>에서 "<%=keyword%>" 검색결과</h3>

					<%
						if (searchResult==null||searchResult.size() == 0) {
					%>

					<p
						style="font-size: 1em; text-align: center; padding: 100px 0 100px 0;">검색 결과가 없습니다.</p>

					<%
						} else {
							String[] keywords=keyword.split(" ");
							
						for (int i = 0; i < searchResult.size(); i++) {
							String css="";
							String pt=searchResult.get(i).getP_title();
							String pc=searchResult.get(i).getP_contents();
							String pu=searchResult.get(i).getU_nick();
							if(target.equals("0")||target.equals("1")){
								ArrayList<Integer> sh=new ArrayList<Integer>();
								ArrayList<Integer> eh=new ArrayList<Integer>();
								for(String key : keywords){
									int tg;
									if(key==null||key.equals("")||key.equals(" "))continue;
									if((tg=pt.toLowerCase().indexOf(key.toLowerCase()))!=-1){
										if(sh.indexOf(tg)==-1&&eh.indexOf(tg)==-1){
											sh.add(tg);
											eh.add(tg+key.length());
										}
										int ti;
										if((ti=eh.indexOf(tg))!=-1){
											eh.remove(ti);
											eh.add(ti,tg+key.length());
										}
									}
								}
								Collections.sort(sh);
								Collections.sort(eh);
								
								for(int k=sh.size()-1; k>-1; k--)
								pt=pt.substring(0, sh.get(k))+"<span class='hl'>"+pt.substring(sh.get(k), eh.get(k))+"</span>"+pt.substring(eh.get(k));
							}
							
							if(target.equals("0")||target.equals("2")){
								ArrayList<Integer> skey=new ArrayList<Integer>();
								ArrayList<Integer> ekey=new ArrayList<Integer>();
								ArrayList<Integer> sh=new ArrayList<Integer>();
								ArrayList<Integer> eh=new ArrayList<Integer>();
								String r="";
								for(String key : keywords){
									if(key==null||key.equals("")||key.equals(" "))continue;
									int ii=0, tg, klen=key.length();
									for( ; (tg=pc.toLowerCase().indexOf(key.toLowerCase(),ii))!=-1; ii=tg+klen){
										if(skey.size()>0){
											if(ekey.get(ekey.size()-1)>tg-8){
												ekey.remove(ekey.size()-1);
												if(tg<pc.length()-klen-8)ekey.add(tg+klen+8);
												else ekey.add(pc.length());
											}else{
												if(tg>8)skey.add(tg-8);
												else skey.add(0);
												if(tg<pc.length()-klen-8)ekey.add(tg+klen+8);
												else ekey.add(pc.length());
											}
											boolean isdp=false;
											for(int k=0; k<sh.size(); k++){
												if(tg>=sh.get(k)&&tg<eh.get(k))isdp=true;
											}
											if(isdp)continue;
											int k=eh.indexOf(tg);
											if(k!=-1){
												eh.remove(k);
												eh.add(k,tg+klen);
											}else{
												sh.add(tg);
												eh.add(tg+klen);
											}
										}else{
											if(tg>8)skey.add(tg-8);
											else skey.add(0);
											if(tg<pc.length()-klen-8)ekey.add(tg+klen+8);
											else ekey.add(pc.length());
											sh.add(tg);
											eh.add(tg+klen);
										}
									}
								}
								Collections.sort(sh);
								Collections.sort(eh);
								if(skey.size()==0){
									r=pc;
								}
								for(int j=0; j<skey.size(); j++){
									String t=(skey.get(j)!=0?"...":"")+pc.substring(skey.get(j)!=0?skey.get(j)+3:0, ekey.get(j)!=pc.length()?ekey.get(j)-3:pc.length())+(ekey.get(j)!=pc.length()?"...":"")+((j!=skey.size()-1)?"&nbsp;&nbsp;&nbsp;":"");
									for(int e=eh.size()-1; e>-1; e--){
										if(eh.get(e)<=ekey.get(j)&&sh.get(e)>=skey.get(j)){
											System.out.println(e+" "+j+" "+skey.get(j)+" "+sh.get(e)+" "+eh.get(e)+" "+ekey.get(j));
											t=t.substring(0,sh.get(e)-skey.get(j))+"<span class='hl'>"+t.substring(sh.remove(e)-skey.get(j), eh.get(e)-skey.get(j))+"</span>"+t.substring(eh.remove(e)-skey.get(j));
										}
									}
									r+=t;
								}
								pc=r;
							}
							if(pc.indexOf("<span class='hl'>")==-1){
								css="text-overflow:ellipsis; overflow: hidden;white-space: nowrap;";

							}
							
							if(target.equals("3")){
								ArrayList<Integer> sh=new ArrayList<Integer>();
								ArrayList<Integer> eh=new ArrayList<Integer>();
								for(String key : keywords){
									int tg;
									if(key==null||key.equals("")||key.equals(" "))continue;
									if((tg=pu.toLowerCase().indexOf(key.toLowerCase()))!=-1){
										if(sh.indexOf(tg)==-1&&eh.indexOf(tg)==-1){
											sh.add(tg);
											eh.add(tg+key.length());
										}
										int ti;
										if((ti=eh.indexOf(tg))!=-1){
											eh.remove(ti);
											eh.add(ti,tg+key.length());
										}
									}
								}

								Collections.sort(sh);
								Collections.sort(eh);
								for(int k=sh.size()-1; k>-1; k--)
								pu=pu.substring(0, sh.get(k))+"<span class='hl'>"+pu.substring(sh.get(k), eh.get(k))+"</span>"+pu.substring(eh.get(k));
							}
					%>

					<div onclick="location.href='<%=commons.baseUrl%>post?&name=<%=URLEncoder.encode(searchResult.get(i).getB_name(), "utf-8")%>&postId=<%=searchResult.get(i).getP_id()%>&view=search&target=<%=target%>&key=<%=keyword%>'" class="post" title='"<%=searchResult.get(i).getP_title()%>"로 이동'>
						
						<p class="postTitle" style="text-overflow: clip; white-space: normal;">
							<span style="margin-top:3px; font-size:0.8em; font-weight: normal;"><%=searchResult.get(i).getB_name()%> > </span><%=pt%>
						</p>
						<p style="font-size:0.8em; word-break:break-all; <%=css%>"><%=pc%></p>
						<p class="postWriter"  style="display: inline-block;"><%=(searchResult.get(i).getU_nick().length() > 7 ? searchResult.get(i).getU_nick().substring(0, 5) + "..."
							: pu) + "(" + searchResult.get(i).getU_id().substring(0, 3) + "***)"%></p>
						<div class="postInfo" style="display: inline-block; float:right; margin-top:0;">
							<p><%=searchResult.get(i).getP_date()%></p>
						</div>
					</div>

					<%
						}
					}
					%>

				</div>
				<div id="searchPost" style="margin-top:10px;">
					<form id="search" action="../board/search">
						<p>
							<select class="search" id="target" name="target">
								<option value=0 <%=target.equals("0")?"selected":""%>>제목+내용</option>
								<option value=1 <%=target.equals("1")?"selected":""%>>제목</option>
								<option value=2 <%=target.equals("2")?"selected":""%>>내용</option>
								<option value=3 <%=target.equals("3")?"selected":""%>>닉네임</option>
							</select> <input type="text" class="search" name="keyword" id="keyword"><input
								class="search" type="submit" value="검색">
						</p>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>