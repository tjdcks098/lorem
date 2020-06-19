<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String msg=(String)request.getAttribute("msg");
String url=(String)request.getAttribute("redirect");
String b_name=(String)request.getAttribute("name");
String p_id=(String)request.getAttribute("postId");
if(b_name!=null||p_id!=null){
	url+="?";
	if(b_name!=null)url+="&name="+b_name;
	if(p_id!=null)url+="&postId="+p_id;
}

%>

<link rel="shortcut icon" href="../source/favi/favicon.ico">
<script>
var msg='<%=msg==null?"":msg%>';
if(msg!="")alert(msg);
location.href='<%=url%>';
</script>



