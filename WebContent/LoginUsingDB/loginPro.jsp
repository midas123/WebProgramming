<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="logon.LogonDBBean" %>

<% request.setCharacterEncoding("euc-kr"); %>
    
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	Cookie cookie = new Cookie("memId", id);
	
	LogonDBBean manager= LogonDBBean.getInstance();
	int check = manager.userCheck(id,passwd);
	
	if(check==1){
		session.setAttribute("memId", id);
		response.sendRedirect("main.jsp");
		response.addCookie(cookie);
		System.out.println("Save cookie");
	} else if(check==0) {
%>

<script>
	alert("��й�ȣ�� ���� �ʽ��ϴ�.")
	history.go(-1); //?
</script>

<% }else { %>
<script>
	alert("���̵� �������� �ʽ��ϴ�.");
	history.go(-1);
</script>
<%} %>
