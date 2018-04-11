function writeSave() {
	if(document.writeform.wirter.value==""){
		alert("작성자를 입력하세요.");
		document.writeform.writer.focus();
		return false;
	}
	
	if(document.writeform.subject.value==""){
		alert("제목을 입력하세요.");
		document.write.form.subject.focus();
		return false;
	}
	
	if(document.writeform.content.value==""){
		alert("내용을 입력하세요.");
		document.write.form.content.focus();
		return false;
	}
	
	if(document.writeform.passwd.value==""){
		alert(" 비밀번호를 입력하세요.");
		document.write.form.passwd.focus();
		return false;
	}
	
}