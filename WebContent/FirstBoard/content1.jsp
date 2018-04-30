<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="logon.BoardDBBean" %>
<%@ page import="logon.BoardDataBean" %>
<%@ page import="comment.CommentDataBean" %>
<%@ page import="comment.CommentDBBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="./color.jsp" %>
    
<html>
<head>
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
function writeSave(){
	if(document.comment.commentt.value==""){
		alert("�ۼ��ڸ� �Է��Ͻʽÿ�.");
		document.comment.commentt.focus();
		return false;
	}
}
</script>
</head>

<%
	int mainArticle = 0;
	int cset =1, clevel=0, cstep=0;
	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	int pageSize=10;
	String cPageNum = request.getParameter("cPageNum");
	
	if(cPageNum == null)
	{
		cPageNum = "1";
	}
	
	
	int cCurrentPage = Integer.parseInt(cPageNum);
	
	int startRow = (cCurrentPage*10)-9;
	int endRow = cCurrentPage*pageSize;
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");


	
	
	try{
		BoardDBBean dbPro = BoardDBBean.getInstance();
		BoardDataBean article = dbPro.getArticle(num);
		
		CommentDBBean cdb = CommentDBBean.getInstance();
		
		//�Խñ��� ��� ����� ��ü�� ����		
		CommentDataBean cdd = cdb.getComment(num);
		
		//��� DB���� ��� �����͸� �����ͼ� arrayList�� ����
		ArrayList comments = cdb.getComments(article.getNum(), startRow, endRow);
		
		//�Խñ��� ��� ��� ������ ����
		int count = cdb.getCommentCount(article.getNum());
		//�Խñ� ��ü���� ���α۰� �亯�� �����ϴ� �Ӽ����� ������
		int ref = article.getRef();
		int re_step=article.getRe_step();
		int re_level=article.getRe_level();
		
		try{
			if(num>0){
			cset = cdd.getCom_re_set();
			cstep = cdd.getCom_re_step();
			clevel = cdd.getCom_re_level();
			}
		}catch(Exception e){}
		
		
%>

<body bgcolor=<%=bodyback_c %>>
<center><b>�۳��� ����</b></center><br>
<table width=500 border=1 cellspacing=0 sellpadding=0 bgcolor=<%=bodyback_c %> align=center>
	<tr height=30>
		<td align=center width=125 bgcolor=<%=value_c %>>�۹�ȣ</td>
		<td align=center width=125><%=article.getNum() %></td>
		<td align=center width=125 bgcolor=<%=value_c %>>��ȸ��</td>
		<td align=center width=125><%=article.getReadcount() %></td>
	</tr>
	<tr height=30>
		<td	align=center width=125 bgcolor=<%=value_c %>>�ۼ���</td>
		<td align=center width=125><%=article.getWriter() %></td>
		<td align=center width=125 bgcolor=<%=value_c %>>�ۼ���</td>
		<td align=center widhh=125><%=sdf.format(article.getReg_date()) %></td>
	</tr>
	<tr height=30>
		<td	align=center width=125 bgcolor=<%=value_c %>>������</td>
		<td align=center width=375 colspan=3><%=article.getSubject() %></td>
	</tr>
	<tr height=30>
		<td	align=center width=125 bgcolor=<%=value_c %>>�� ����</td>
		<td align=center width=375 colspan=3><%=article.getContent() %></td>
	</tr>	
	<tr height=30>
		<td colspan=4 bgcolor=<%=value_c %> align=right>
		<input type=button value=�ۼ��� onclick="document.location.href='updateForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
		<input type=button value=�ۻ��� onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
		<input type=button value=��۾��� onclick="document.location.href='writeForm.jsp?num=<%=num %>&ref=<%=ref %>&re_step=<%=re_step %>&re_level=<%=re_level %>'">&nbsp;&nbsp;&nbsp;&nbsp;
		<input type=button value=�۸�� onclick="document.location.href='list.jsp?pageNum=<%=pageNum %>'"></td>
	</tr>
	
	<form method=post action=contentPro.jsp name="comment" onsubmit="return writeSave()">
	<tr bgcolor="<%=value_c %>" align="center">
		<td>�ڸ�Ʈ �ۼ�</td>
		<td colspan=2><textarea name=commentt rows="6" cols="40"></textarea>
		<input type=hidden name=content_num value=<%=article.getNum() %>>
		<input type=hidden name=p_num value=<%=pageNum %>>
		<input type=hidden name=comment_num value=<%=mainArticle %>>
		<input type="hidden" name="com_re_set" value="<%=cset%>"/>
		<input type="hidden" name="com_re_level" value="<%=clevel%>"/>
		<input type="hidden" name="com_re_step" value="<%=cstep%>"/>
		
		</td>
		<td align=center>�ۼ���<br>
		<input type=text name=commenter size=10><br>��й�ȣ<br>
		<input type=password name=passwd size=10><p>
		<input type=submit value=�ڸ�Ʈ�ޱ�>
		</td>
	</tr>
	</form>
</table>

<%
//count>0, ����� �����Ѵٸ�
if(count>0){ 
%>
<p>
<table width=400 border=0 cellspacing=0 cellpadding=0 bgcolor=<%=bodyback_c %> align=center>
	<tr>
		<td>�ڸ�Ʈ ��: <%=comments.size() %>
	</tr>
	
	<tr>
<%

for(int i=0; i<comments.size(); i++){
	CommentDataBean dbc= (CommentDataBean)comments.get(i);
	
%>

<%
int wid=0;
if(dbc.getCom_re_level()>0){
	wid=5*(dbc.getCom_re_level());
%> 
<img src="./images/level.gif" width="<%=wid %>" >
	
<%} else {%>
<img src="./images/level.gif" width="<%=wid %>" >
<%} %>
		<td align=left size=250 bgcolor=<%=value_c %>>
		&nbsp;<b><%=dbc.getCommenter() %>&nbsp;��</b>(<%=sdf.format(dbc.getReg_date()) %>)
		</td>
		<td align=right size=250 bgcolor=<%=value_c %>> ����IP:<%=dbc.getIp() %>&nbsp;
		<a href="delCommentForm.jsp?ctn=<%=dbc.getContent_num() %>&cmn=<%=dbc.getComment_num() %>&p_num=<%=pageNum %>">[����]</a>&nbsp;
		<a href="commentReplyForm.jsp?ctn=<%=dbc.getContent_num() %>&cmn=<%=dbc.getComment_num() %>&cset=<%=cset%>&clevel=<%=clevel%>&cstep=<%=cstep%>">[��۾���]</a>&nbsp;
 		</td>
	</tr>
	
	<tr>
		<td colspan=2><%=dbc.getCommentt() %></td>
	</tr>
<%} %>



</table>
<%} %>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>