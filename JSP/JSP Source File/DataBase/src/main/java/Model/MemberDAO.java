package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


/*
 * Oracle DB 연결 및 SELECT, INSERT, DELETE, UPDATE 작업, 즉 DB에 접근하고 처리할 DAO 클래스
 */

public class MemberDAO {
	// Oracle 접속 
	String id = "dbPractice"; // DB ID
	String password = "1234"; // DB Password
	String url = "jdbc:oracle:thin:@localhost:1521:xe"; // DB Connect URL
	
	// DB에 접근 클래스 객체
	Connection conn = null;
	
	// 데이터베이스 쿼리 처리 클래스 객체
	PreparedStatement pstmt = null;
	
	// 데이터베이스에서 쿼리 질의 후, 받은 결과에 대해 클래스 객체
	ResultSet rs = null;
	
	/*
	 * DB 연결
	 */
	public void getConnection() {
		// Connection Pool 이용해 DB 접근
		try {
			
			// 외부에서 데이터를 읽어드리기 위해 설정
			Context initctx = new InitialContext();
			
			// Tomcat 서버에 정보를 담아 놓은 곳으로 이동
			Context envctx = (Context)initctx.lookup("java:comp/env");
			
			// Data Source 객체 생성
			DataSource ds = (DataSource)envctx.lookup("jdbc/pool");
			
			// Data Source를 기준으로 Connection 연결
			conn = ds.getConnection();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*
		 * try {
		 * 
		 * // 1. 데이터 베이스 사용 선언 Class.forName("oracle.jdbc.driver.OracleDriver");
		 * 
		 * // 2. 데이터 베이스 접속 conn = DriverManager.getConnection(url, id, password);
		 * 
		 * } catch(Exception e) {
		 * 
		 * e.printStackTrace();
		 * 
		 * }
		 */
	}
	
	/*
	 *  DB에 한 사람의 회원 정보 삽입
	 */
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
			
		} catch(Exception e) { 
			
			e.printStackTrace();
			
		}
	}
	
	/*
	 * 모든 회원 정보 확인
	 */
	public List<Member> allMemberList() {
		List<Member> memberList = new ArrayList<Member>();
		
		try {
			
			getConnection();
			
			String sql = "SELECT * FROM MEMBER";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) { // 1. 저장된 데이터만큼 까지 반복문 실행
				
				// 2. memberList에 저장할 Member 객체 생성
				Member member = new Member();
				
				// 3. DB 처리 결과를 Member Setter로 DB 처리 결과 저장
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
			
		} catch(Exception e) {
			
			e.printStackTrace();
			
		}
		
		return memberList;
	}
	
	/*
	 * 한 회원 정보 확인
	 */
	public Member oneMemberList(String id) {
		Member member = new Member();
		
		try {
			
			getConnection();
			
			String sql = "SELECT * FROM MEMBER WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member.setId(rs.getString(1));
				member.setPass1(rs.getString(2));
				member.setEmail(rs.getString(3));
				member.setTel(rs.getString(4));
				member.setHobby(rs.getString(5));
				member.setJob(rs.getString(6));
				member.setAge(rs.getString(7));
				member.setInfo(rs.getString(8));
			}
			
			conn.close();
			
		} catch(Exception e) {
			
			e.printStackTrace();
			
		}
		
		return member;
	}
	
	/*
	 * 회원의 ID 값을 입력 받아, 그 회원의 PassWord 반환 
	 */
	public String getPass(String id) {
		String password = "";
		
		try {
			
			getConnection();
			
			String sql = "SELECT PASS1 FROM MEMBER WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				password = rs.getString(1);
			}
			
			conn.close();
			
		} catch(Exception e) {
			
			e.printStackTrace();
			
		}
		
		return password;
	}
	
	/*
	 * 회원정보를 수정하는 메서드
	 */
	public void updateMember(Member member) {
		try {
			getConnection();
			
			String sql = "UPDATE MEMBER SET EMAIL = ?, TEL = ?, INFO = ? WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getEmail());
			pstmt.setString(2, member.getTel());
			pstmt.setString(3, member.getInfo());
			pstmt.setString(4, member.getId());
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 한 회원을 삭제하는 메서드 (ID 정보를 받아서 삭제)
	 */
	public void deleteMember(String id) {
		try {
			getConnection();
			
			String sql = "DELETE FROM MEMBER WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(Exception e) {
			
			e.printStackTrace();
			
		}
	}
}
