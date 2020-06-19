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
<style>
input:focus {
	outline: none;
}

#main_contents ul {
	list-style: none;
	text-align: left;
	display: inline;
	position: relative;
}

.toptool ul {
	margin-left: 32px;
}

#main_contents h1 {
	font-size: 3em;
	transition: all .5s;
}

#main_contents b {
	font-size: 2em;
	transition: all .5s;
}

#con {
	width: auto;
}

.topspace {
	height: calc(10vw + 5vh);
	min-height: 60px;
	max-height: 180px;
}

textarea {
	padding-left: 15px;
	width: calc(100% - 15px);
	max-width: 900px;
	height: 200px;
	resize: none;
}

#next_btn {
	float: right;
	background-color: rgb(250, 250, 250);
	border: 0;
	width: 150px;
	height: 52px;
	transition: all .5s;
	margin: 5px 10px 10px 10px;
	cursor: pointer;
	border-radius: 50px;
	box-shadow: 0 10px 0 0 rgb(150, 150, 150);
	transition: all .3s;
}

#next_btn:hover {
	margin-top: 7px;
	box-shadow: 0 8px 0 0 rgb(150, 150, 150);
}

#next_btn:active {
	background-color: rgb(230, 230, 230);
	margin-top: 13px;
	box-shadow: 0 2px 0 0 rgb(150, 150, 150);
	transition: all .05s;
}

#main_contents li b {
	font-size: 1.4em;
	transition: all .5s;
}

@media screen and (max-width: 650px) {
	#con {
		width: calc(100% - 30px);
		padding: 15px 15px 70px 15px;
		transition: all .5s;
	}
	#main_contents h1 {
		font-size: 1.7em;
		transition: all .5s;
	}
	#main_contents li b {
		font-size: 1em;
		transition: all .5s;
	}
}
</style>

<script src="../js/jquery-3.5.0.js"></script>
<script>
	function scrlBot(str) {
		let scr = document.getElementById(str + '_policy');
		if (scr.scrollHeight < scr.scrollTop + 220) {
			let ck = document.getElementById(str + '_ck');
			ck.disabled = false;
			ck.style = "cursor: pointer;";
			let lb = document.getElementById(str + '_label');
			lb.style = "cursor: pointer; opacity:1;";
		}
	}

	$(document)
			.ready(
					function() {
						$("form")
								.submit(
										function() {
											let uc = document
													.getElementById('user_ck').checked;
											let ic = document
													.getElementById('info_ck').checked;
											if (uc && ic) {
												return true;
											} else {
												alert('필수 사항에 동의하셔야 회원가입이 가능합니다.');
												if (!uc) {
													$('#user_warn')
															.css(
																	"border-bottom",
																	"1px solid rgb(255,0,0)");
													location
															.assign("#user_policy");
												}
												if (!ic) {
													$('#info_warn')
															.css(
																	"border-bottom",
																	"1px solid rgb(255,0,0)");
													location
															.assign("#info_policy");
												}
												return false;
											}
										});
					});
</script>
</head>
<body>
	<div id="top"></div>
	<%@ include file="../part/topMenu.jspf"%>
	<%@ include file="../part/sideMenu.jspf"%>
<div class="main">
	<div id="contents">
		<div class="topspace"></div>
		<div id="main_contents">
			<div id="con">
				<form action="<%=commons.baseUrl%>join/info" method="post">
					<ul>
						<li><h1>Join us!</h1></li>
						<li><b>회원가입</b></li>
						<li><br> <br> <br></li>
						<li><b>※ Lorem ipsum 홈페이지 이용 정책</b></li>
						<li><textarea id="user_policy" readonly
								onscroll="scrlBot('user')">
1. Veniam est ut anim excepteur occaecat ea elit sit nisi cupidatat amet irure officia.

Minim enim quis ut proident labore laborum amet est adipisicing ea veniam enim. Anim tempor qui veniam ea commodo ullamco mollit ullamco ut do. Elit consequat aliqua laborum dolore magna enim ut mollit quis laborum deserunt veniam excepteur. Culpa voluptate minim excepteur exercitation eu. Excepteur mollit eu eu tempor mollit consequat consequat commodo anim sit cillum deserunt pariatur dolor. Consectetur exercitation amet labore id.



2. Sunt duis sit et amet excepteur eiusmod nostrud.

Cillum eu consequat elit velit eiusmod laboris. Eu exercitation voluptate duis anim mollit ex labore irure minim irure ad et velit. Eiusmod nulla elit ad amet magna ut nisi.



3.Sit voluptate qui ut esse.

Adipisicing in magna minim minim consectetur excepteur excepteur eu. Aliquip dolore ullamco aliquip officia dolore in veniam pariatur culpa irure dolor magna pariatur. Cillum pariatur excepteur nulla commodo esse magna cillum dolore. Ex reprehenderit sit deserunt ad aute laboris cupidatat consectetur in sunt minim velit. Velit magna aute est et. Nostrud laborum aliqua labore quis sint aute fugiat.



4. Magna et labore ipsum irure esse sit proident deserunt velit ipsum laborum do reprehenderit cillum.

Quis culpa reprehenderit mollit et eu esse adipisicing nulla ut minim elit qui ullamco mollit. Officia adipisicing sit enim quis elit minim deserunt dolor esse ex consequat voluptate adipisicing irure. Adipisicing excepteur consectetur aliqua velit occaecat. Exercitation tempor ipsum dolore adipisicing cupidatat laborum ad id reprehenderit adipisicing deserunt eu culpa. Amet esse amet incididunt sunt in amet amet proident ea. Aute deserunt irure adipisicing adipisicing occaecat nostrud ex.



5. Labore amet deserunt excepteur labore nulla velit velit laboris.

Nulla nostrud proident cillum est deserunt deserunt. Sit id elit duis do qui non et consequat id do nisi. Elit ipsum velit id eu veniam. Eiusmod elit in do non Lorem aliqua. Sint proident ipsum aliqua do elit do ex duis quis sunt est minim. Dolor fugiat proident cupidatat dolore officia cupidatat nulla. Ullamco non non magna esse amet excepteur voluptate veniam.



6. Tempor excepteur ut ex amet labore nostrud exercitation do duis et deserunt.

Officia pariatur laborum culpa aliqua eiusmod minim id eiusmod aute mollit officia laborum laboris. Incididunt laboris in anim ea duis pariatur nostrud nulla esse nostrud officia aliqua exercitation. Commodo elit consequat nisi aute irure. Magna veniam et incididunt ad laboris aliqua nostrud tempor reprehenderit amet nisi. Proident qui duis eiusmod commodo consectetur fugiat sint do. Velit Lorem dolor qui aliqua tempor amet irure minim.

Nostrud Lorem proident nostrud aute officia dolor nostrud nulla ullamco. Cillum ad voluptate est irure nulla enim id nostrud voluptate. Culpa laborum aliqua labore aute est aute nisi laborum. Id Lorem aliquip ea irure duis anim nostrud ipsum officia nulla. Nisi consectetur elit nulla minim dolore eiusmod nulla deserunt in voluptate consequat fugiat in velit. Laboris occaecat non laborum reprehenderit excepteur reprehenderit. Ut excepteur nostrud dolor labore.


                    </textarea></li>
						<li id="user_warn"><input type="checkbox" id="user_ck"
							name="user_ck" value='true' disabled><label
							id="user_label" for="user_ck" style="opacity: 0.3;">Lorem
								ipsum 홈페이지 이용 정책에 동의합니다. </label><label style="color: red;">(필수)</label></li>
						<li><br> <br></li>
						<li><b>※ Lorem ipsum 회원가입 및 개인정보 정책</b></li>
						<li><textarea id="info_policy" readonly
								onscroll="scrlBot('info')">
1. Veniam est ut anim excepteur occaecat ea elit sit nisi cupidatat amet irure officia.

Minim enim quis ut proident labore laborum amet est adipisicing ea veniam enim. Anim tempor qui veniam ea commodo ullamco mollit ullamco ut do. Elit consequat aliqua laborum dolore magna enim ut mollit quis laborum deserunt veniam excepteur. Culpa voluptate minim excepteur exercitation eu. Excepteur mollit eu eu tempor mollit consequat consequat commodo anim sit cillum deserunt pariatur dolor. Consectetur exercitation amet labore id.



2. Sunt duis sit et amet excepteur eiusmod nostrud.

Cillum eu consequat elit velit eiusmod laboris. Eu exercitation voluptate duis anim mollit ex labore irure minim irure ad et velit. Eiusmod nulla elit ad amet magna ut nisi.



3.Sit voluptate qui ut esse.

Adipisicing in magna minim minim consectetur excepteur excepteur eu. Aliquip dolore ullamco aliquip officia dolore in veniam pariatur culpa irure dolor magna pariatur. Cillum pariatur excepteur nulla commodo esse magna cillum dolore. Ex reprehenderit sit deserunt ad aute laboris cupidatat consectetur in sunt minim velit. Velit magna aute est et. Nostrud laborum aliqua labore quis sint aute fugiat.



4. Magna et labore ipsum irure esse sit proident deserunt velit ipsum laborum do reprehenderit cillum.

Quis culpa reprehenderit mollit et eu esse adipisicing nulla ut minim elit qui ullamco mollit. Officia adipisicing sit enim quis elit minim deserunt dolor esse ex consequat voluptate adipisicing irure. Adipisicing excepteur consectetur aliqua velit occaecat. Exercitation tempor ipsum dolore adipisicing cupidatat laborum ad id reprehenderit adipisicing deserunt eu culpa. Amet esse amet incididunt sunt in amet amet proident ea. Aute deserunt irure adipisicing adipisicing occaecat nostrud ex.



5. Labore amet deserunt excepteur labore nulla velit velit laboris.

Nulla nostrud proident cillum est deserunt deserunt. Sit id elit duis do qui non et consequat id do nisi. Elit ipsum velit id eu veniam. Eiusmod elit in do non Lorem aliqua. Sint proident ipsum aliqua do elit do ex duis quis sunt est minim. Dolor fugiat proident cupidatat dolore officia cupidatat nulla. Ullamco non non magna esse amet excepteur voluptate veniam.



6. Tempor excepteur ut ex amet labore nostrud exercitation do duis et deserunt.

Officia pariatur laborum culpa aliqua eiusmod minim id eiusmod aute mollit officia laborum laboris. Incididunt laboris in anim ea duis pariatur nostrud nulla esse nostrud officia aliqua exercitation. Commodo elit consequat nisi aute irure. Magna veniam et incididunt ad laboris aliqua nostrud tempor reprehenderit amet nisi. Proident qui duis eiusmod commodo consectetur fugiat sint do. Velit Lorem dolor qui aliqua tempor amet irure minim.

Nostrud Lorem proident nostrud aute officia dolor nostrud nulla ullamco. Cillum ad voluptate est irure nulla enim id nostrud voluptate. Culpa laborum aliqua labore aute est aute nisi laborum. Id Lorem aliquip ea irure duis anim nostrud ipsum officia nulla. Nisi consectetur elit nulla minim dolore eiusmod nulla deserunt in voluptate consequat fugiat in velit. Laboris occaecat non laborum reprehenderit excepteur reprehenderit. Ut excepteur nostrud dolor labore.


                    </textarea>
						<li id="info_warn"><input type="checkbox" id="info_ck"
							name="info_ck" value='true' disabled><label
							id="info_label" for="info_ck" style="opacity: 0.3;">Lorem
								ipsum 회원가입 및 개인정보 제공에 동의합니다. </label><label style="color: red;">(필수)</label></li>
						<li><br> <br> <br></li>
						<li><input type="submit" value="다음" id="next_btn"></li>
					</ul>
				</form>
			</div>
		</div>
	</div>
</div>

	<div id="bot"></div>
</body>