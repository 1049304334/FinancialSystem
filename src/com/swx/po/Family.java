package com.swx.po;

/**
 * Created by Administrator on 2018/3/22.
 */
public class Family {

    private String familyId;
    private String familyName;
    private String adminId;

    public String getFamilyId() {
        return familyId;
    }

    public void setFamilyId(String familyId) {
        this.familyId = familyId;
    }

    public String getFamilyName() {
        return familyName;
    }

    public void setFamilyName(String familyName) {
        this.familyName = familyName;
    }

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public Family() {
    }

    public Family(String familyId, String familyName, String adminId) {
        this.familyId = familyId;
        this.familyName = familyName;
        this.adminId = adminId;
    }

    @Override
    public String toString() {
        return "Family{" +
                "familyId='" + familyId + '\'' +
                ", familyName='" + familyName + '\'' +
                ", adminId='" + adminId + '\'' +
                '}';
    }
}
