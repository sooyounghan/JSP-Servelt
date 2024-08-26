package com.newlectrue.web.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.newlecture.web.entity.Notice;
import com.newlecture.web.entity.NoticeView;

public class NoticeDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
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
	
	public List<NoticeView> getAllNoticeList(String field, String query, int page) {
		List<NoticeView> noticeList = new ArrayList<NoticeView>();
		
		try {
			getConnection();
			
			String sql = "SELECT B.* FROM (SELECT A.*, ROWNUM NUM FROM (SELECT * FROM NOTICE_VIEW WHERE " + field + " LIKE ? ORDER BY REGDATE DESC) A) B WHERE NUM BETWEEN ? AND ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+query+"%");
			pstmt.setInt(2, (page - 1) * 10 + 1);
			pstmt.setInt(3, page * 10);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeView notice = new NoticeView();
				
				notice.setId(rs.getInt(1));
				notice.setTitle(rs.getString(2));
				notice.setWriterId(rs.getString(3));
				notice.setRegdate(rs.getDate(4));
				notice.setHit(rs.getInt(5));
				notice.setFiles(rs.getString(6));
				notice.setComment_count(rs.getInt(7));
				notice.setPub(rs.getBoolean(8));

				noticeList.add(notice);
			}
			conn.close();
  		} catch(SQLException se) {
			se.printStackTrace();
		}
		
		return noticeList;
	}
	
	public List<NoticeView> getPubNoticeList(String field, String query, int page) {
		List<NoticeView> noticeList = new ArrayList<NoticeView>();
		
		try {
			getConnection();
			
			String sql = "SELECT B.* FROM (SELECT A.*, ROWNUM NUM FROM (SELECT * FROM NOTICE_VIEW WHERE " + field + " LIKE ? ORDER BY REGDATE DESC) A) B WHERE PUB = 1";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+query+"%");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeView notice = new NoticeView();
				
				notice.setId(rs.getInt(1));
				notice.setTitle(rs.getString(2));
				notice.setWriterId(rs.getString(3));
				notice.setRegdate(rs.getDate(4));
				notice.setHit(rs.getInt(5));
				notice.setFiles(rs.getString(6));
				notice.setPub(rs.getBoolean(7));
				noticeList.add(notice);
			}
			conn.close();
  		} catch(SQLException se) {
			se.printStackTrace();
		}
		
		return noticeList;
	}
	
	public Notice getNotice(int id) {
		Notice notice = new Notice();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM NOTICE WHERE ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				notice.setId(rs.getInt(1));
				notice.setTitle(rs.getString(2));
				notice.setWriterId(rs.getString(3));
				notice.setContent(rs.getString(4));
				notice.setRegdate(rs.getDate(5));
				notice.setHit(rs.getInt(6));
				notice.setFiles(rs.getString(7));
				notice.setPub(rs.getBoolean(8));
			}
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		return notice;
	}
	
	public Notice getPrevNotice(int id) {
		Notice notice = new Notice();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM (SELECT * FROM NOTICE ORDER BY REGDATE DESC) A WHERE A.REGDATE < (SELECT REGDATE FROM NOTICE WHERE ID = ?) AND ROWNUM = 1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				notice.setId(rs.getInt(1));
				notice.setTitle(rs.getString(2));
				notice.setWriterId(rs.getString(3));
				notice.setContent(rs.getString(4));
				notice.setRegdate(rs.getDate(5));
				notice.setHit(rs.getInt(6));
				notice.setFiles(rs.getString(7));
				notice.setPub(rs.getBoolean(8));
			}
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		return notice;
	}
	
	public Notice getNextNotice(int id) {
		Notice notice = new Notice();
		
		try {
			getConnection();
			
			String sql = "SELECT * FROM NOTICE WHERE ID = (SELECT ID FROM NOTICE WHERE REGDATE > (SELECT REGDATE FROM NOTICE WHERE ID = ?) AND ROWNUM = 1)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				notice.setId(rs.getInt(1));
				notice.setTitle(rs.getString(2));
				notice.setWriterId(rs.getString(3));
				notice.setContent(rs.getString(4));
				notice.setRegdate(rs.getDate(5));
				notice.setHit(rs.getInt(6));
				notice.setFiles(rs.getString(7));
				notice.setPub(rs.getBoolean(8));
			}
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		return notice;
	}
	
	public int getNoticeCount(String field, String query) {
		int count = 0;
		
		try {
			getConnection();
			
			String sql = "SELECT COUNT(ID) FROM NOTICE WHERE " + field + " LIKE ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+query+"%");
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
	
	public void removeNoticeAllList(int[] ids) {
		try {
			getConnection();
			
			String parameter = "";
			
			for(int i = 0; i < ids.length; i++) {
				parameter += ids[i];
				
				if(i <= ids.length - 1) {
					parameter += ",";
				}
			}
			
			String sql = "DELETE FROM NOTICE WHERE ID IN (" + parameter + ")";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
	
	public void insertNotice(Notice notice) {
		try {
			getConnection();
			
			String sql = "INSERT INTO NOTICE(TITLE, CONTENT, WRITER_ID, FILES, PUB) VALUES(?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notice.getTitle());
			pstmt.setString(2, notice.getContent());
			pstmt.setString(3, notice.getWriterId());
			pstmt.setString(4, notice.getFiles());
			pstmt.setBoolean(5, notice.getPub());
			
			pstmt.executeUpdate();
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}

	public void putNoticeAll(String openidCSV, String closeidCSV) {
		try {
			getConnection();
			
			String openSql = "UPDATE NOTICE SET PUB = 1 WHERE ID IN (" + openidCSV + ")";
			pstmt = conn.prepareStatement(openSql);
			pstmt.executeUpdate();
			
			String closeSql = "UPDATE NOTICE SET PUB = 0 WHERE ID IN (" + closeidCSV + ")";
			pstmt = conn.prepareStatement(closeSql);
			pstmt.executeUpdate();
			
			conn.close();
		} catch(SQLException se) {
			se.printStackTrace();
		}
	}
}
