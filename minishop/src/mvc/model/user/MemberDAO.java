package mvc.model.user;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.PreparedStatement;

import mvc.database.DBConnection;

public class MemberDAO {
	
	public boolean isExistId(String id) throws ClassNotFoundException, SQLException{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		conn = DBConnection.getConnection();
		
		boolean exist = false;
		String sql = "select * from member where id=?";
		
		try {
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				exist = true;
			}
			
		} catch(SQLException e){
			e.printStackTrace();
		}
		finally {
			// TODO: handle finally clause
			try{
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return exist;
	}

}
