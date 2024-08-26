package com.newlecture.web.entity;

import java.util.Date;

public class Notice {
	private int id;
	private String title;
	private String writerId;
	private String content;
	private Date regdate;
	private int hit;
	private String files;
	private boolean pub;

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getWriterId() {
		return writerId;
	}
	
	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}
	
	public Date getRegdate() {
		return regdate;
	}
	
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	public int getHit() {
		return hit;
	}
	
	public void setHit(int hit) {
		this.hit = hit;
	}
	
	public String getFiles() {
		return files;
	}
	
	public void setFiles(String files) {
		this.files = files;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	public boolean getPub() {
		return pub;
	}
	public void setPub(boolean pub) {
		this.pub = pub;
	}

	@Override
	public String toString() {
		return "Notice [id=" + id + ", title=" + title + ", writerId=" + writerId + ", content=" + content
				+ ", regdate=" + regdate + ", hit=" + hit + ", files=" + files + ", pub=" + pub + "]";
	}
}
