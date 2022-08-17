package egovframework.let.join.service;

import java.io.Serializable;
import java.util.Date;

import egovframework.com.cmm.ComDefaultVO;

public class JoinVO extends ComDefaultVO implements Serializable {
	
	//아이디
    private String emplyrId;
    //이름
    private String userNm;
    //비밀번호
    private String password;
    //비밀번호 힌트
    private String passwordHint;
    //비밀번호 힌트 정답
    private String passwordCnsr;
    //사용자 상태 코드
    private String emplyrSttusCode;
    //고유 아이디
    private String esntlId="";
    //로그인타입
    private String loginType;
    // 가입 일자
    private Date sbscrbDe;
    
    
    
	public String getEmplyrId() {
		return emplyrId;
	}
	public void setEmplyrId(String emplyrId) {
		this.emplyrId = emplyrId;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPasswordHint() {
		return passwordHint;
	}
	public void setPasswordHint(String passwordHint) {
		this.passwordHint = passwordHint;
	}
	public String getPasswordCnsr() {
		return passwordCnsr;
	}
	public void setPasswordCnsr(String passwordCnsr) {
		this.passwordCnsr = passwordCnsr;
	}
	public String getEmplyrSttusCode() {
		return emplyrSttusCode;
	}
	public void setEmplyrSttusCode(String emplyrSttusCode) {
		this.emplyrSttusCode = emplyrSttusCode;
	}
	public String getEsntlId() {
		return esntlId;
	}
	public void setEsntlId(String esntlId) {
		this.esntlId = esntlId;
	}
	public String getLoginType() {
		return loginType;
	}
	public void setLoginType(String loginType) {
		this.loginType = loginType;
	}
	public Date getSbscrbDe() {
		return sbscrbDe;
	}
	public void setSbscrbDe(Date sbscrbDe) {
		this.sbscrbDe = sbscrbDe;
	}
   
	

}
