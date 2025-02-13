package app.domain_model;

import java.text.DecimalFormat;

public class Product implements Comparable<Product> {
    private String product_number;
    private double quantity;
    private final int id_number;

    public Product(int product_number, double quantity) {
        this.product_number = "Produto " + product_number;
        this.id_number = product_number;
        this.quantity = quantity;
    }

    public int getId_number() {
        return id_number;
    }

    public String getProduct_number() {
        return product_number;
    }

    public double getQuantity() {
        return quantity;
    }

    @Override
    public String toString() {
        //DecimalFormat df = new DecimalFormat("#.##");
        return "| " +  quantity + "kg de " + product_number + " |\n";
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    @Override
    public int compareTo(Product p) {
        return p.getProduct_number().compareTo(this.product_number);
    }
}
