package com.swx.po;

import java.util.Date;

/**
 * Created by Administrator on 2018/3/22.
 */
public class BankOperation {

    private String operationId;
    private String accountNo;
    private String perationType;
    private Date operationDate;
    private double amount;
    private String userId;
    private String familyId;

    public String getOperationId() {
        return operationId;
    }

    public void setOperationId(String operationId) {
        this.operationId = operationId;
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public String getPerationType() {
        return perationType;
    }

    public void setPerationType(String perationType) {
        this.perationType = perationType;
    }

    public Date getOperationDate() {
        return operationDate;
    }

    public void setOperationDate(Date operationDate) {
        this.operationDate = operationDate;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getFamilyId() {
        return familyId;
    }

    public void setFamilyId(String familyId) {
        this.familyId = familyId;
    }

    public BankOperation() {
    }

    public BankOperation(String operationId, String accountNo, String perationType, Date operationDate, double amount, String userId, String familyId) {
        this.operationId = operationId;
        this.accountNo = accountNo;
        this.perationType = perationType;
        this.operationDate = operationDate;
        this.amount = amount;
        this.userId = userId;
        this.familyId = familyId;
    }

    @Override
    public String toString() {
        return "BankOperation{" +
                "operationId='" + operationId + '\'' +
                ", accountNo='" + accountNo + '\'' +
                ", perationType='" + perationType + '\'' +
                ", operationDate=" + operationDate +
                ", amount=" + amount +
                ", userId='" + userId + '\'' +
                ", familyId='" + familyId + '\'' +
                '}';
    }
}
