package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import model.Member;
import util.JdbcConnection;

/*메서드만 모아놓은 것*/
public class MemberDao {
	
	public int insertMember(HttpServletRequest request) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		//insert into member뒤 공백 한칸 있어야함
		String sql = "insert into member " + " values (?,?,?,?,?,?,?)";
		try {//db에 저장하기
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, request.getParameter("id") );
			pstmt.setString(2, request.getParameter("pass"));
			pstmt.setString(3, request.getParameter("name"));
			pstmt.setInt(4, Integer.parseInt(request.getParameter("gender")));
			pstmt.setString(5, request.getParameter("tel"));
			pstmt.setString(6, request.getParameter("email"));
			pstmt.setString(7, request.getParameter("picture"));
			//executeUpdate() = select문을 제외한 나머지 추가,삭제,수정하는 sql문 실행
			return pstmt.executeUpdate();
			
		}catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,null);
		}
		
		
		
		return 0;
	}//insert메서드

	
	public Member selectOne(String id) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql = "select * from member " + " where id = ?";
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);
			//select구문을 실행할때는 executeQuery ,resultset사용
			rs=pstmt.executeQuery();
			
			//row가 있으면 하나씩 찍어 돌려야 한다 
			if(rs.next()) {
				Member m = new Member(
						rs.getString("id"),
						rs.getString("pass"),
						rs.getString("name"),
						rs.getInt("gender"),
						rs.getString("tel"),
						rs.getString("email"),
						rs.getString("picture")
						);
				return m;
			}

		}catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,rs);
		}
		
		
		
		//row가 없으면
		return null;
		
	}//selectOne메서드 
	
	
	
	public int memberUpdate(Member mem) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		//insert into member뒤 공백 한칸 있어야함
		String sql = "update member set tel = ?,email = ? where id = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem.getTel() );
			pstmt.setString(2, mem.getEmail());
			pstmt.setString(3, mem.getId());
			
			//select문을 제외한 나머지 추가,삭제,수정하는 sql문 실행
			return pstmt.executeUpdate();
			
		}catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,null);
		}
		
		
		
		return 0;
	}//memberUpdate메서드
		

	public int deleteMember(String id) {
		Connection con = JdbcConnection.getConnection();
		PreparedStatement pstmt = null;
		//insert into member뒤 공백 한칸 있어야함
		String sql = "delete from member where id = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id );
			
			
			//select문을 제외한 나머지 추가,삭제,수정하는 sql문 실행 = executeUpdate()
			return pstmt.executeUpdate();
			
		}catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcConnection.close(con,pstmt,null);
		}
		
		
		
		return 0;
	}//deleteMember메서드
		
	
	
	
} //end class
/*
 * Member mem = new Member(
				request.getParameter("id"),
				request.getParameter("pass"),
				request.getParameter("name"),
				request.getParameter("tel"),
				request.getParameter("email"),
				request.getParameter("picture"),
				Integer.parseInt(request.getParameter("gender"))
				);
				
*/
