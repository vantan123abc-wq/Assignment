package model;

public class Cart {
    private int id;
    private int accountId;

    public Cart() {
    }

    public Cart(int id, int accountId) {
        this.id = id;
        this.accountId = accountId;
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
}
