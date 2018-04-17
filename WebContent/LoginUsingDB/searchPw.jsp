<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="logon.LogonDBBean" %>    
<%@ page import="logon.LogonDataBean" %>    
<%@ include file="./color.jsp"%>

<%
request.setCharacterEncoding("euc-kr");

%>    
    
<% 
String name = request.getParameter("name"); 
String id = request.getParameter("id"); 
String jumin1 = request.getParameter("jumin1"); 
String jumin2 = request.getParameter("jumin2"); 
String dbpasswd = "";


LogonDBBean db = LogonDBBean.getInstance();
dbpasswd = db.FindPasswd(id, name, jumin1, jumin2);

%>    
    
<html>
<head>
<title>비밀번호 찾기</title>
</head>
<body bgcolor = "<%= bodyback_c %>">
<center>
<form method = "post" action = "main.jsp">
<%
if(dbpasswd != null) {
%>
<%= id %>님에 비밀번호는 <b><%= dbpasswd %></b> 입니다.<p>
                  <input type = "submit" value = "메인으로..">
<%
}else {
%>
아이디, 이름 또는 주민등록번호가 틀렸습니다.<p>
                  <input type = "button" value = "다시 입력하기" onclick = 
                        "window.location='searchPwForm.jsp'">
<%
            }
%>



</p>
</form>
</center>
</body>
</html>