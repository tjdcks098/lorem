
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



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
function idck(){
	var id=$("#id").val();
	if(id==null||id.length<5){
		$("#idckMsg").html("아이디는 5글자 이상으로 설정하실 수 있습니다.");
		return;
		}
	if(id.length>15){
		$("#idckMsg").html("아이디는 15글자 이하로 설정하실 수 있습니다.");
		return;
		}
	if(new RegExp(/([^0-9])([^a-z])/,'i').exec(id)!=null){
		$("#idckMsg").html("아이디는 영문 대,소문자와 숫자로만 이루어져야 합니다.");
		return false;
		}
	$.ajax({
		type:"POST",
		dataType:"text",
		url:"../join/idduple.do",
		data: {value:id},
		cache:false,
		async:true,
		success: function(returnData){
			if(returnData=='true'){
				$("#idckMsg").html("사용하실 수 있는 아이디입니다.");
				$("#idck").val("true");
			}else if(returnData=='duple'){
				$("#idckMsg").html("이미 사용중인 아이디입니다.");
			}else{
				$("#idckMsg").html("\'"+returnData+"\'문자열은 사용할 수 없습니다.");
			}
			
		},
		error: function(requset, error){
			alert("중복 확인중 오류가 발생했습니다");
			console.log(requset);
		}

	});
}

function fnkck(){
	var nick=$("#nic").val();
	if(nick==null||nick.length==0){
		$("#idckMsg").html("닉네임을 입력해주세요.");
		return;
		}
	if(nick.length>10){
		$("#idckMsg").html("닉네임은 10글자 이하로 설정하실 수 있습니다.");
		return;
		}
	if(new RegExp(/(\s)/,'i').exec(nick)!=null){
		$("#idckMsg").html("닉네임에 공백문자는 포함 될 수 없습니다.");
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
				$("#idckMsg").html("사용하실 수 있는 닉네임입니다.");
				$("#nkck").val("true");

			}else if(returnData=='duple'){
				$("#idckMsg").html("이미 사용중인 닉네임입니다.");
			}else{
				$("#idckMsg").html("\'"+returnData+"\'문자열은 사용할 수 없습니다.");
			}
			
		},
		error: function(requset, error){
			alert("중복 확인중 오류가 발생했습니다");
			console.log(requset);
		}

	});
}
</script>
<script src="../js/join_submit.js"></script>


<link rel="stylesheet" href="../css/join_info.css">

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
				<form action="../join.do" method="post">
					<table>
						<tr>
							<td colspan="3" style=" text-align: center; padding-bottom: 30px;"><h1>회원
									정보</h1></td>
						</tr>
						<tr>
							<td colspan="3" style="padding:0; margin:0; height:30px;color:red; text-align: center;"><p id="idckMsg"></p></td>
						</tr>
						<tr>
							<td><label for="id">아이디</label></td>
							<td><input type="text" id="id" name="u_id" onfocus="this.select()" onkeydown="idchg()"></td>
							<td><input type="hidden" id="idck" name="idck" value="false"><label class="ck_btn" for="idck" onclick="idck()">중복확인</label></td>
						</tr>
						<tr>
							<td>닉네임</td>
							<td><input type="text" id="nic" name="u_nick" onfocus="this.select()"onkeydown="nkchg()"></td>
							<td><input type="hidden" id="nkck" name="nkck" value="false"><label class="ck_btn" for="nkck" onclick="fnkck()">중복확인</label></td>
						</tr>
						<tr>
							<td>이름</td>
							<td><input type="text" id="name" name="u_name" onfocus="this.select()"></td>
							<td></td>
						</tr>
						<tr>
							<td><label for="pw">비밀번호</label></td>
							<td><input type="password" id="pw" name="u_pw" onfocus="this.select()" onblur="pwck2()"></td>
							<td></td>
						</tr>
						<tr>
							<td><label for="pw">비밀번호 확인</label></td>
							<td><input type="password" id="pw_ck"
								onfocus="this.select()" onkeyup="pwck1()" onblur="pwck2()"><br>&nbsp; <label
								id="pw_ck_lb"
								style="color: red; font-size: 0.8em; text-decoration: underline;"></label>
								<input type="hidden" id="pwck" name="pwck" value="false"></td>
						</tr>
						<tr>
							<td><label for="pw_hint">비밀번호 힌트</label></td>
							<td colspan="2"><input type="text" id="pw_hint" name="find_hint"
								onfocus="this.select()" style="width: calc(100% - 10px);"></td>

						</tr>
						<tr>
							<td>이메일</td>
							<td><input type="text" id="emid" name="emid" onfocus="this.select()">
								@ <input type="text" id="emadd" name="emadd" onchange="emselp()"
								onfocus="this.select()"></td>
							<td><select id="emsel" onchange="emsel_func()">
									<option selected>직접입력</option>
									<option value="naver.com">네이버</option>
									<option value="gmail.com">G메일</option>
									<option value="daum.com">다음</option>
									<option value="nate.com">네이트</option>
							</select></td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td colspan="2"><select id="phhead" name="phhead">
									<option value="010" selected>010</option>
									<option value="011">011</option>
									<option value="012">012</option>
							</select> <label>-</label> <input type="text" id="phmid"name="phmid" maxlength="4"
								onfocus="this.select()" onkeyup="numonly(this)"
								onkeydown="numonly(this)"> <label>-</label> <input
								type="text" id="phlast" name="phlast" maxlength="4" onfocus="this.select()"
								onkeyup="numonly(this)" onkeydown="numonly(this)"></td>

						</tr>
						<tr>
							<td>생년월일</td>
							<td><input type="date" id="birthdate" name="u_birth" value=""></td>
							<td></td>
						</tr>
					</table>
					<input type="submit" value="가입하기" id="next_btn">
					</form>
				</div>
			</div>
		</div>
	</div>
