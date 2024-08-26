package member;
import java.util.HashMap;
import java.util.Map;

public class Member {
	private Map<String, String> id_pw = new HashMap<>();
	
	private String birthday;
	private String email;
	
	public Map<String, String> getId_pw() {
		return id_pw;
	}
	
	public void setId_pw(String id, String pw) {
		this.id_pw.put(id, pw);
	}
	
	public String getBirthday() {
		return birthday;
	}
	
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
}
