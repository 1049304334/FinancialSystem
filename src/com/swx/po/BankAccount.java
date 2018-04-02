package com.swx.po;

/**
 * Created by Administrator on 2018/3/22.
 */
public class BankAccount {

    private String accountNo;
    private String bankName;
    private String bankAddress;
    private String userId;
    private String familyId;


    public String getAccountNo() {

        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getBankAddress() {
        return bankAddress;
    }

    public void setBankAddress(String bankAddress) {
        this.bankAddress = bankAddress;
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

    public BankAccount() {
    }

    public BankAccount(String accountNo, String bankName, String bankAddress, String userId, String familyId) {
        this.accountNo = accountNo;
        this.bankName = bankName;
        this.bankAddress = bankAddress;
        this.userId = userId;
        this.familyId = familyId;
    }

    @Override
    public String toString() {
        return "BankAccount{" +
                "accountNo='" + accountNo + '\'' +
                ", bankName='" + bankName + '\'' +
                ", bankAddress='" + bankAddress + '\'' +
                ", userId='" + userId + '\'' +
                ", familyId='" + familyId + '\'' +
                '}';
    }
}
