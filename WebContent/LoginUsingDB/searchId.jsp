<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="./color.jsp" %>
<%@ page import = "logon.LogonDataBean" %>    
<%@ page import = "logon.LogonDBBean" %>    
    
<% request.setCharacterEncoding("euc-kr"); %>    
    
<%
	String name = request.getParameter("name");
	String jumin1 = request.getParameter("jumin1");
	String jumin2 = request.getParameter("jumin2");
	String s = "";
	
	
	LogonDBBean ldb = LogonDBBean.getInstance();
	s = ldb.FindUserId(jumin1, jumin2, name);		
	LogonDataBean data = new LogonDataBean();
	
	
%>  

<html>
<head>
<title>아이디 찾기</title>
</head>
<body>
<center>
<form action="main.jsp">
<%
if(s != null){
%>  
<%= name %>님에 아이디는 <b><%= s %></b> 입니다.<p>
                  <input type = "submit" value = "메인으로..">

<% } else { %>

이름 또는 주민등록번호가 틀렸습니다.<p>
                             <input type = "button" value = "다시 입력하기" onclick = 
                        "window.location='searchIdForm.jsp'">
<%} %>
</form>
</center>
</body>
</html>

