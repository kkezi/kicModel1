package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//java파일은 src밑에, 그외 다른 모든것은 webcontent밑에 넣기 
public class JdbcConnection {
	//Connection : oracle server와 연결해 sql전달 객체
	//jdbc:oracle:thin:@localhost:1521:xe -----연결 url
	public static Connection getConnection()	 {
		Connection con = null;
		try {
			//↓오라클 드라이버가 있는가? 없으면 여기서부터 에러남
			Class.forName("oracle.jdbc.OracleDriver");
			 con = DriverManager			
					 //↓ 아랫줄은 (고정조건(대소문자/숫자도 틀리면 안됨), 오라클유저아이디 , 오라클유저비번)
					 .getConnection("jdbc:oracle:thin:@localhost:1521:xe","kic","1111");
			 System.out.println("ok db");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("error db");
			e.printStackTrace();
		}
		return con; 
		
	
		}
			//나중에 닫아줄때 매번 익셉션 처리 안하기 위해서 close 만든다
			public static void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
			 try {
				 if(con!=null) {
					 con.commit(); //저장 
					 con.close();
				 }
				 if(pstmt!=null) {
					 pstmt.close();
				 }
				 if(rs!=null) {
					 rs.close();
				 }
			 } catch(SQLException e) {
				 e.printStackTrace();
				 
			 }
		
		
		}
}
