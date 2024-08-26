package Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public void getConnection() {
		try {
			Context initcnx = new InitialContext();
			Context envcnx = (Context)initcnx.lookup("java:comp/env");
			
			DataSource ds = (DataSource)envcnx.lookup("jdbc/pool");
			
			conn = ds.getConnection();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 새로운 게시글 하나 추가하는 메서드
	 */
	public void insertBoard(Board board) {
		int ref = 0; // 글 그룹 의미 (Query를 실해시켜 가장 큰 REF 값을 가져온 후 1 증가)
		int re_step = 1; // 새로운 글의 re_step은 1
		int re_level = 1; // 새로운 글이므로 re_level은 1
		
		try {
			getConnection();
			
			// 가장 큰 REF를 읽어오는 Query
			String refsql = "SELECT MAX(REF) FROM BOARD";
			
			pstmt = conn.prepareStatement(refsql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//최댓값에 1을 더해서 글 그룹 설정
				ref = rs.getInt(1) + 1;
			}
			
			// 게시글 전체 데이터를 DB에 전송
			String sql = "INSERT INTO BOARD VALUES(BOARD_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE, ?, ?, ?, 0, ?)";
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
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 모든 게시글 -> 변경 : 시작번호와 끝번호까지의 게시물 정보를 불러옴
	 */
	public List<Board> allBoardList(int start_num, int end_num) {
		List<Board> boardList = new ArrayList<Board>();
		
		try {
			getConnection();
			
			// 답변형 게시판이므로 REF 순으로 오름차순 정렬 후, RE_STEP 순으로 오름차순 정렬한 후 RE_LEVEL순으로 오름차순 정렬
			// start_num부터 end_num이라는 특정 범위의 Row를 가져오기 위해 ROWNUM과 Inline View 이용
			String sql = "SELECT * FROM (SELECT A.*, ROWNUM NUM FROM (SELECT * FROM BOARD ORDER BY REF DESC, RE_STEP ASC, RE_LEVEL ASC) A) B WHERE NUM >= ? AND NUM <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start_num);
			pstmt.setInt(2, end_num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				//DB에서 받은 데이터에 대한 Packaging 작업 
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
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return boardList;
	}
	
	/*
	 * 하나의 게시글을 불러옴
	 */
	public Board getOneBoard(int board_num) {
		Board board = new Board();
		
		try {
			getConnection();
			
			// 조회수 증가 Query
			String readCountsql = "UPDATE BOARD SET READCOUNT = READCOUNT + 1 WHERE BOARD_NUM = ?";
			pstmt = conn.prepareStatement(readCountsql);
			pstmt.setInt(1, board_num);
			pstmt.executeUpdate();
			
			// 게시글을 불러오는 Query
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
		} catch(Exception e) {
			e.printStackTrace();
		}
		return board; 
	}
	
	/*
	 * 특정 글에 대한 답변을 저장
	 */
	public void reWriteBoard(Board board_reply) {
		// 현재 작성된 글에 대해 부모글의 ref, re_step, re_level 필요
		int ref = board_reply.getRef();
		int re_step = board_reply.getRe_step();
		int re_level = board_reply.getRe_level();
		
		try {
			getConnection();
			
			// 부모 글보다 큰 re_level을 모두 1씩 증가 (아직 최근 답변은 넣지 않은 상태)
			String relevelsql = "UPDATE BOARD SET RE_LEVEL = RE_LEVEL + 1 WHERE REF = ? AND RE_LEVEL > ?";
			
			pstmt = conn.prepareStatement(relevelsql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);
			
			pstmt.executeUpdate();
			
			
			// 최근 답변 글 저장
			String sql = "INSERT INTO BOARD VALUES(BOARD_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE, ?, ?, ?, 0, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board_reply.getWriter());
			pstmt.setString(2, board_reply.getEmail());
			pstmt.setString(3, board_reply.getSubject());
			pstmt.setString(4, board_reply.getContent_password());
			pstmt.setInt(5, ref); // 부모 글에 대한 답변이므로 ref 값은 변동 없음
			pstmt.setInt(6, re_step + 1); // 부모 글에 대한 답변이므로 re_step 값의 1 증가
			pstmt.setInt(7, re_level + 1); // 이미 기존의 글들은 1씩 증가. 최신 글이므로 부모 글의 re_level에 1 증가
			pstmt.setString(8, board_reply.getContent());
			pstmt.executeQuery();
			
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 하나의 게시물에 대해 수정하기 위한 정보
	 */
	public Board updateOneBoard(int board_num) {
		Board board = new Board();
		
		try {
			getConnection();
			
			// 게시글을 불러오는 Query
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
		} catch(Exception e) {
			e.printStackTrace();
		}
		return board; 
	}
	
	/*
	 * Update, Delete에 필요한 Password 값
	 */
	public String getPass(int board_num) {
		String password = "";
		
		try {
			
			getConnection();
			
			String sql = "SELECT CONTENT_PASSWORD FROM BOARD WHERE BOARD_NUM = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			
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
	 * 하나의 게시글 수정
	 */
	public void updateBoard(Board board) {
		try {
			
			getConnection();
			
			String sql = "UPDATE BOARD SET SUBJECT = ?, CONTENT = ? WHERE Board_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getSubject());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getBoard_num());
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 하나의 게시글 삭제
	 */
	public void deleteBoard(int board_num) {
		try {
			getConnection();
			
			String sql = "DELETE FROM BOARD WHERE BOARD_NUM = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 전체 게시글의 개수
	 */
	public int allCountBoard() {
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
		} catch(Exception e) {
			
		}
		return count;
	}
}
