package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.JdbcUtil;

public class CommentDBBean {
	private static CommentDBBean instance = new CommentDBBean();
	
	public static CommentDBBean getInstance() {
		return instance;
	}
	
	private CommentDBBean() {}
	
	private Connection getConnection() throws Exception {
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}
	
	public void insertComment(CommentDataBean cdb) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int cnumber = cdb.getContent_num();
		int mnum = cdb.getComment_num(); //새댓글 =0, 답변 댓글=댓글 번호
		int com_re_set = cdb.getCom_re_set();
		int com_re_level = cdb.getCom_re_level();
		int com_re_step = cdb.getCom_re_step();
		int number =0; //댓글 그룹번호
		
		try {
			conn=getConnection();
			pstmt = conn.prepareStatement("select max(comment_num) from comment_00 ");
			rs = pstmt.executeQuery();
			
			if(rs.next()) 
			number=rs.getInt(1)+1;
			else
				number=1;
		
			//답변 댓글일 경우 step, level 값 증가, 아닐 경우 set만 증가
			//부모ID 추가하는 쪽으로 수정할 것
			if(mnum!=0) {
				pstmt = conn.prepareStatement("update comment_00 set com_re_step=com_re_step+1 where com_re_set=? and com_re_step>?");
				pstmt.setInt(1, com_re_set);
				pstmt.setInt(2, com_re_step);
				pstmt.executeUpdate();
				
				com_re_step=com_re_step+1;
				com_re_level=com_re_level+1;
			} else {
				com_re_set = number;
				com_re_step = 0;
				com_re_level = 0;
			}
			
			pstmt = conn.prepareStatement("insert into comment_00(content_num,commenter,commentt,passwd,reg_date,ip,comment_num,com_re_set,com_re_level,com_re_step) values(?,?,?,?,?,?,comment_number_00.NEXTVAL,?,?,?)");
			pstmt.setInt(1, cnumber);
			pstmt.setString(2, cdb.getCommenter());
			pstmt.setString(3, cdb.getCommentt());
			pstmt.setString(4, cdb.getPasswd());
			pstmt.setTimestamp(5, cdb.getReg_date());
			pstmt.setString(6, cdb.getIp());
			pstmt.setInt(7, com_re_set);
			pstmt.setInt(8, com_re_level);
			pstmt.setInt(9, com_re_step);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
	}
	
	
	public ArrayList getComments(int con_num, int start, int end) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList cm = null;
		
		try {
			conn = getConnection();
			
			String sql="select content_num,commenter,commentt,reg_date,ip,comment_num,com_re_set,com_re_level,com_re_step,r "+ 
			"from (select content_num,commenter,commentt,reg_date,ip,comment_num,com_re_set,com_re_level,com_re_step,rownum r "+ 
			"from (select content_num,commenter,commentt,reg_date,ip,comment_num,com_re_set,com_re_level,com_re_step "+
			"from comment_00 where content_num="+con_num+" order by com_re_set desc, com_re_step asc) order by com_re_set desc, com_re_step asc) where r >= ? and r <=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cm = new ArrayList();
				do {
					CommentDataBean cdb = new CommentDataBean();
					cdb.setComment_num(rs.getInt("comment_num"));
					cdb.setContent_num(rs.getInt("content_num"));
					cdb.setCommenter(rs.getString("commenter"));
					cdb.setCommentt(rs.getString("commentt"));
					cdb.setIp(rs.getString("ip"));
					cdb.setReg_date(rs.getTimestamp("reg_date"));
					cdb.setCom_re_set(rs.getInt("com_re_set"));
					cdb.setCom_re_step(rs.getInt("com_re_step"));
					cdb.setCom_re_level(rs.getInt("com_re_level"));
					cm.add(cdb);
				} while(rs.next());
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return cm;
	}
	
	public int getCommentCount(int con_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList cm = null;
		int count =0;
		
		try {
			conn = getConnection();
			String sql = "select * from comment_00 where content_num="+con_num+" order by reg_date desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cm = new ArrayList();
				do {
					CommentDataBean cdb = new CommentDataBean();
					cdb.setCommenter(rs.getString("commenter"));
					cdb.setCommentt(rs.getString("commentt"));
					cdb.setIp(rs.getString("ip"));
					cdb.setReg_date(rs.getTimestamp("reg_date"));
					cm.add(cdb);
				} while(rs.next());
				count=cm.size();
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return count;
	}
	
	public int deleteComment(int content_num, String passwd, int comment_num) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from comment_00 where content_num=? and comment_num=?");
			pstmt.setInt(1, content_num);
			pstmt.setInt(2, comment_num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd)) {
					pstmt = conn.prepareStatement("delete from comment_00 where content_num=? and comment_num=?");
					pstmt.setInt(1, content_num);
					pstmt.setInt(2, comment_num);
					pstmt.executeUpdate();
					x=1;
				} else
					x=0;
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
		return x;
		
	}
	
	
	public CommentDataBean getComment(int content_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CommentDataBean comment = null;
		
		try {
			conn = getConnection();
		
			//게시글의 모든 댓글 값을 불러와서 데이터가 꼬이고 있음
			pstmt = conn.prepareStatement(
					"select * from comment_00 where content_num = ? order by comment_num desc");
			pstmt.setInt(1, content_num);
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				comment = new CommentDataBean();
				comment.setContent_num(rs.getInt("content_num"));
				comment.setCommenter(rs.getString("commenter"));
				comment.setCommentt(rs.getString("commentt"));
				comment.setPasswd(rs.getString("passwd"));
				comment.setReg_date(rs.getTimestamp("reg_date"));
				comment.setIp(rs.getString("ip"));
				comment.setComment_num(rs.getInt("comment_num"));
				comment.setCom_re_set(rs.getInt("com_re_set"));
				comment.setCom_re_level(rs.getInt("com_re_level"));
				comment.setCom_re_step(rs.getInt("com_re_step"));
			
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
		return comment;
	}
	
	
}
