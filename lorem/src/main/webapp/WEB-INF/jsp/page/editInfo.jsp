<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String u_nick = (String) request.getAttribute("u_nick");
String u_email = (String) request.getAttribute("u_email");
String u_phnum = (String) request.getAttribute("u_phnum");
String u_intro = (String) request.getAttribute("u_intro");
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
<link rel="shortcut icon" href="../source/favi/favicon.ico">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/editInfo.css">
<title>개인정보</title>

<script>
function sm(){
	if($('#nkck').val()=="false"){
		alert("닉네임 중복 확인을 해 주세요.");
		return false;
	}else if($('#u_email').val().match(/.+@.+\..+/)==null){
		alert("이메일은 '아이디@포털이름.도메인'의 형식으로 입력되어야 합니다.");
		return false;
	}else if($('#u_phnum').val().length<11||$('#u_phnum').val().match(/.*[^0-9].*/)!=null){
		alert("전화번호는 '-'를 제외한 숫자 11자리가 입력되어야 합니다.");
		return false;
	}
 	else if($('#prv_pw').val().length<9){
 		alert("비밀번호가 옳바르지 않습니다.");
 		return false;
 	}else if($('#new_pw').val().length>0&&$('#new_pw').val()!=$('#new_pwck').val()){
			alert($('#new_pw').val()+"\n"+$('#new_pwck').val()+"\n비밀번호 확인 값이 다릅니다.");
	 		return false;
 	}
 	var d={u_nick:$('#u_nick').val(), 
 		 	prv_pw: $('#prv_pw').val(), 
 		 	new_pw:$('#new_pw').val(),
 		 	u_email:$('#u_email').val(),
 		 	u_phnum:$('#u_phnum').val(),
 		 	u_intro:$('#u_intro').val()};
 	$.ajax({
		type:"POST",
		dataType:"script",
		url:"../info/edit.do",
		data: d,
		async:true,
		success:function(returnData){
			
		},
		error:function(){
			alert("수정 중 오류가 발생했습니다.");
		}
	});
}

function fnkck(){
	var nick=$("#u_nick").val();
	if(nick==null||nick.length==0){
		alert("닉네임을 입력해주세요.");
		return;
		}
	if(nick.length>10){
		alert("닉네임은 10글자 이하로 설정하실 수 있습니다.");
		return;
		}
	if(new RegExp(/(\s)/,'i').exec(nick)!=null){
		alert("닉네임에 공백문자는 포함 될 수 없습니다.");
		return;
		}

	$.ajax({
		type:"POST",
		dataType:"text",
		url:"../join/nkduple.do",
		data: {value:nick},
		cache:false,
		async:true,
		success: function(returnData){
			if(returnData=='true'){
				alert("사용하실 수 있는 닉네임입니다.");
				$("#nkck").val("true");

			}else if(returnData=='duple'){
				if(nick=='<%=u_nick%>') {
						$("#nkck").val("true");
					} else
						alert("이미 사용중인 닉네임입니다.");
				} else {
					alert("\'" + returnData + "\'문자열은 사용할 수 없습니다.");
				}

			},
			error : function(requset, error) {
				alert("중복 확인중 오류가 발생했습니다");
				console.log(requset);
			}

		});
	}
</script>

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
					<h1>개인정보 수정</h1>
					<br> <br>
					<div id="pubInf" class="dashedCon">
						<form id="efrm" method="post">
							<table class="paddingTable">
								<tr>
									<td colspan="3" style="text-align: center;"><h3>가입정보</h3></td>
								</tr>
								<tr>
									<td style="font-weight: bold;">닉네임</td>
									<td><input type="text" class="roundIpt" id='u_nick'
										name="u_nick" value="<%=u_nick%>"></td>
									<td><input type="button" class="roundBtn" value="중복확인"
										onclick='fnkck()' onkeydown="$('#nkck').val()='false'"><input
										type="hidden" id=nkck value="true"></td>
								</tr>
								<tr>
									<td style="font-weight: bold;">기존 비밀번호</td>
									<td colspan="2"><input type="password" name="prv_pw"
										id="prv_pw" class="roundIpt"></td>
								</tr>
								<tr>
									<td style="font-weight: bold;">새 비밀번호</td>
									<td colspan="2"><input type="password" name="new_pw"
										id="new_pw" class="roundIpt"></td>
								</tr>
								<tr>
									<td style="font-weight: bold;">새 비밀번호 확인</td>
									<td colspan="2"><input type="password" name="new_pwck"
										id="new_pwck" class="roundIpt"></td>
								</tr>
								<tr>
									<td style="font-weight: bold;">이메일</td>
									<td colspan="2"><input type="text" name="u_email"
										id="u_email" class="roundIpt"
										value="<%=u_email == null ? "정보없음" : u_email%>"></td>
								</tr>
								<tr>
									<td style="font-weight: bold;">전화번호</td>
									<td colspan="2"><input type="text" name="u_phnum"
										id="u_phnum" class="roundIpt"
										value="<%=u_phnum == null ? "" : u_phnum%>"></td>
								</tr>
								<tr>
									<td style="font-weight: bold;">소개글</td>
									<td colspan="2"><textarea rows="5" name="u_intro"
											id="u_intro" class="roundIpt"><%=u_intro == null ? "" : u_intro%></textarea></td>
								</tr>
								<tr>
									<td colspan="3"><input class="roundBtn pbtn" type="submit"
										value="수정" onclick="sm()"> <input class="roundBtn pbtn" type="button"
										value="취소" style="float: right;"
										onclick="if(confirm('수정을 취소하시겠습니까?'))location.href='../info';"></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="bot"></div>
</body>
</html>