<%@page import="com.lorem.ipsum.commons"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script>
    <link rel="shortcut icon" href="../source/favi/favicon.ico">
<%
String logonMsg=(String)request.getAttribute("logonMsg");
System.out.println(logonMsg);
try{
	if(logonMsg.split(":")[0].equals("INVALID")){
		%>
		alert(logonMsg.split(":")[1]);
		<%
	}
}catch(Exception e){}
finally{
%>
	if(confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")){
	location.href="<%=commons.baseUrl%>login";
	}
	else{
	location.href="<%=(String)request.getAttribute("referer") %>";
	}
<%	
}

%></script>