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
<title>��й�ȣ ã��</title>
</head>
<body bgcolor = "<%= bodyback_c %>">
<center>
<form method = "post" action = "main.jsp">
<%
if(dbpasswd != null) {
%>
<%= id %>�Կ� ��й�ȣ�� <b><%= dbpasswd %></b> �Դϴ�.<p>
                  <input type = "submit" value = "��������..">
<%
}else {
%>
���̵�, �̸� �Ǵ� �ֹε�Ϲ�ȣ�� Ʋ�Ƚ��ϴ�.<p>
                  <input type = "button" value = "�ٽ� �Է��ϱ�" onclick = 
                        "window.location='searchPwForm.jsp'">
<%
            }
%>



</p>
</form>
</center>
</body>
</html>