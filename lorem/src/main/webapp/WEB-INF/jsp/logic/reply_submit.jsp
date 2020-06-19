
<%@page import="com.lorem.ipsum.commons"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String msg = (String) request.getAttribute("msg");
%>

<link rel="shortcut icon" href="../source/favi/favicon.ico">
<script>
		if(msg!=null){
			alert(msg);
			}
		if (confirm("로그인이 필요합니다.\n로그인 하시겠습니까?")) {
			history.replaceState({}, null, document.referrer);
			location.href = "<%=commons.baseUrl%>/login";
		}
		else{
			history.back();
		}
</script>