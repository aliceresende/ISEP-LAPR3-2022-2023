package app.domain_model;

public class Trade {
    private String idProducer;
    private Product product;

    public Trade(String idProducer, Product product) {
        this.idProducer = idProducer;
        this.product = product;
    }

    public String getIdProducer() {
        return idProducer;
    }

    public Product getProduct() {
        return product;
    }

    @Override
    public String toString() {
        return " Producer: " + idProducer + " " + product;
    }

}
