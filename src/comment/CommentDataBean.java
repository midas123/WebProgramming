package comment;

import java.sql.Timestamp;

public class CommentDataBean {
	private int comment_num;
	private int content_num;
	private String commenter;
	private String commentt;
	private String passwd;
	private Timestamp reg_date;
	private String ip;
	private int com_re_set;
	private int com_re_level;
	private int com_re_step;
	private int mnum;
	
	public int getMNum() {
		return mnum;
	}
	public void setMNum(int num) {
		this.mnum = mnum;
	}
	public int getComment_num() {
		return comment_num;
	}
	
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public int getContent_num() {
		return content_num;
	}
	public void setContent_num(int content_num) {
		this.content_num = content_num;
	}
	public String getCommenter() {
		return commenter;
	}
	public void setCommenter(String commenter) {
		this.commenter = commenter;
	}
	public String getCommentt() {
		return commentt;
	}
	public void setCommentt(String commentt) {
		this.commentt = commentt;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getCom_re_set() {
		return com_re_set;
	}
	public void setCom_re_set(int com_re_set) {
		this.com_re_set = com_re_set;
	}
	public int getCom_re_level() {
		return com_re_level;
	}
	public void setCom_re_level(int com_re_level) {
		this.com_re_level = com_re_level;
	}
	public int getCom_re_step() {
		return com_re_step;
	}
	public void setCom_re_step(int com_re_step) {
		this.com_re_step = com_re_step;
	}
	
	
	
	
}
