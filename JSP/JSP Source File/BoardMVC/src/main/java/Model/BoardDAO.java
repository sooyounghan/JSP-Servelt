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
 * DB에서 데이터와 연동할 클래스
 */
public class BoardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// DBCP-DB 연동
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
	
	// 총 게시글의 수를 반환
	public int getAllCount() {
		int count = 0;
		
		try {
			getConnection();
			
			String sql = "SELECT COUNT(BOARD_NUM) FROM BOARD";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		
		return count;
	}
	
	// 지정된 페이지 수 만큼 게시물 데이터 추출
	public List<Board> getAllBoard(int startNum, int endNum) {
		List<Board> boardList = new ArrayList<Board>();

		try {
			getConnection();
			
			String sql = "SELECT * FROM (SELECT A.*, ROWNUM NUM FROM (SELECT * FROM BOARD ORDER BY REF DESC, RE_STEP ASC, RE_LEVEL ASC) A ) B WHERE B.NUM >= ? AND B.NUM <= ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startNum);
			pstmt.setInt(2, endNum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				
				board.setBoard_num(rs.getInt(1));
				board.setWriter(rs.getString(2));
				board.setEmail(rs.getString(3));
				board.setSubject(rs.getString(4));
				board.setContent_password(rs.getString(5));
				board.setReg_date(rs.getDate(6).toString());
				board.setRef(rs.getInt(7));
				board.setRe_step(rs.getInt(8));
				board.setRe_level(rs.getInt(9));
				board.setRead_count(rs.getInt(10));
				board.setContent(rs.getString(11));
				
				boardList.add(board);
			}
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		
		return boardList;
	}
	
	// 새로운 게시글을 등록
	public void insertBoard(Board board) {
		int ref = 0;
		int re_step = 1;
		int re_level = 1;
		
		try {
			getConnection();
			
			String refsql = "SELECT MAX(REF) FROM BOARD";
			pstmt = conn.prepareStatement(refsql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				ref = rs.getInt(1) + 1;
			}
			
			String sql = "INSERT INTO BOARD VALUES(BOARD_SEQ.NEXTVAL, ?, ?, ? ,?, SYSDATE, ?, ?, ?, 0, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getEmail());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getContent_password());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setString(8, board.getContent());
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
	
	//게시글 하나를 추출
	public Board getOneBoard(int board_num) {
		Board board = new Board();
		
		try {
			getConnection();
			
			String readcount_sql = "UPDATE BOARD SET READCOUNT = READCOUNT + 1 WHERE BOARD_NUM = ?";
			pstmt = conn.prepareStatement(readcount_sql);
			pstmt.setInt(1, board_num);
			pstmt.executeUpdate();
			
			String sql = "SELECT * FROM BOARD WHERE BOARD_NUM = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board.setBoard_num(rs.getInt(1));
				board.setWriter(rs.getString(2));
				board.setEmail(rs.getString(3));
				board.setSubject(rs.getString(4));
				board.setContent_password(rs.getString(5));
				board.setReg_date(rs.getDate(6).toString());
				board.setRef(rs.getInt(7));
				board.setRe_step(rs.getInt(8));
				board.setRe_level(rs.getInt(9));
				board.setRead_count(rs.getInt(10));
				board.setContent(rs.getString(11));
			}
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		return board;
	}
	
	// 게시물에 답글을 추가
	public void reWriteInsertBoard(Board board) {
		int ref = board.getRef();
		int re_step = board.getRe_step();
		int re_level = board.getRe_level();
		
		try {
			getConnection();
			
			String levelsql = "UPDATE BOARD SET RE_LEVEL = RE_LEVEL + 1 WHERE REF = ? AND RE_LEVEL > ?";
			pstmt = conn.prepareStatement(levelsql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level); 
			pstmt.executeUpdate();
			
			String sql = "INSERT INTO BOARD VALUES (BOARD_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE, ?, ?, ?, 0, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getEmail());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getContent_password());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step + 1);
			pstmt.setInt(7, re_level + 1);
			pstmt.setString(8, board.getContent());
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
	
	// 게시글 수정을 위해게시글 하나를 추출
	public Board getOneUpdateBoard(int board_num) {
		Board board = new Board();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM BOARD WHERE BOARD_NUM = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board.setBoard_num(rs.getInt(1));
				board.setWriter(rs.getString(2));
				board.setEmail(rs.getString(3));
				board.setSubject(rs.getString(4));
				board.setContent_password(rs.getString(5));
				board.setReg_date(rs.getDate(6).toString());
				board.setRef(rs.getInt(7));
				board.setRe_step(rs.getInt(8));
				board.setRe_level(rs.getInt(9));
				board.setRead_count(rs.getInt(10));
				board.setContent(rs.getString(11));
			}
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		return board;
	}
	
	
	// 하나의 게시글 수정 처리
	public void updateBoard(int board_num, String subject, String content) {
		try {
			getConnection();
			
			String sql = "UPDATE BOARD SET SUBJECT = ?, CONTENT = ? WHERE BOARD_NUM = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setInt(3, board_num);
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
	
	//하나의 게시글 삭제
	public void deleteBoard(int board_num) {
		try {
			getConnection();
			
			String sql = "DELETE FROM BOARD WHERE BOARD_NUM = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			pstmt.executeUpdate();
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
}
