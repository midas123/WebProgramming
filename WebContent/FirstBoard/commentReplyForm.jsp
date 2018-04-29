<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="./color.jsp" %>
    
    
<%@ page import="comment.CommentDataBean" %>    
<%@ page import="comment.CommentDBBean" %>    
    
<%


	int content_number = Integer.parseInt(request.getParameter("ctn"));
	int comment_number = Integer.parseInt(request.getParameter("cmn"));
	int cset = Integer.parseInt(request.getParameter("cset"));
	int clevel = Integer.parseInt(request.getParameter("clevel"));
	int cstep = Integer.parseInt(request.getParameter("cstep"));

%> 
    
<html>
<head>
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<table>
<form method=post action=contentPro.jsp name="comment" onsubmit="return writeSave()">
	<tr bgcolor="<%=value_c %>" align="center">
	<td>답변 코멘트작성</td>
	</tr>
	<tr bgcolor="<%=value_c %>" align="center">
		<td colspan=2><textarea name=commentt rows="5" cols="40"></textarea>
		</td>
		<td align=center>작성자<br>
		<input type=text name=commenter size=10><br>비밀번호<br>
		<input type=password name=passwd size=10><p>
		<input type=hidden name=content_num value=<%=content_number %>>
		<input type=hidden name=comment_num value=<%=comment_number %>>
		<input type="hidden" name="com_re_set" value="<%=cset%>">
		<input type="hidden" name="com_re_step" value="<%=cstep%>">
		<input type="hidden" name="com_re_level" value="<%=clevel%>"> 
		<input type=submit value="답변 코멘트달기">
		</td>
	</tr>
</form>
</table>
</body>
</html>