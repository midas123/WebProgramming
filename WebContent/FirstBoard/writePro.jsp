<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="logon.BoardDBBean"%>
<%@ page import ="java.sql.Timestamp"%>   

<%
request.setCharacterEncoding("euc-kr");
%>

<jsp:useBean id="article" scope="page" class="logon.BoardDataBean">
<jsp:setProperty name="article" property="*"/>
</jsp:useBean>

<%
article.setReg_date(new Timestamp(System.currentTimeMillis()));
article.setIp(request.getRemoteAddr());
BoardDBBean dbPro = BoardDBBean.getInstance();
dbPro.insertArticle(article);
response.sendRedirect("list2-1.jsp");
%>

