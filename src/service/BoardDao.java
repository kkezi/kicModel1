package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Board;
import util.JdbcConnection;

public class BoardDao {
	
	public int nextNum() {//boardseq를 읽어서 데이터로 가져오는 것
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql = "select boardseq.nextval from dual";
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			return rs.getInt(1);	
	
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,rs);
		}
		
		return 0;
		
	} //nextNum메서드 
	
	
	

	public int insertBoard(Board board) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		//insert into member뒤 공백 한칸 있어야함 ----그리고 create table 했던 순서 지키기
		String sql = "insert into board " + " values (?,?,?,?,?,?,?,sysdate,?,0,?,?,?)";
		//String sql ="insert into board" + " values(boardseq.nextval,?,?,?,?,?,?,sysdate,?,0,boardseq.nextval,?,?)";
		
		try {//db에 저장하기
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board.getNum()); //
			pstmt.setString(2,board.getWriter());
			pstmt.setString(3, board.getPass());
			pstmt.setString(4, board.getSubject());
			pstmt.setString(5, board.getContent());
			pstmt.setString(6, board.getFile1());
			pstmt.setString(7, board.getBoardid());
			pstmt.setString(8, board.getIp());
			pstmt.setInt(9, board.getRef());
			pstmt.setInt(10, board.getReflevel());
			pstmt.setInt(11, board.getRefstep());
			return pstmt.executeUpdate();
			
		}catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,null);
		}
		
		return 0;
	}//insert메서드	
		
	
	
	
	public int boardCount(String boardid) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql = "select count(*) from board where boardid =?";
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardid);
			rs = pstmt.executeQuery();
			rs.next();
			return rs.getInt(1);
			
			
	
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,rs);
		}
		
		return 0;
		
		
		
	}//count메서드
	
	
	
	
	
	public List<Board> boardList(int pageInt, int limit, int boardcount, String boardid) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		//String sql = "select * from board where boardid =?"
					//	+ " order by num desc";//최근 입력시킨 순으로 정렬하기
		
		String sql = "select * from ( " +
				" select rownum rnum, a.* from ( "+
				" select * from board where boardid =? "+
				" order by ref desc, refstep asc) a) "+ // (ref)기준글은 최신순으로 답글은 오래된 순으로 
				" where rnum BETWEEN ? and ?";

		
		/* 
		-- 1, 4, 7, 10
		-- start : (pageInt-1)*limit + 1;
		-- end : start + limit - 1;
		-- 1 p --> 1 ~ 3
		-- 2 p --> 4 ~ 6 
		-- 3 p --> 7 ~ 10
		*/

		
		ResultSet rs = null;
		List<Board> list = new ArrayList<>();

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardid);
			pstmt.setInt(2, (pageInt-1)*limit+1); //start 
			pstmt.setInt(3, pageInt*limit); //end
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				Board b = new Board();
						b.setNum(rs.getInt("num"));
						b.setWriter(rs.getString("writer"));
						b.setPass(rs.getString("pass"));
						b.setSubject(rs.getString("subject"));
						b.setContent(rs.getString("content"));
						b.setFile1(rs.getString("file1"));
						b.setRef(rs.getInt("ref"));
						b.setRefstep(rs.getInt("refstep"));
						b.setReflevel(rs.getInt("reflevel"));
						b.setReadcnt(rs.getInt("readcnt"));
						b.setRegdate(rs.getDate("regdate"));
						list.add(b);
						
			}
			return list;
			
	
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,rs);
		}
		
		return list;
		
		
		
	}//list메서드
	
	public Board boardOne(int num) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql = "select * from board where num =?";
		ResultSet rs = null;

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Board b = new Board();
						b.setNum(rs.getInt("num"));
						b.setWriter(rs.getString("writer"));
						b.setPass(rs.getString("pass"));
						b.setSubject(rs.getString("subject"));
						b.setContent(rs.getString("content"));
						b.setFile1(rs.getString("file1"));
						b.setRef(rs.getInt("ref"));
						b.setRefstep(rs.getInt("refstep"));
						b.setReflevel(rs.getInt("reflevel"));
						b.setReadcnt(rs.getInt("readcnt"));
						b.setRegdate(rs.getDate("regdate"));
						return b;
						
			}
		
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,rs);
		}
		
		return null;
		
		
		
	}//boardOne메서드
	
	
	
	
	public int boardUpdate(Board board) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql = "update board set subject=?, content=?,"
				+ " file1=? where num =?  ";
		

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getSubject());
			pstmt.setString(2, board.getContent());
			pstmt.setString(3, board.getFile1());
			pstmt.setInt(4, board.getNum());
			return pstmt.executeUpdate();
		
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,null);
		}
		
		
		
		return 0;
	} //update
	
	
	public void readCountUp(int num) {
		
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql ="update board set readcnt = readcnt + 1 where num =?";
		

		try {
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, num);
			 pstmt.executeUpdate();
		
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,null);
		}
		
	}//조회수 올리는 메서드
	
	
	
	public int boardDelete(int num) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql ="delete from board where num =?";
		

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			return pstmt.executeUpdate();
		
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,null);
		}
		
			
		return 0;
	} //deleteboard 메서드 
	
	
	public void refStepAdd(int ref, int refstep) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql ="update board set refstep = refstep + 1 where ref = ? and refstep > ?";
		

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, refstep);
			pstmt.executeUpdate();
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,null);
		}
		
		
	}//refstep 답글 메서드
	
	
	
	
	
	
}//end class
