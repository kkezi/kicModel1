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
		String sql = 
				//"select * from board where boardid =?"
					//	+ " order by num desc";//최근 입력시킨 순으로 정렬하기
		
		"select * from ( " +
				" select rownum rnum, a.* from ( "+
				" select * from board where boardid =? "+
				" order by num desc) a) "+
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
	
	
	
	
	
	
	
	
}//end class
