<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file = "./color.jsp" %>
<html>
<head><title>���̵� ã��</title></head>
<link href = "style.css" rel = "stylesheet" type = "text/css">
<body bgcolor = "<%= bodyback_c %>">

 

<form method = "post" action = "searchId.jsp">
<table cellspacing = "1" cellpadding = "1" width = "260" border = "1" align = "center">
<tr height = "30">
      <td width = "110" bgcolor = "<%= title_c %>" align ="center">
            �̸�
      </td>
      <td width = "100" bgcolor = "<%= value_c %>" align ="center">
            <input type = "text" name = "name"  size = "10" align="center" >
      </td>
</tr>
<tr height = "30">
      <td width = "110" bgcolor = "<%= title_c %>" align ="center">
            �ֹε�� ��ȣ
      </td>
      <td width = "250" bgcolor = "<%= value_c %>" align ="center">
            <input type = "text" name = "jumin1" size = "7" maxlength = "6"> - 
            <input type = "text" name = "jumin2" size = "7" maxlength = "7">
      </td>
</tr>
<tr height = "30">
      <td colspan = "2" align = "middle" bgcolor = "<%= title_c %>">
            <input type = "button" value = "��������.." onclick ="window.location = 'main.jsp'">
            <input type = "submit" value = "ã��">
      </td>
</tr>
</form>
</body>
</html>