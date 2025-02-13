package app.service.load;

import app.domain_model.Product;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.*;

public class LoadBaskets {

    // idProducer, dia, Lista produtos
    HashMap<String, HashMap<Integer, ArrayList<Product>>> stock;

    // idClient, dia, Lista produtos
    HashMap<String, HashMap<Integer, ArrayList<Product>>> orders;

    public void fillStockAndOrders (String filePath) throws FileNotFoundException {

        Scanner read = new Scanner(new FileInputStream(filePath));

        stock = new HashMap<>();
        orders = new HashMap<>();

        read.nextLine(); // header
        // "Clientes-Produtores","Dia","Prod1","Prod2","Prod3","Prod4","Prod5","Prod6","Prod7","Prod8","Prod9","Prod10","Prod11","Prod12"

        while (read.hasNextLine()){
            String line = read.nextLine();
            String[] splitted = line.split(",");

            String id = splitted[0].replaceAll("\"",""); // remove " from Clientes-Produtores

            // splitted[1] = Dia
            int day = Integer.parseInt(splitted[1]);

            // filling products
            ArrayList<Product> products = new ArrayList<>();
            for (int i = 2; i <splitted.length ; i++) {
                products.add(new Product(i-1,Double.parseDouble(splitted[i])));
            }

            // producers
            if(splitted[0].contains("P")) {

                if(stock.containsKey(id)){
                    HashMap<Integer, ArrayList<Product>> old = stock.get(id);
                    old.put(day,products);
                    stock.put(id,old);
                }else{
                    HashMap<Integer, ArrayList<Product>> ne = new HashMap<>();
                    ne.put(day,products);
                    stock.put(id,ne);
                }


            // clients
            }else{

                if(orders.containsKey(id)){
                    HashMap<Integer, ArrayList<Product>> old = orders.get(id);
                    old.put(day,products);
                    orders.put(id,old);
                }else{
                    HashMap<Integer, ArrayList<Product>> ne = new HashMap<>();
                    ne.put(day,products);
                    orders.put(id,ne);
                }

            }

        } // end while

    }

    public HashMap<String, HashMap<Integer, ArrayList<Product>>> getStock() {
        return stock;
    }

    public HashMap<String, HashMap<Integer, ArrayList<Product>>> getOrders() {
        return orders;
    }

    @Override
    public String toString() {
        return "Stock available: \n" + stock +
                "\n Orders: \n" + orders +
                ']';
    }

    public void toStringOrder(){
        for (Map.Entry<String, HashMap<Integer, ArrayList<Product>>> entry : orders.entrySet()) {
            String key = entry.getKey();
            HashMap<Integer, ArrayList<Product>> value = entry.getValue();
            System.out.println("\n==========================================");
            System.out.println("Client id: " + key );
            for (Map.Entry<Integer, ArrayList<Product>> innerEntry : value.entrySet()) {
                Integer innerKey = innerEntry.getKey();
                ArrayList<Product> innerValue = innerEntry.getValue();
                System.out.println("\n         - Day: " + innerKey + " - \n");
                System.out.println("Products: \n" + innerValue);
                System.out.println("\n");
            }
        }
    }

    public void toStringStock(){
        for (Map.Entry<String, HashMap<Integer, ArrayList<Product>>> entry : stock.entrySet()) {
            String key = entry.getKey();
            HashMap<Integer, ArrayList<Product>> value = entry.getValue();
            System.out.println("\n==========================================");
            System.out.println("Producer id: " + key );
            for (Map.Entry<Integer, ArrayList<Product>> innerEntry : value.entrySet()) {
                Integer innerKey = innerEntry.getKey();
                ArrayList<Product> innerValue = innerEntry.getValue();
                System.out.println("\n         - Day: " + innerKey + " - \n");
                System.out.println("Products: \n" + innerValue);
                System.out.println("\n");
            }
        }
    }
}
