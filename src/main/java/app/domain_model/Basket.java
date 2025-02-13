package app.domain_model;

import java.util.HashMap;
import java.util.Map;

public class Basket {
    private String idClient;  // id do cliente que faz a encomenda
    private HashMap<Product,Trade> requested; // o que recebeu do produtor

    public Basket(String idReceiver, HashMap<Product,Trade> requested) {
        this.idClient = idReceiver;
        this.requested = requested;
    }

    public String getIdClient() {
        return idClient;
    }

    public HashMap<Product, Trade> getRequested() {
        return requested;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("\n----------------- Client: ").append(idClient).append(" ----------------- \n Basket:\n\n");
        for (Map.Entry<Product, Trade> entry : requested.entrySet()) {
            sb.append("\tProduct: ").append(entry.getKey())
                    .append("\tTrade: ").append(entry.getValue()).append("\n");
        }
        return sb.toString();
    }
}
