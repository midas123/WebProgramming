<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="./color.jsp" %>    
<%@ page import = "logon.CookieBox" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="javascript">
	<!--
	function begin() {
		document.myform.id.focus();
	}
	function checkIt() {
		if(!document.myform.id.value){
			alert("이름을 입력하지 않으셨습니다.");
			document.myform.id.focus();
			return false;
		}
		if(!document.myform.passwd.value){
			alert("비밀번호를 입력하지 않으셨습니다.");
			document.myform.passwd.focus();
			return false;
		}
	}
</script>
</head>
<body onload="begin()" bgcolor="<%=bodyback_c%>">
<%
	CookieBox cookieBox = new CookieBox(request);
%>

<form name="myform" action="loginPro.jsp" method="post" onSubmit="return checkIt()">
<table cellspacing=1 cellpadding=1 width="400" border=1 align="center">
	<tr height="30">
		<td colspan="2" align="middle" bgcolor="<%=title_c %>">
		<strong>회원로그인</strong>
		</td>
	</tr>
	<% if(cookieBox.exists("ID")) %>
	
	<tr height="30">
		<td width="110" bgcolor="<%=title_c %>" align=center>아이디</td>
		<td width="150" bgcolor="<%=value_c %>" align=center>
			<input type="text" name="id" size="15" maxlength="12" value="<%=cookieBox.getValue("ID") %>"></td>
		<td width= "90" bgcolor="<%=value_c %>" align=center>
			<input type="button" value="아이디 찾기" onclick="javascript:window.location='searchIdForm.jsp'"></td>
			
		</tr>
	<tr height="30">
		<td width="110" bgcolor="<%=title_c %>" align="center">비밀번호</td>
		<td width="150" bgcolor="<%=value_c %>" align="center">
			<input type="password" name="passwd" size="15" maxlength="12"></td>
		<td width= "90" bgcolor="<%=value_c %>" align=center>
		<input type="button" value="비밀번호 찾기" onclick="javascript:window.location='searchPwForm.jsp'"></td>	
	</tr>
	<tr height="30">
		<td colspan="2" align="middle" bgcolor="<%=title_c %>">
			<input type="submit" value="로그인">
			<input type="reset" value="다시 입력">
			<input type="button" value="회원가입"
			onclick="javascript:window.location='inputForm.jsp'"></td>
	</tr>		
</table>
</form>
</body>
</html>