<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="logon.BoardDBBean" %>
<%@ page import = "logon.BoardDataBean" %>
<%@ page import = "comment.CommentDataBean" %>
<%@ page import = "comment.CommentDBBean" %>
<%@ page import ="java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file="./color.jsp" %>

<%!
	int pageSize=3; //�� ȭ�鿡�� ������ ���� ���� ����,  10
	SimpleDateFormat sdf=
			new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>


<%
	request.setCharacterEncoding("euc-kr");
	String pageNum = request.getParameter("pageNum");
	String search = request.getParameter("search");

	
	/*
	Form�±�(name="searchn")���� ���� value ���� search(����� �Է� ��)�� ���� ��� ���� �� ������ 
	�����Ѵ�.
	
	��value �� ����
	0 -> �ۼ���
	1 - > ����
	2 -> ����
	*/
	
	int searchn=0;
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	if(search ==null){
		search ="";
	} else {
		searchn = Integer.parseInt(request.getParameter("searchn"));
	}
	
	
	/*
	--����¡--
	�Խñ��� pageSize�� ������ ���� ��� �������� �� �� ���� �� page ���� �ȴ�.
	startRow�� endRow�� ����������(currentPage)���� ������ �Խñ��� ó���� ���̴�.
	*/
	
	
	int currentPage = Integer.parseInt(pageNum);
	System.out.println(currentPage);
	int startRow = (currentPage *3) -2; //10 -9
	int endRow = currentPage * pageSize;
	int count =0;
	int number = 0;
	
	
	/*
	BoardDBBean �ڹٺ�(DTO)��ü���� ������ ���� �����´� .
	if -����� �Է� ���� ���� ��� count ������ getArticleCount() �޼ҵ忡��
	���� DB�� ��ü ���� ������ �����Ѵ�.
	else - getArticleCount(int searchn, String search) �޼ҵ�(�����ε�)����
	DB�� Į�� �˻������ ���� ������ count�� �����Ѵ�.
	*/
	
	
	List articleList = null;
	BoardDBBean dbPro = BoardDBBean.getInstance();
	
	if(search.equals("") || search == null)
		count = dbPro.getArticleCount();
	else
		count = dbPro.getArticleCount(searchn,search);
	
	
	
	/*
	if - count>0, DB�� �Խñ� �����Ͱ� ���� ���
		if - ����ڰ� �Է��� �˻�� ���� ���
		     getArticles(startRow, endRow)�޼ҵ� ���� ���� articleList�� ����
		else - 
		articleList = dbPro.getArticles(startRow, endRow, searchn, search) 	
	*/
	
	
	if(count>0)
	{
		if(search.equals("") || search == null)
			articleList = dbPro.getArticles(startRow, endRow);
		else
			articleList = dbPro.getArticles(startRow, endRow, searchn, search);
	}
	
	CommentDBBean cdb = CommentDBBean.getInstance();
	
	number=count-(currentPage-1)*pageSize;
	//11 -(2-1)*3 = 8
			
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>


<body bgcolor="<%=bodyback_c %>">
<center><b>�۸��(��ü ��:<%=count %>)</b>

<table width="700">
<tr>
	<td align="right" bgcolor="<%=value_c %>">
	<a href="writeForm.jsp">�۾���</a>
	</td>
</tr>
</table>

<%
	if(count == 0){
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
	<td align="center">
	�Խ��ǿ� ����� ���� �����ϴ�.
	</td>
</tr>	
</table>

<% }else{ %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
	<tr height="30" bgcolor="<%=value_c %>">
		<td align="center" width="50">�� ȣ</td>
		<td align="center" width="250">�� ��</td>
		<td align="center" width="100">�ۼ���</td>
		<td align="center" width="150">�ۼ���</td>
		<td align="center" width="50">�� ȸ</td>
		<td align="center" width="100">IP</td>
	</tr>
	

<%

	/*
	for������ articleList�� ��� �Խñ۵��� ����Ѵ�.
	*/
	
	for(int i =0; i<articleList.size(); i++) {
		BoardDataBean article = (BoardDataBean)articleList.get(i);
		
		/*
		getCommentCount(int con_num)�޼ҵ�� 
		��� DB�� content_num(�Խñ� DB�� num�� ����)Į������ �Է� ���� 
		��ġ�ϴ� ���� ������ ���Ѵ�.
		*/
		
		int com_count=cdb.getCommentCount(article.getNum());
		
%>	
<!--��ȣ  -->
 <tr height="30">
	 <td align="center" width="50"> <%=number-- %></td> 
	 <td width="250">
	 
	<%
	/*
	re_level: ���۰� �亯���� ����
	re_step: ȭ����¼���
	ref: ���۰� �亯���� ������
	
	--for�� ������--
	
	if - article��ü(�Խñ�)��  re_level ���� 0���� Ŭ ���
		�亯���̹Ƿ� wid�� �� ���� 5�� ���ؼ� �����Ѵ�.
		ȭ����� �ÿ� �亯���� ���α� ���� �� �� �����ʿ� ��ġ�ϰ� �Ѵ�. 
	*/
	int wid=0;
	if(article.getRe_level()>0){
		wid=5*(article.getRe_level());
	%> 

	<img src="./images/level.gif" width="<%=wid %>" height="16">
	<img src="./images/re.gif">
	
	<%}else{ %>
		
	<img src="./images/level.gif" width="<%=wid %>" height="16">
	
	<%} %>
	
	<%
	/*
	�Խñ� num�� currentPage ���� get�ĸ����ͷ� ����
	
	getSubject() �޼ҵ�� article ��ü�� �Խñ� ������ �����ͼ� ���
	com_count>0, �Խñۿ� ����� ���� ��� ȭ�鿡 �����  
	*/
	
	if(com_count>0) {
	
	%>
		<a href="content1.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage%>">
		<%=article.getSubject() %>[<%=com_count %>]</a>
	<% }else{ %>
		<a href="content1.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage %>">
		<%=article.getSubject() %></a>	
	<% } %>
	
	
	
	
	<% 
	/*
	if - article ��ü�� ����� �Խñ� ��ȸ���� 20���� Ŭ ���
		hot.gif�� �Խñ� ���� �ڿ� ����Ѵ�. 
	*/
	
	if(article.getReadcount()>=20) {
	%>
	<img src="./images/hot.gif" border="0" height="16">
	<%} %>
	</td>
	
	
	<td align="center" width="100">
		<a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a></td>
	<td align="center" width="150"><%=sdf.format(article.getReg_date())%></td>	
	<td align="center" width="50"><%=article.getReadcount()%></td>	
	<td align="center" width="150"><%=article.getIp()%></td>	
</tr>


<%
/*
�Խñ� ����ϴ� for�� ����
*/
	} 
	
%>	
</table>
<%
/*
if(count ==0) 
else 
	����	
*/
}
%>
<p>

<%
/*
����¡

if - count>0, �Խñ��� �����ϸ�
	pageSize�� ��ü �Խñ� ���� ������ ��ü ������ ��(pageCount)�� ���ϰ� ���� �������� pageSize ���� ����
	�ܿ� �Խñ��̹Ƿ� pageCount +1

*/
	if(count>0) {
		int pageCount = count /pageSize + (count % pageSize == 0 ? 0:1);
		
		int startPage = (int)(currentPage/5)*5+1;
		int pageBlock=5; //�ϴ��� ������ ��ũ�� 5���� ������
		int endPage = startPage + pageBlock-1; //5 + 5-1
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage>5){ 
			if(search.equals("") || search ==null)
			{
%>
<a href="list2-1.jsp?pageNum=<%=startPage-5 %>">[����]</a>
	<%
			}
		else
			{		
	%>			
<a href="list2-1.jsp?pageNum=<%=startPage -5 %>&search=<%=search %>&searchn=<%=searchn %>">[����]</a>
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
<a href="list2-1.jsp?pageNum=<%=i %>">[<%=i %>]</a>				
<%
			}
			else
			{
%>			
<a href="list2-1.jsp?pageNum=<%=i %>&search=<%=search %>&searchn=<%=searchn %>">[<%=i %>]</a>
<%
			}
%>
<%
		}
		if(endPage < pageCount){
			if(search.equals("")||search==null)
			{
%>	
<a href="list2-1.jsp?pageNum=<%=startPage + 5 %>">[����]</a>
<%
			}
			else
			{
%>
<a href="list2-1.jsp?pageNum=<%=startPage + 5 %>&search=<%=search %>&searchn=<%=searchn %>">[����]</a>
<%
			}
%>
<%
		}
	}
%>
</p>
<form>
<select name="searchn">
<option value="0">�ۼ���</option>
<option value="1">����</option>
<option value="2">����</option>
</select>

<input type="text" name="search" size="15" maxlength="50"/>
<input type="submit" value="�˻�"/>
</form>
</body>
</html>




</body>
</html>