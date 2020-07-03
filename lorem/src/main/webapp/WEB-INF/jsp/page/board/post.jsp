
<%@page import="com.lorem.ipsum.model.logon.UserModel"%>
<%@page import="java.util.Collections"%>
<%@page import="com.lorem.ipsum.model.post.PostFileModel"%>
<%@page import="com.lorem.ipsum.model.post.ReplyModel"%>
<%@page import="com.lorem.ipsum.model.post.PostContentsModel"%>
<%@page import="com.lorem.ipsum.service.PostInfoService"%>
<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page import="javax.tools.DocumentationTool.Location"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.lorem.ipsum.model.post.PostInfoModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.lorem.ipsum.model.BoardModel"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.lorem.ipsum.commons"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String errMsg = (String) request.getAttribute("errMsg");
String highlight = request.getParameter("hl");
String target=request.getParameter("target");
String key=request.getParameter("key");
String[] keys=null;
if(key!=null){
	keys=key.split(" ");
}
UserModel userck = (UserModel) session.getAttribute("user");
String boardName = (String) request.getAttribute("name");
PostInfoModel postInfo = (PostInfoModel) request.getAttribute("postInfo");
String view = (String) request.getParameter("view");
String editable = "";
if (userck == null || !userck.getU_id().equals(postInfo.getU_id())) {
	editable = "style='display:none'";
}
PostContentsModel postContents = (PostContentsModel) request.getAttribute("postContents");
ArrayList<BoardModel> boardList = (ArrayList<BoardModel>) request.getAttribute("boardList");
ArrayList<ReplyModel> replyList = (ArrayList<ReplyModel>) request.getAttribute("replyList");
ArrayList<PostFileModel> clipList = (ArrayList<PostFileModel>) request.getAttribute("postFile");
ArrayList<PostFileModel> imageList = new ArrayList<PostFileModel>();
ArrayList<PostFileModel> fileList = new ArrayList<PostFileModel>();
ArrayList<Integer> lrList = (ArrayList<Integer>) request.getAttribute("likeReply");
if (lrList == null)
	lrList = new ArrayList<Integer>();
if (clipList != null)
	for (PostFileModel file : clipList) {
		if (file.getF_type().matches("img.*"))
	imageList.add(file);
		else
	fileList.add(file);
	}

String likeStyle = "";
String likeUrl = "";
String like = (String) request.getAttribute("like");
if (like == null || like.equals("false")) {
	likeUrl = commons.baseUrl+"post/like.do?&name=" + boardName + "&postId=" + postInfo.getP_id();
	likeStyle = "<a onclick='like()' id=\"like_this\" style=\'background-color: rgba(0, 0, 0, 0);\'>좋아요</a>";
} else {
	likeUrl = commons.baseUrl+"post/like.undo?&name=" + boardName + "&postId=" + postInfo.getP_id();
	likeStyle = "<a onclick='like()' id=\"like_this\" style=\'background-color: rgba(230, 230, 230, 1);\'>좋아요 취소</a>";
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
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/post.css">
<link rel="shortcut icon" href="../source/favi/favicon.ico">
<script>

<%String msg = (String) request.getAttribute("logonMsg");
if (msg != null) {%>
	alert("<%=msg%>");
	
	<%}
if (view!=null&&view.equals("new")) {%>
		history.replaceState({}, null, <%="\'" + commons.baseUrl%>post?&name=<%=URLEncoder.encode(boardName, "utf-8")%>&postId=<%=postInfo.getP_id() + "\'"%>
	);
	history.go(0);
<%}else if(view!=null&&view.equals("search")){
	%>
	history.replaceState({}, null, <%="\'" + commons.baseUrl%>post?&name=<%=URLEncoder.encode(boardName, "utf-8")%>&postId=<%=postInfo.getP_id() + "\'"%>
	<%
}
if(target!=null){
	%>
	$('.h:first-child()').focus();	
<%
}
%>

function replyDetail(obj){
	tg=obj.parent;
	
}
function likeReply(r_index){
	val=[];
	val.push({name:"name", value:"<%=boardName%>"});
	val.push({name:"postId", value:"<%=postInfo.getP_id()%>"});
	val.push({name:"r_index", value:r_index});
	$.ajax({
		dataType:'script',
		url:"<%=commons.baseUrl%>post/likeReply.do",
		data:val,
        type : "POST",
        success: function(){},
        error:function(){}
	});
}
function undo(r_index){
	val=[];
	val.push({name:"name", value:"<%=boardName%>"});
	val.push({name:"postId", value:"<%=postInfo.getP_id()%>"});
	val.push({name:"r_index", value:r_index});
	$.ajax({
		dataType:'script',
		url:"<%=commons.baseUrl%>post/likeReply.undo",
		data:val,
        type : "POST",
        success: function(){},
        error:function(){}
	});
}


function logonck(){
		var session='<%=userck == null ? "false" : "true"%>';

		if(session=='true'){			
			return true;
			}else{
			if (confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")) {
				location.href="<%=commons.baseUrl%>login";
			} 
			return false;
		}
}



function delconfirm(){
	if(logonck()){
		if(confirm("게시글을 삭제하시겠습니까?")){
			location.href="../delPost?&name=<%=boardName%>&postId=<%=postInfo.getP_id()%>";
		}
	}
}


function like(){
	if(logonck()){
		location.href='<%=likeUrl%>';
	}
}


function down(filename, pid,board){
	if(!logonck())return;
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
			  if (xhttp.readyState === 4 && xhttp.status === 200) {
				if (typeof window.navigator.msSaveBlob !== 'undefined') {
				  window.navigator.msSaveBlob(xhttp.response, filename);
				} else {
				  a = document.createElement('a');
				  a.href = window.URL.createObjectURL(xhttp.response);
				  a.download = filename;
				  a.style.display = 'none';
				  document.body.appendChild(a);
				  a.click();
				}
			  } else if (xhttp.readyState === 4) {
				var reader = new FileReader();
				reader.addEventListener('loadend', (e) => {
				  var errorMessage = JSON.parse(e.srcElement['result']);
				  console.log(errorMessage);
				});
				reader.readAsText(xhttp.response);
				this.loading = false;
			  }
			};
	xhttp.open('GET', '../post/download?&f_name='+filename+'&postId='+pid+'&name='+board);
	xhttp.responseType = 'blob';
	xhttp.send();
}


function replyOverflow(){
	$('.rc_ov').each(function(index, item){
		item.className="rc rc_nm";
		});
	$('.rc_nm').each(function(index, item){
		if(item.offsetHeight>25){
			item.className="rc rc_ov";
		}
	});
	$('.rc_nm').parent().children("p:last-child").children(".detail").css("display", "none");
	$('.rc_ov').parent().children("p:last-child").children(".detail").css("display", "inherit");
}


	$(document).ready(function() {
		<%if (highlight != null) {
	int c = 0;
	for (ReplyModel r : replyList) {
		if (r.getR_index() < Integer.valueOf(highlight))
			c++;
	}%>
			tg=$('.reply').eq(<%=c%>);
			tg.css("transition","background-color .5s");
			tg.css("background-color","rgb(170,255,170)");
			location.href='#r<%=c%>';
			<%}%>


		$('.detail').on("click", function(){
			tg=$(this).parent().parent().children(".rc")
			if(tg.hasClass("rc_ov")){
				tg.removeClass("rc_ov");
				tg.addClass("rc_nm");
				$(this).html("...접기");
			}else{		
				tg.removeClass("rc_nm");
				tg.addClass("rc_ov");
				$(this).html("...더보기");
			}
		});
		replyOverflow();
		$(window).resize(function(){
			replyOverflow();
		});
		$("form").submit(function() {
			if(logonck()){
			if ($("#reply").val() != null && $.trim($("#reply").val()) != "") {
				return true;
			} else {
				alert("댓글 내용을 입력해주세요.");
				return false;
			}
			}else return false;
		});
	});
</script>
<title>Lorem Ipsum:<%=boardName + " - " + postInfo.getP_title()%></title>
</head>
<body>
	<div id="top"></div>
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

					<%
						if (errMsg == null) {
					%>
					<div id="postContent">
					<%
					String title=postInfo.getP_title();
					if(view!=null&&view.equals("search")&&target!=null&&(target.equals("0")||target.equals("1"))){ 
						ArrayList<Integer> sh=new ArrayList<Integer>();
						ArrayList<Integer> eh=new ArrayList<Integer>();
						for(String k : keys){
							int tg;
							if(k==null||k.equals("")||k.equals(" "))continue;
							if((tg=title.toLowerCase().indexOf(k.toLowerCase()))!=-1){
								if(sh.indexOf(tg)==-1&&eh.indexOf(tg)==-1){
									sh.add(tg);
									eh.add(tg+k.length());
								}
								int ti;
								if((ti=eh.indexOf(tg))!=-1){
									eh.remove(ti);
									eh.add(ti,tg+k.length());
								}
							}
						}
						Collections.sort(sh);
						Collections.sort(eh);
						
						for(int k=sh.size()-1; k>-1; k--)
							title=title.substring(0, sh.get(k))+"<span class='hl'>"+title.substring(sh.get(k), eh.get(k))+"</span>"+title.substring(eh.get(k));
					}
					String nick=postInfo.getU_nick();
					if(view!=null&&view.equals("search")&&target!=null&&target.equals("3")){
						ArrayList<Integer> sh=new ArrayList<Integer>();
						ArrayList<Integer> eh=new ArrayList<Integer>();
						for(String k : keys){
							int tg;
							if(k==null||k.equals("")||k.equals(" "))continue;
							if((tg=nick.toLowerCase().indexOf(k.toLowerCase()))!=-1){
								if(sh.indexOf(tg)==-1&&eh.indexOf(tg)==-1){
									sh.add(tg);
									eh.add(tg+k.length());
								}
								int ti;
								if((ti=eh.indexOf(tg))!=-1){
									eh.remove(ti);
									eh.add(ti,tg+k.length());
								}
							}
						}

						Collections.sort(sh);
						Collections.sort(eh);
						for(int k=sh.size()-1; k>-1; k--)
							nick=nick.substring(0, sh.get(k))+"<span class='hl'>"+nick.substring(sh.get(k), eh.get(k))+"</span>"+nick.substring(eh.get(k));
					}
					%>
						<h3><%=title
		+ (postInfo.getP_update() == null ? "" : "<span style='font-size:0.8em;color:#808080'>(수정됨)</span>")%>
						</h3>
						<div id="postEdit">
							<input type="button" id="edit" value="수정" <%=editable%>
								onclick="location.href='../edit?&name=<%=boardName%>&postId=<%=postInfo.getP_id()%>'"><input
								type="button" id="delete" value="삭제" <%=editable%>
								onclick="delconfirm()">
						</div>
						<p id="contentInfo">
						<%if(userck!=null&&userck.getU_id().equals(postInfo.getU_id())) {%>
							<span style="color:#000; font-weight: bold;"><a  class="userIntro" title="내 개인정보 조회" href="../info"><%=nick%>(<%=postInfo.getU_id().substring(0, 3) + "***"%>)</a></span>
						<%}else{ %>
							<span style="color:#000; font-weight: bold;"><a  class="userIntro" title="'<%=nick%>'의 소개글과 작성글 조회" href="../intro?&nick=<%=nick%>"><%=nick%>(<%=postInfo.getU_id().substring(0, 3) + "***"%>)</a></span>
						<%}%>
							<br>20<%=postInfo.getP_date()%>
							<span class="cnt">View : <%=postInfo.getP_view()%> / Like : <%=postInfo.getP_like()%></span>
						</p>
						<%
						String ctx=URLDecoder.decode(postContents.getP_contents(), "utf-8");
						if(view!=null&&view.equals("search")&&target!=null&&(target.equals("0")||target.equals("2"))){
							ArrayList<Integer> sh=new ArrayList<Integer>();
							ArrayList<Integer> eh=new ArrayList<Integer>();
							String r="";
							for(String k : keys){
								if(k==null||k.equals("")||k.equals(" "))continue;
								int ii=0, tg, klen=k.length();
								for( ; (tg=ctx.toLowerCase().indexOf(k.toLowerCase(),ii))!=-1; ii=tg+klen){
									boolean isdp=false;
									for(int j=0; j<sh.size(); j++){
										if(tg>=sh.get(j)&&tg<eh.get(j))isdp=true;
									}
									if(isdp)continue;
									if(sh.size()>0){
										if(eh.get(eh.size()-1)==tg){
											eh.remove(eh.size()-1);
											eh.add(tg+klen);
										}else{
											sh.add(tg);
											eh.add(tg+klen);
										}
									}else{
										sh.add(tg);
										eh.add(tg+klen);
									}
								}
							}
							Collections.sort(sh);
							Collections.sort(eh);
							for(int e=eh.size()-1; e>-1; e--){
									ctx=ctx.substring(0,sh.get(e))+"<span class='hl'>"+ctx.substring(sh.remove(e), eh.get(e))+"</span>"+ctx.substring(eh.remove(e));
								}
							}
						%>

						<pre><%=ctx%></pre>

						<%
							for (PostFileModel image : imageList) {
						%>
						<div class="imageCon">
							<img class="image" alt="이미지를 불러오는데 실패했습니다."
								src="../postUpload/view/<%=image.getF_url().substring(image.getF_url().lastIndexOf('\\'))%>">
							<p
								style="font-size: 0.8em; margin: -8px 0 10px; text-align: right; color: #a0a0a0"><%=image.getF_name()%></p>
						</div>
						<%
							}
						%>
						<%
							if (fileList.size() > 0) {
						%>
						<div style="text-align: right; margin-top: 15px;">
							<%
								for (PostFileModel file : fileList) {
							%>
							<div class="clip">
								<a
									onclick="down('<%=file.getF_name()%>', '<%=postInfo.getP_id()%>','<%=boardName%>')"><img
									src="../source/clip_50x50.png" height="15px" align="top"><%=file.getF_name()%></a>
							</div>
							<%
								}
							%>
						</div>
						<%
							}
						%>

					</div>
					<div class="pageControl">
						<a class="ctrBtn"
							href="../post?&name=<%=URLEncoder.encode(boardName)%>&postId=<%=postInfo.getP_id() + 1%>&view=new"
							<%=postInfo.getHasPrev().equals("true") ? "" : "style='display:none;'"%>>◀이전글</a>
						<a href="../board?&name=<%=URLEncoder.encode(boardName)%>" class="ctrBtn">목록으로</a> <a
							class="ctrBtn"
							href="../post?&name=<%=URLEncoder.encode(boardName)%>&postId=<%=postInfo.getP_id() - 1%>&view=new"
							<%=postInfo.getHasNext().equals("true") ? "" : "style='display:none;'"%>>다음글▶</a>
					</div>
					<p style="margin-left: 25%; margin-bottom: 10px;">
						<b>View Reply</b>
						<%=likeStyle%>
					</p>
					<div id="replyList">
						<%
							if (replyList.size() == 0) {
						%>
						<div style="text-align: center;">
							<br>작성된 댓글이 없습니다.<br>
						</div>
						<%
							} else {
							for (ReplyModel r : replyList) {
								String rstr = "";
								if (userck != null) {
							rstr = r.getU_id().equals(userck.getU_id())
									? "<a class='rdel rctr' href='../rdel?&name=" + boardName + "&postId=" + postInfo.getP_id()
											+ "&index=" + r.getR_index() + "'>[삭제]</a>"
									: "";
								}
						%>
						<div class="reply">
							<%
								if (rstr == "") {
								if (lrList.indexOf(r.getR_index()) == -1) {
							%>
							<div class='replyLike' onclick='likeReply(<%=r.getR_index()%>)'>
								Like <br><%=r.getR_like()%></div>
							<%
								} else {
							%>
							<div class='replyLike' style="background-color: #eeeeee"
								onclick='undo(<%=r.getR_index()%>)'>
								Like <br><%=r.getR_like()%></div>
							<%
								}
							} else {
							%>
							<div class='replyLikeView'>
								Like <br><%=r.getR_like()%><br><%=rstr%></div>
							<%
								}

								if(userck!=null&&userck.getU_id().equals(r.getU_id())) {
							%>
							<p><a  class="userIntro" title="내 개인정보 조회" href="../info"><%=r.getU_nick()%>(<%=r.getU_id().substring(0, 3) + "***"%>)
							<% }else{%>
							<p><a  class="userIntro" title="'<%=r.getU_nick()%>'의 소개글과 작성글 조회" href="../intro?&nick=<%=r.getU_nick()%>"><%=r.getU_nick()%>(<%=r.getU_id().substring(0, 3) + "***"%>)
							<%} %>
							</a></p>
							<p id="r<%=r.getR_index()%>" class="rc rc_nm"><%=r.getContents()%></p>
							<p><%=r.getR_date()%><a class="detail">...더보기</a></p>
						</div>
						<%
							}
						}
						%>
					</div>
					<form id="replyModel" action="<%=commons.baseUrl%>post/reply"
						method="post">
						<p id="write_reply">
							<input type="hidden" name="name" value="<%=boardName%>">
							<input type="hidden" name="postId"
								value="<%=postInfo.getP_id()%>"> 댓글 : <input id="reply"
								name="contents" type="text"><input type="submit"
								id="reply_submit" value="댓글 입력">
						</p>
					</form>
					<%
						} else {
					%>
					<h2><%=errMsg%></h2>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<div id="bot"></div>
</body>