package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.Board;
import util.JdbcConnection;

public class BoardDao {

	public int insertBoard(Board board) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		//insert into member뒤 공백 한칸 있어야함 ----그리고 create table 했던 순서 지키기
		String sql = "insert into board " + " values (boardseq.nextval,?,?,?,?,?,?,sysdate,?,0,?,?,?)";
		
		try {//db에 저장하기
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,board.getWriter());
			pstmt.setString(2, board.getPass());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getContent());
			pstmt.setString(5, board.getFile1());
			pstmt.setString(6, board.getBoardid());
			pstmt.setString(7, board.getIp());
			pstmt.setInt(8, board.getRef());
			pstmt.setInt(9, board.getReflevel());
			pstmt.setInt(10, board.getRefstep());
			
			
	
			return pstmt.executeUpdate();
			
		}catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,null);
		}
		
		
		
		return 0;
	}//insert메서드	
		
		
	
	
	
	
}//end class
