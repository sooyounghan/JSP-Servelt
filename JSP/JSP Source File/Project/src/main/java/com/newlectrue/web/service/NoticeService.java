package com.newlectrue.web.service;

import java.util.ArrayList;
import java.util.List;

import com.newlectrue.web.model.NoticeDAO;
import com.newlecture.web.entity.Notice;
import com.newlecture.web.entity.NoticeView;

public class NoticeService {
	NoticeDAO noticeDAO = new NoticeDAO();
	
	public void removeNoticeAllList(int[] ids) {
		noticeDAO.removeNoticeAllList(ids);
	}

	public List<NoticeView> pubNoticeAllList(String field, String query, int page) {
		return noticeDAO.getPubNoticeList(field, query, page);
	}
	
	public void pubNoticeAll(String opneidCSV, String closeidCSV) {
		noticeDAO.putNoticeAll(opneidCSV, closeidCSV);
	}
	
	public void pubNoticeAll(int[] openIds, int[] closeIds) {
		List<String> openidList = new ArrayList<String>();
		for(int i = 0 ; i < openIds.length; i++) {
			openidList.add(String.valueOf(openIds[i]));
		}

		List<String> closeidList = new ArrayList<String>();
		for(int i = 0 ; i < closeIds.length; i++) {
			closeidList.add(String.valueOf(closeIds[i]));
		}
		pubNoticeAll(openidList, closeidList);
	}
	
	public void pubNoticeAll(List<String> openIds, List<String> closeIds) {
		String openidCSV = String.join(",", openIds);
		String closeidCSV = String.join(",", closeIds);
		
		pubNoticeAll(openidCSV, closeidCSV);
	}
	
	public void insertNotice(Notice notice) {
		noticeDAO.insertNotice(notice);
	}
	
	public void deleteNotice(int ids) {
	}
	
	public void updateNotice(Notice notice) {
	}
	
	public List<Notice> getNoticeNewestList() {
		return null;
	}
	
	public List<NoticeView> getNoticeList() {
		return getNoticeList("title", "", 1); // 기본값으로 해당 메서드 호출
	}
	
	public List<NoticeView> getNoticeList(int page) {
		return getNoticeList("title", "", page);
	}
	
	public List<NoticeView> getNoticeList(String field, String query, int page) {
		List<NoticeView> noticeList = noticeDAO.getAllNoticeList(field, query, page);
		return noticeList;
	}
	
	public int getNoticeCount() {
		return getNoticeCount("title", ""); // 동일하게 기본값으로 메서드 호출
	}
	
	public int getNoticeCount(String field, String query) {
		int count = noticeDAO.getNoticeCount(field, query);
		return count;
	}
	
	public Notice getNotice(int id) {
		Notice notice = noticeDAO.getNotice(id);
		return notice;
	}

	public Notice getPrevNotice(int id) {
		Notice notice = noticeDAO.getPrevNotice(id);
		return notice;
	}

	public Notice getNextNotice(int id) {
		Notice notice = noticeDAO.getNextNotice(id);
		return notice;
	}
}
