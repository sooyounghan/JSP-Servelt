package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/*
 * 회원 가입 정보를 DB와 연결한 DAO 생성 (MemberDAO)
 */
public class MemberDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// DBCP 연동
	public void getConnection() {
		try {
			
			Context initcnx = new InitialContext();
			Context envcnx = (Context)initcnx.lookup("java:comp/env");
			DataSource ds = (DataSource)envcnx.lookup("jdbc/pool");
			
			conn = ds.getConnection();
			
		} catch(NamingException ne) {
			ne.printStackTrace();
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
	
	// 회원 한 명의 정보를 DB에 저장
	public void insertMember(Member member) {
		try {
			
			getConnection();
			
			String sql = "INSERT INTO MEMBER VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass1());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getHobby());
			pstmt.setString(6, member.getJob());
			pstmt.setString(7, member.getAge());
			pstmt.setString(8, member.getInfo());
			
			pstmt.executeUpdate();
			
			conn.close();
			
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
	
	// 모든 회원의 정보 추출
	public List<Member> allMemberList() {
		List<Member> memberList = new ArrayList<Member>();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM MEMBER";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Member member = new Member();
				
				member.setId(rs.getString(1));
				member.setPass1(rs.getString(2));
				member.setEmail(rs.getString(3));
				member.setTel(rs.getString(4));
				member.setHobby(rs.getString(5));
				member.setJob(rs.getString(6));
				member.setAge(rs.getString(7));
				member.setInfo(rs.getString(8));
				
				memberList.add(member);
			}
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		
		return memberList;
	}
}
