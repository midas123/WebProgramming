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
<title>���̵� ã��</title>
</head>
<body>
<center>
<form action="main.jsp">
<%
if(s != null){
%>  
<%= name %>�Կ� ���̵�� <b><%= s %></b> �Դϴ�.<p>
                  <input type = "submit" value = "��������..">

<% } else { %>

�̸� �Ǵ� �ֹε�Ϲ�ȣ�� Ʋ�Ƚ��ϴ�.<p>
                             <input type = "button" value = "�ٽ� �Է��ϱ�" onclick = 
                        "window.location='searchIdForm.jsp'">
<%} %>
</form>
</center>
</body>
</html>

