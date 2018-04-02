package com.swx.po;

import java.util.Date;

/**
 * Created by Administrator on 2018/3/27.
 */
public class IncomeRecord {

    private String recordId;
    private String incomeType;
    private String familyId;
    private Date incomeDate;
    private double amount;
    private String bankAccount;
    private String userId;
    private String remark;

    public String getRecordId() {
        return recordId;
    }

    public void setRecordId(String recordId) {
        this.recordId = recordId;
    }

    public String getIncomeType() {
        return incomeType;
    }

    public void setIncomeType(String incomeType) {
        this.incomeType = incomeType;
    }

    public String getFamilyId() {
        return familyId;
    }

    public void setFamilyId(String familyId) {
        this.familyId = familyId;
    }

    public Date getIncomeDate() {
        return incomeDate;
    }

    public void setIncomeDate(Date incomeDate) {
        this.incomeDate = incomeDate;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public IncomeRecord() {
    }

    public IncomeRecord(String recordId, String incomeType, String familyId, Date incomeDate, double amount, String bankAccount, String userId, String remark) {
        this.recordId = recordId;
        this.incomeType = incomeType;
        this.familyId = familyId;
        this.incomeDate = incomeDate;
        this.amount = amount;
        this.bankAccount = bankAccount;
        this.userId = userId;
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "IncomeRecord{" +
                "recordId='" + recordId + '\'' +
                ", incomeType='" + incomeType + '\'' +
                ", familyId='" + familyId + '\'' +
                ", incomeDate=" + incomeDate +
                ", amount=" + amount +
                ", bankAccount='" + bankAccount + '\'' +
                ", userId='" + userId + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }
}
