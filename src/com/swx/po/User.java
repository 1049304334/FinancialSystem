package com.swx.po;

public class User {
	
	private String id;
	private String trueName;
	private String familyId;
	private String userName;
	private String password;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTrueName() {
		return trueName;
	}
	public void setTrueName(String trueName) {
		this.trueName = trueName;
	}
	public String getFamilyId() {
		return familyId;
	}
	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public User() {
		super();
	}
	
	public User(String id, String trueName, String familyId, String userName,
			String password) {
		super();
		this.id = id;
		this.trueName = trueName;
		this.familyId = familyId;
		this.userName = userName;
		this.password = password;
	}
	@Override
	public String toString() {
		return "User [familyId=" + familyId + ", id=" + id + ", password="
				+ password + ", trueName=" + trueName + ", userName="
				+ userName + "]";
	}
}
