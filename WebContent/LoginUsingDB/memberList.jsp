<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="color.jsp" %> 
<%@ page import="logon.*" %>
<%@ page import ="java.util.List" %>

<%!
	int pageSize=3; //10
%>

<%
	request.setCharacterEncoding("euc-kr");
	String pageNum = request.getParameter("pageNum");
	String search = request.getParameter("search");

	int searchn=0;
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	if(search ==null){
		search ="";
	} else {
		searchn = Integer.parseInt(request.getParameter("searchn"));
	}
	
	int currentPage = Integer.parseInt(pageNum);
	System.out.println(currentPage);
	int startRow = (currentPage *3) -2; //10 -9
	int endRow = currentPage * pageSize;
	int count =0;
	int number = 0;
	
	List memberList = null;
	LogonDBBean dbPro = LogonDBBean.getInstance();
	
	if(search.equals("") || search == null)
		count = dbPro.getMemberCount();
	else
		count = dbPro.getMemberCount(searchn, search);
	if(count>0)
	{
		if(search.equals("") || search == null)
			memberList = dbPro.getMembers(startRow, endRow);
		
		else
			memberList = dbPro.getMembers(startRow, endRow, searchn, search);
			
	}
	

	number=count-(currentPage-1)*pageSize;
%>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c %>">
<center><b>ȸ�����(��ü:<%=count %>)</b>
<%-- <table width="700">
<tr>
	<td align="right" bgcolor="<%=value_c %>">
	<a href="writeForm.jsp">�۾���</a>
	</td>
</tr>
</table>
 --%>
<%
	if(count == 0){
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
	<td align="center">
	���Ե� ȸ���� �����ϴ�.
	</td>
</tr>	
</table>
<% }else{ %>
<table border="1" width="1000" cellpadding="0" cellspacing="0" align="center">
	<tr height="30" bgcolor="<%=value_c %>">
		<td align="center" width="100">ID</td>
		<td align="center" width="100">PASSWD</td>
		<td align="center" width="50">�̸�</td>
		<td align="center" width="60">�ֹι�ȣ ��</td>
		<td align="center" width="60">�ֹι�ȣ ��</td>
		<td align="center" width="100">�̸���</td>
		<td align="center" width="100">��α�</td>
		<td align="center" width="100">���Գ�¥</td>
		<td align="center" width="60">�����ȣ</td>
		<td align="center" width="200">�ּ�</td>
	</tr>
<%
	for(int i =0; i<memberList.size(); i++) {
		LogonDataBean member = (LogonDataBean)memberList.get(i);
%>
	<tr height="30">
		<td align="center"> <%=member.getId() %> </td>
		<td align="center"> <%=member.getPasswd() %> </td>
		<td align="center"> <%=member.getName() %> </td>
		<td align="center"> <%=member.getJumin1() %> </td>
		<td align="center"> <%=member.getJumin2() %> </td>
		<td align="center"> <%=member.getEmail() %> </td>
		<td align="center"> <%=member.getBlog() %> </td>
		<td align="center"> <%=member.getReg_date() %> </td>
		<td align="center"> <%=member.getZipcode() %> </td>
		<td align="center"> <%=member.getAddress() %> </td>
	</tr>



<%

}}%>
</table>

<%
	if(count>0) {
		// ��ü ������ ���� ����
		int pageCount = count /pageSize + (count % pageSize == 0 ? 0:1);
		
		int startPage = (int)(currentPage/5)*5+1;
		int pageBlock=5;
		int endPage = startPage + pageBlock-1;
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage>5){ 
			if(search.equals("") || search ==null)
			{
%>
<a href="memberList.jsp?pageNum=<%=startPage-5 %>">[����]</a>
<%
		}
			else
			{		
%>			
<a href="memberList?pageNum=<%=startPage -5 %>&search=<%=search %>&searchn=<%=searchn %>">[����]</a>
<%
			}
%>			
<%
		}
		
		for(int i = startPage; i<=endPage; i++)
		{
			if(search.equals("")||search== null)
			{
%>
<a href="memberList.jsp?pageNum=<%=i %>">[<%=i %>]</a>				
<%
			}
			else
			{
%>			
<a href="memberList.jsp?pageNum=<%=i %>&search=<%=search %>&searchn=<%=searchn %>">[<%=i %>]</a>
<%
			}
%>
<%
		}
		if(endPage < pageCount){
			if(search.equals("")||search==null)
			{
%>	
<a href="memberList.jsp?pageNum=<%=startPage + 5 %>">[����]</a>
<%
			}
			else
			{
%>
<a href="memberList.jsp?pageNum=<%=startPage + 5 %>&search=<%=search %>&searchn=<%=searchn %>">[����]</a>
<%
			}
%>
<%
		}
	}
%>


<form method="post">
<select name="searchn">
<option value="0">ID</option>
<option value="1">�̸�</option>
<option value="2">�ֹι�ȣ��</option>
</select>

<input type="text" name="search" size="15" maxlength="50"/>
<input type="submit" value="�˻�"/>
</form>

</body>
</html>
