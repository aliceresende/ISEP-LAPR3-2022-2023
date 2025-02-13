package app.service.load;

import app.domain_model.Product;
import app.service.load.LoadBaskets;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class LoadBasketsTest {

    HashMap<String, HashMap<Integer, ArrayList<Product>>> stock;
    HashMap<String, HashMap<Integer, ArrayList<Product>>> orders;


    @Test
    public void testFillStock() throws FileNotFoundException {
        LoadBaskets lb = new LoadBaskets();
        lb.fillStockAndOrders("src/main/resources/load/Small/cabazes_small.csv");

        // test that stock is filled correctly
        stock = lb.getStock();
        assertEquals(3, stock.size()); // devem existir 3 produtores
        Assertions.assertTrue(stock.containsKey("P1")); // producer P1 should be in the stock
        Assertions.assertTrue(stock.containsKey("P2")); // producer P2 should be in the stock
        Assertions.assertTrue(stock.containsKey("P3")); // producer P3 should be in the stock
        assertEquals(5, stock.get("P1").size()); // producer P1 should have stock for 5 days
        assertEquals(12, stock.get("P3").get(1).size()); // producer P1 should have stock for 12 products on day 1
    }

    @Test
    public void testFillOrders() throws FileNotFoundException {
        LoadBaskets lb = new LoadBaskets();
        lb.fillStockAndOrders("src/main/resources/load/Small/cabazes_small.csv");

        // test that orders is filled correctly
        orders = lb.getOrders();
        assertEquals(14, orders.size()); // devem existir 14 clientes
        Assertions.assertTrue(orders.containsKey("C1")); // client C1 should have placed orders
        Assertions.assertTrue(orders.containsKey("C9")); // client C2 should have placed orders
        Assertions.assertTrue(orders.containsKey("E5")); // client C3 should have placed orders
        assertEquals(5, orders.get("C1").size()); // client C1 should have placed orders for 5 days
        assertEquals(12, orders.get("E1").get(1).size()); // client C1 should have placed orders for 12 products on day 1
    }
}


