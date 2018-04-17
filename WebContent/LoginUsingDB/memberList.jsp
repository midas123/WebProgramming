<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="color.jsp" %> 
<%@ page import="logon.*" %>
<%@ page import ="java.util.List" %>

<%!
	int pageSize=10; //10
%>

<%-- <%
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
	int startRow = (currentPage *10) -9; //10 -9
	int endRow = currentPage * pageSize;
	int count =0;
	int number = 0;
	
	List articleList = null;
	BoardDBBean dbPro = BoardDBBean.getInstance();
	
	if(search.equals("") || search == null)
		count = dbPro.getArticleCount();
	else
		count = dbPro.getArticleCount(searchn,search);
	
	
	if(count>0)
	{
		if(search.equals("") || search == null)
			articleList = dbPro.getArticles(startRow, endRow);
		else
			articleList = dbPro.getArticles(startRow, endRow, searchn, search);
	}
	 
	number=count-(currentPage-1)*pageSize;
%> --%>
<%! int count=1; %>   
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c %>">
<center><b>회원목록(전체:<%-- <%=count %> --%>)</b>
<table width="700">
<tr>
	<td align="right" bgcolor="<%=value_c %>">
	<a href="writeForm.jsp">글쓰기</a>
	</td>
</tr>
</table>

<%
	if(count == 0){
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
	<td align="center">
	가입된 회원이 없습니다.
	</td>
</tr>	
</table>
<% }else{ %>
<table border="1" width="1000" cellpadding="0" cellspacing="0" align="center">
	<tr height="30" bgcolor="<%=value_c %>">
		<td align="center" width="100">ID</td>
		<td align="center" width="100">PASSWD</td>
		<td align="center" width="100">이름</td>
		<td align="center" width="100">주민번호 앞</td>
		<td align="center" width="100">주민번호 뒤</td>
		<td align="center" width="100">이메일</td>
		<td align="center" width="100">블로그</td>
		<td align="center" width="100">가입날짜</td>
		<td align="center" width="100">우편번호</td>
		<td align="center" width="200">주소</td>
	</tr>

<%
}
%>

</body>
</html>