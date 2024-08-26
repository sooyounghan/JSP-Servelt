package Model;

public class Board {
	private int board_num;
	private String writer;
	private String email;
	private String subject;
	private String content_password;
	private String reg_date; // 화면 출력을 위해 String형으로 사용
	private int ref;
	private int re_step;
	private int re_level;
	private int read_count;
	private String content;
	
	public int getBoard_num() {
		return board_num;
	}
	
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	
	public String getWriter() {
		return writer;
	}
	
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getSubject() {
		return subject;
	}
	
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getContent_password() {
		return content_password;
	}
	
	public void setContent_password(String content_password) {
		this.content_password = content_password;
	}
	
	public String getReg_date() {
		return reg_date;
	}
	
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	
	public int getRef() {
		return ref;
	}
	
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_step() {
		return re_step;
	}
	
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	
	public int getRe_level() {
		return re_level;
	}
	
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	
	public int getRead_count() {
		return read_count;
	}
	
	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
}
