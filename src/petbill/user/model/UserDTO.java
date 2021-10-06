package petbill.user.model;

import java.sql.Timestamp;

public class UserDTO {
	
	private String id;					//아이디
	private String pw;					//비밀번호
	private String name;				//이름
	private String mobile;				//핸드폰
	private String nickname;			//닉네임
	private Timestamp reg;				//가입날짜
	private String useractivenum;		//상태
	private String userreason;			//이유
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public String getUseractivenum() {
		return useractivenum;
	}
	public void setUseractivenum(String useractivenum) {
		this.useractivenum = useractivenum;
	}
	public String getUserreason() {
		return userreason;
	}
	public void setUserreason(String userreason) {
		this.userreason = userreason;
	}
	
	
	
	
	
}
