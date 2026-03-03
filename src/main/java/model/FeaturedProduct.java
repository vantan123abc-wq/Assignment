package model;

public class FeaturedProduct extends Product {
    private int soldQty;

    public FeaturedProduct() {
        super();
    }

    public FeaturedProduct(int id, String name, double price, int quantity, String description, int soldQty) {
        super(id, name, price, quantity, description);
        this.soldQty = soldQty;
    }

    public int getSoldQty() {
        return soldQty;
    }

    public void setSoldQty(int soldQty) {
        this.soldQty = soldQty;
    }

    @Override
    public String toString() {
        return "FeaturedProduct{" +
                "soldQty=" + soldQty +
                ", id=" + getId() +
                ", name='" + getName() + '\'' +
                ", price=" + getPrice() +
                '}';
    }
}
