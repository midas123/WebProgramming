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
	int pageSize=3; //한 화면에서 보여줄 글의 갯수 설정,  10
	SimpleDateFormat sdf=
			new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>


<%
	request.setCharacterEncoding("euc-kr");
	String pageNum = request.getParameter("pageNum");
	String search = request.getParameter("search");

	
	/*
	Form태그(name="searchn")에서 받은 value 값과 search(사용자 입력 값)이 있을 경우 값을 각 변수에 
	대입한다.
	
	※value 값 정리
	0 -> 작성자
	1 - > 제목
	2 -> 내용
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
	--페이징--
	게시글을 pageSize로 나누면 나눈 몫과 나머지를 더 한 값이 총 page 수가 된다.
	startRow와 endRow는 현재페이지(currentPage)에서 보여줄 게시글의 처음과 끝이다.
	*/
	
	
	int currentPage = Integer.parseInt(pageNum);
	System.out.println(currentPage);
	int startRow = (currentPage *3) -2; //10 -9
	int endRow = currentPage * pageSize;
	int count =0;
	int number = 0;
	
	
	/*
	BoardDBBean 자바빈(DTO)객체에서 가져온 값을 가져온다 .
	if -사용자 입력 값이 없을 경우 count 변수에 getArticleCount() 메소드에서
	구한 DB의 전체 행의 개수를 대입한다.
	else - getArticleCount(int searchn, String search) 메소드(오버로딩)에서
	DB의 칼럼 검색결과의 행의 갯수를 count에 대입한다.
	*/
	
	
	List articleList = null;
	BoardDBBean dbPro = BoardDBBean.getInstance();
	
	if(search.equals("") || search == null)
		count = dbPro.getArticleCount();
	else
		count = dbPro.getArticleCount(searchn,search);
	
	
	
	/*
	if - count>0, DB에 게시글 데이터가 있을 경우
		if - 사용자가 입력한 검색어가 없을 경우
		     getArticles(startRow, endRow)메소드 리턴 값을 articleList에 저장
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
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>


<body bgcolor="<%=bodyback_c %>">
<center><b>글목록(전체 글:<%=count %>)</b>

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
	게시판에 저장된 글이 없습니다.
	</td>
</tr>	
</table>

<% }else{ %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
	<tr height="30" bgcolor="<%=value_c %>">
		<td align="center" width="50">번 호</td>
		<td align="center" width="250">제 목</td>
		<td align="center" width="100">작성자</td>
		<td align="center" width="150">작성일</td>
		<td align="center" width="50">조 회</td>
		<td align="center" width="100">IP</td>
	</tr>
	

<%

	/*
	for문으로 articleList의 담긴 게시글들을 출력한다.
	*/
	
	for(int i =0; i<articleList.size(); i++) {
		BoardDataBean article = (BoardDataBean)articleList.get(i);
		
		/*
		getCommentCount(int con_num)메소드는 
		댓글 DB의 content_num(게시글 DB에 num과 같음)칼럼에서 입력 값과 
		일치하는 행의 갯수를 구한다.
		*/
		
		int com_count=cdb.getCommentCount(article.getNum());
		
%>	
<!--번호  -->
 <tr height="30">
	 <td align="center" width="50"> <%=number-- %></td> 
	 <td width="250">
	 
	<%
	/*
	re_level: 본글과 답변글을 구분
	re_step: 화면출력순서
	ref: 본글과 답변글을 묶어줌
	
	--for문 진행중--
	
	if - article객체(게시글)에  re_level 값이 0보다 클 경우
		답변글이므로 wid에 그 값에 5를 곱해서 대입한다.
		화면출력 시에 답변글이 메인글 보다 좀 더 오른쪽에 위치하게 한다. 
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
	게시글 num와 currentPage 값을 get파리미터로 전송
	
	getSubject() 메소드로 article 객체의 게시글 제목을 가져와서 출력
	com_count>0, 게시글에 댓글이 있을 경우 화면에 출력함  
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
	if - article 객체에 저장된 게시글 조회수가 20보다 클 경우
		hot.gif를 게시글 제목 뒤에 출력한다. 
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
게시글 출력하는 for문 종료
*/
	} 
	
%>	
</table>
<%
/*
if(count ==0) 
else 
	종료	
*/
}
%>
<p>

<%
/*
페이징

if - count>0, 게시글이 존재하면
	pageSize로 전체 게시글 수를 나눠서 전체 페이지 수(pageCount)를 구하고 나눈 나머지는 pageSize 보다 작은
	잔여 게시글이므로 pageCount +1

*/
	if(count>0) {
		int pageCount = count /pageSize + (count % pageSize == 0 ? 0:1);
		
		int startPage = (int)(currentPage/5)*5+1;
		int pageBlock=5; //하단의 페이지 링크를 5개씩 보여줌
		int endPage = startPage + pageBlock-1; //5 + 5-1
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage>5){ 
			if(search.equals("") || search ==null)
			{
%>
<a href="list2-1.jsp?pageNum=<%=startPage-5 %>">[이전]</a>
	<%
			}
		else
			{		
	%>			
<a href="list2-1.jsp?pageNum=<%=startPage -5 %>&search=<%=search %>&searchn=<%=searchn %>">[이전]</a>
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
<a href="list2-1.jsp?pageNum=<%=startPage + 5 %>">[다음]</a>
<%
			}
			else
			{
%>
<a href="list2-1.jsp?pageNum=<%=startPage + 5 %>&search=<%=search %>&searchn=<%=searchn %>">[다음]</a>
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
<option value="0">작성자</option>
<option value="1">제목</option>
<option value="2">내용</option>
</select>

<input type="text" name="search" size="15" maxlength="50"/>
<input type="submit" value="검색"/>
</form>
</body>
</html>




</body>
</html>