<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "apr06.LogonDBBean" %>
<%@ include file="./color.jsp" %>    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ID �ߺ�Ȯ��</title>
<link href="style.css" rel="stylesheet" type="text/css">

<% request.setCharacterEncoding("euc-kr"); %>

<% 
	String id = request.getParameter("id");
	LogonDBBean manager = LogonDBBean.getInstance();
	int check = manager.confirmId(id);
%>
</head>
<body bgcolor="<%= bodyback_c %>">
<%
	if(check ==1) {
%>
<table width="270" border="0" cellspacing="0" cellpadding="5">
	<tr bgcolor="<%=title_c %>">
		<td height="="39"><%=id %>�̹� ������� ���̵��Դϴ�.</td>
	</tr>	
</table>

<form name="checkForm" method="post" action="action="confirmId.jsp">
<table width="200" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td bgcolor="<%=value_c %>" align="center">
		�ٸ� ���̵� �����ϼ���.<p>
		<input type="text" size="10" maxlength="12" name="id">
		<input type="submit" value="ID�ߺ�Ȯ��">
		</td>
	</tr>	
</table>
</form>
<%
	} else {
%>
<table width="270" border="0" cellspacing="0" cellpadding="5">
	<tr bgcolor="<%= title_c %>">
		<td align="center">
			<p>�Է��Ͻ� <%=id %> �� ����Ͻ� �� �ִ� ID�Դϴ� </p>
			<input type="button" value="�ݱ�" onclick="setid()">
		</td>
	</tr>
</table>
<%
	}
%>
</body>
</html>
<script language="javascript">
<!--
 function setid()
 {
	opener.document.userinput.id.value="<%=id%>";
 	self.close();
 }

-->
</script>
