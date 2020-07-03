
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String fid=(String)request.getAttribute("fid");
String fpw=(String)request.getAttribute("fpw");
String fhint=(String)request.getAttribute("fhint");
	if(fid!=null){
		request.setAttribute("fid", null);
	}
	if(fpw!=null){
		request.setAttribute("fpw", null);
		request.setAttribute("fhint", null);
	}
%>
	
	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=no,initial-scale=1, maximum-scale=1">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Lorem ipsum:Find Account</title>
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/find.css">
<link rel="shortcut icon" href="../source/favi/favicon.ico">

<script src="../js/jquery-3.5.0.js"></script>
<script>
	history.replaceState({}, null, "/find");
	function emadd() {
		$("#emsel option:eq(0)").prop("selected", true);
	}
	function emselF(obj) {
		let add = document.getElementById(obj+"Emadd");
		if ($('#'+obj+' .emsel').value != '직접입력') {
			add.value = $('#'+obj+' .emsel').val();
		} else {
			add.value = "";
		}
	}
</script>
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
					<ul>
						<li><h1>Find Account</h1></li>
						<li><b>계정 찾기</b></li>
						<li><br> <br> <br></li>
					</ul>
					<div>
						<form id="fid" method="post" action="/find/id.do">
							<ul>
								<li><b>아이디 찾기</b></li>
								<li><br></li>
								<%if(fid!=null){%>
								<li>아이디 찾기 결과</li>
								<%if(fid.equals("0")){%>
								<li style="font-size:0.8em;">입력하신 정보와 일치하는 계정이 없습니다.</li>
								<li><br></li>
								<%}else{%>
								<li style="font-size:0.8em;">입력하신 정보와 일치하는 계정을 찾았습니다.</li>
								<li>아이디 : <%=fid%></li>
								<li><br></li>
								<%}}%>
								<li>이름</li>
								<li><input type="text" name="u_name" class="u_name"
									style="width: 40%; min-width: 200px;"></li>
								<li>이메일</li>
								<li><input type="text" name="emid" class="emid">@<input
									type="text" id="fidEmadd"  name="emadd" class="emadd" onchange="emadd()">
									<select class="emsel" name="emsel" onchange="emselF('fid')">
										<option value="" selected>직접입력</option>
										<option value="naver.com">네이버</option>
										<option value="gmail.com">G메일</option>
										<option value="daum.com">다음</option>
										<option value="nate.com">네이트</option>
								</select></li>
							</ul>
							<input type="submit" value="아이디 찾기"
								style="cursor: pointer;"> 
								<input type="button" value="돌아가기" onclick="location.href='/login'"
								style="cursor: pointer;"><br>
						</form>
					</div>
					<div>
						<form id="fpw" method="post" action="/find/pw.do">
							<ul>
								<li><b>비밀번호 찾기</b></li>
								<li><br></li>
								<%if(fpw!=null){%>
								<li>비밀번호 찾기 결과</li>
								<%if(fpw.equals("0")){%>
								<li style="font-size:0.8em;">입력하신 정보와 일치하는 계정이 없습니다.</li>
								<li><br></li>
								<%}else{%>
								<li style="font-size:0.8em;">입력하신 정보와 일치하는 계정을 찾았습니다.</li>
								<li>비밀번호 : <%=fpw%></li>
								<li>비밀번호 힌트 : <%=fhint.equals("null")?"힌트를 설정하지 않았습니다.":fhint%></li>
								<li><br></li>
								<%}}%>
								<li>이름</li>
								<li><input type="text" name="u_name" class="u_name"
									style="width: 40%; min-width: 200px;"></li>
								<li>아이디</li>
								<li><input type="text" name="u_id" class="u_id"
									style="width: 40%; min-width: 200px;"></li>
								<li>이메일</li>
								<li><input type="text" name="emid" class="emid">@<input
									type="text" id="fpwEmadd" name="emadd" class="emadd" onchange="emadd()">
									<select class="emsel" name="emsel" onchange="emselF('fpw')">
										<option value="" selected>직접입력</option>
										<option value="naver.com">네이버</option>
										<option value="gmail.com">G메일</option>
										<option value="daum.com">다음</option>
										<option value="nate.com">네이트</option>
								</select></li>
							</ul>
							<input type="submit" name="fpw" value="비밀번호 찾기"
								style="cursor: pointer;"><input type="button" value="돌아가기" onclick="location.href='/login'"
								style="cursor: pointer;"> <br>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="bot"></div>
</body>
</html>