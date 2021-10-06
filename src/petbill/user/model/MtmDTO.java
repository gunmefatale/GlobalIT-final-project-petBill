package petbill.user.model;

import java.sql.Timestamp;

public class MtmDTO {
	
	private Integer mtmno;
	private String mtmuserid;
	private String mtmsubject;
	private String mtmcontent;
	private Timestamp reg;
	private String ref;
	
	
	
	public Integer getMtmno() {
		return mtmno;
	}
	public void setMtmno(Integer mtmno) {
		this.mtmno = mtmno;
	}
	public String getMtmuserid() {
		return mtmuserid;
	}
	public void setMtmuserid(String mtmuserid) {
		this.mtmuserid = mtmuserid;
	}
	public String getMtmsubject() {
		return mtmsubject;
	}
	public void setMtmsubject(String mtmsubject) {
		this.mtmsubject = mtmsubject;
	}
	public String getMtmcontent() {
		return mtmcontent;
	}
	public void setMtmcontent(String mtmcontent) {
		this.mtmcontent = mtmcontent;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public String getRef() {
		return ref;
	}
	public void setRef(String ref) {
		this.ref = ref;
	}
	
	
	
	
}
