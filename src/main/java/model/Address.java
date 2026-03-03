package model;

public class Address {
    private int id;
    private int accountId;
    private String receiver;
    private String phone;
    private String addressLine;

    public Address() {
    }

    public Address(int id, int accountId, String receiver, String phone, String addressLine) {
        this.id = id;
        this.accountId = accountId;
        this.receiver = receiver;
        this.phone = phone;
        this.addressLine = addressLine;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddressLine() {
        return addressLine;
    }

    public void setAddressLine(String addressLine) {
        this.addressLine = addressLine;
    }
}
