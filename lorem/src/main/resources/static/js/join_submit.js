
	function numonly(text) {
		text.value = text.value.replace(/[^0-9]/g, '');
	}

	function emsel_func() {
		let add = document.getElementById('emadd');
		let sel = document.getElementById('emsel');
		if (sel.value != '직접입력') {
			add.value = sel.value;
		} else {
			add.value = "";
		}
	}
	function emselp() {
		$("#emsel option:eq(0)").prop("selected",true);
	}
	function pwck2() {
		let pwck=document.getElementById("pwck");
		pwck.value="false";
		let pw = document.getElementById("pw").value;
		let pw_ck = document.getElementById("pw_ck").value;
		let lb = document.getElementById("pw_ck_lb");
		if(pw.length<9){
			lb.innerHTML="비밀번호는 9자 이상이여야 합니다.";
			return;
		}
		if(pw_ck==null || pw_ck=="")return;
		if (pw.length != pw_ck.length) {
			lb.innerHTML = "비밀번호가 다릅니다";
			return;
		}
		let len = pw.length > pw_ck.length ? pw_ck.length : pw.length;
		for (let i = 0; i < len; i++) {
			if (pw[i] != pw_ck[i]) {
				lb.innerHTML = "비밀번호가 다릅니다";
				return;
			}
		}
		lb.innerHTML = "";
		pwck.value="true";
	}
	function pwck1() {
		let pwck=document.getElementById("pwck");
		pwck.value="false";
		let pw = document.getElementById("pw").value;
		let pw_ck = document.getElementById("pw_ck").value;
		let lb = document.getElementById("pw_ck_lb")
		if (pw.length < pw_ck.length) {
			lb.innerHTML = "비밀번호가 다릅니다";
			return;
		}
		if(new RegExp(/([^A-Z])([^a-z])([^0-9])/,'i').exec(pw)!=null){
			alert("비밀번호는 영문 대문자, 소문자 그리소 숫자를 포함해야합니다.");
			return;
		}
		let len = pw.length > pw_ck.length ? pw_ck.length : pw.length;
		for (let i = 0; i < len; i++) {
			if (pw[i] != pw_ck[i]) {
				lb.innerHTML = "비밀번호가 다릅니다";
				return;
			}
		}
		lb.innerHTML = "";
	}
	function idchg(){
		var idck=document.getElementById("idck");
		idck.value="false";
		var msg=document.getElementById("idckMsg");
		msg.innerHTML="";
	}
	function nkchg(){
		var nkck=document.getElementById("nkck");
		nkck.value="false";
		var msg=document.getElementById("idckMsg");
		msg.innerHTML="";
	}
	
	$(document).ready(function() {
		$("form").submit(function() {
			if ($("#idck").val() != "true") {
				alert("아이디 중복체크가 필요합니다.");
				$("#idckMsg").html("아이디 중복체크가 필요합니다.");
				$("#id").focus();
				return false;
			} else if ($("#nkck").val() != "true") {
				consoloe.log($("#nkck").val());
				alert("닉네임 중복체크가 필요합니다.");
				$("#idckMsg").html("닉네임 중복체크가 필요합니다.");
				$("#nic").focus();
				return false;
			} else if($("#name").val()==null||$("#name").val()=="") {
				alert("이름을 입력해 주세요.");
				$("#name").focus();
				return false;
			}else if($("#pwck").val()=="false") {
				alert("비밀번호가 잘못되었습니다.");
				$("#pw").focus();
				return false;
			}  else if($("#pw_hint").val()==null||$("#pw_hint").val()=="") {
				alert("비밀번호 힌트를 입력해 주세요.");
				$("#pw_hint").focus();
				return false;
			} else if($("#emid").val()==null||$("#emid").val()==""||$("#emadd").val()==null||$("#emadd").val()=="") {
				alert("이메일을 입력해 주세요.");
				if($("#emadd").val()==null||$("#emadd").val()=="")$("#emadd").focus();
				if($("#emid").val()==null||$("#emid").val()=="")$("#emid").focus();
				return false;
			} else if($("#phmid").val()==null||$("#phmid").val()==""||$("#phlast").val()==null||$("#phlast").val()=="") {
				alert("전화번호를 입력해 주세요.");
				if($("#phlast").val()==null||$("#phlast").val()=="")$("#phlast").focus();
				if($("#phmid").val()==null||$("#phmid").val()=="")$("#phmid").focus();
				return false;
			} else if($("#birthdate").val()==null||$("#birthdate").val()=="") {
				alert("생년월일을 입력해 주세요.");
				$("#birthdate").focus();
				return false;
			}
		});
	});
	