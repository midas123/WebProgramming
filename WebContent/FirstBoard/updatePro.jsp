<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "logon.BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("euc-kr"); %>

<jsp:useBean id="article" scope="page" class="logon.BoardDataBean">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>	

<%
	String pageNum = request.getParameter("pageNum");

	BoardDBBean dbPro = BoardDBBean.getInstance();
	int check = dbPro.updateArticle(article);
	System.out.println("check:"+check);
	if(check==1){
%>00
<meta http-equiv="Refresh" content="0;url=list2-1.jsp?pageNum=<%=pageNum %>">
<%}else{ %>
	<script language="javascript">
	<!--
	alert("��й�ȣ�� ���� �ʽ��ϴ�.");
	history.go(-1);
	-->
	</script>
<% } %>

<html>
<head>
<title>Insert title here</title>
</head>
<body>

</body>
</html>