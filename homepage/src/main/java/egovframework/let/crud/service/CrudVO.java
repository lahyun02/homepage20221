package egovframework.let.crud.service;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

import egovframework.com.cmm.ComDefaultVO;
import java.util.Date;

public class CrudVO extends ComDefaultVO implements Serializable {
	
	//CRUDID
	private String crudId;
	
	//제목
	private String crudSj;
	
	//내용
	private String crudCn;
	
	//작성자
	private String userNm;
	
	//작성일
	private Date frstRegistPnttm;
//	private Date registDate;
	//메뉴
	private String menuId;
	
	public String getCrudId() {
		return crudId;
	}

	public void setCrudId(String crudId) {
		this.crudId = crudId;
	}

	public String getCrudSj() {
		return crudSj;
	}

	public void setCrudSj(String crudSj) {
		this.crudSj = crudSj;
	}

	public String getCrudCn() {
		return crudCn;
	}

	public void setCrudCn(String crudCn) {
		this.crudCn = crudCn;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public Date getFrstRegistPnttm() {
		return frstRegistPnttm;
	}

	public void setFrstRegistPnttm(Date frstRegistPnttm) {
		this.frstRegistPnttm = frstRegistPnttm;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}


	
}
