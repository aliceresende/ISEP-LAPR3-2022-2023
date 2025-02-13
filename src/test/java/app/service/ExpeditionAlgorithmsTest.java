package app.service;




import app.controller.DistributionManagerController;
import app.domain_model.Company;

import app.domain_model.User;
import app.graph.algorithm.GraphAlgorithms;
import app.graph.map.DistributionNet;
import app.domain_model.*;
import app.graph.matrix.MatrixGraph;
import app.service.load.LoadBaskets;
import app.service.load.LoadNetDistribution;
import org.junit.jupiter.api.BeforeEach;

import app.controller.DistributionManagerController;
import app.domain_model.Product;

import org.junit.jupiter.api.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.*;

import java.util.LinkedHashSet;


import static org.junit.jupiter.api.Assertions.*;

class ExpeditionAlgorithmsTest {

    private final DistributionNet dNet;
    private final GraphAlgorithms alg;
    LoadBaskets small2 = new LoadBaskets();
    private final DistributionNetAlgorithms netAlg;
    ExpeditionAlgorithms exp;
    public ExpeditionAlgorithmsTest() throws IOException {
        dNet = new DistributionNet();
        LoadNetDistribution load= new LoadNetDistribution(dNet);
        load.loadUser("src/main/resources/load/Small/clientes-produtores_small.csv");
        load.loadDistance("src/main/resources/load/Small/distancias_small.csv");
        alg =new GraphAlgorithms();
        netAlg=new DistributionNetAlgorithms();
    }

    @BeforeEach
    public void setup() throws FileNotFoundException {
        small2.fillStockAndOrders("src/main/resources/load/Small/cabazes_small.csv");
        exp=new ExpeditionAlgorithms(small2);
    }
    @Test
    void expeditionListWithNoRestrictions() throws FileNotFoundException {
        LoadBaskets small = new LoadBaskets();
        small.fillStockAndOrders("src/main/resources/load/Small/cabazes_small.csv");
        ExpeditionAlgorithms exp1 = new ExpeditionAlgorithms(small);
        assertEquals(12, exp1.expeditionListWithNoRestrictions(3).size());

        LoadBaskets big = new LoadBaskets();
        big.fillStockAndOrders("src/main/resources/load/Big/cabazes_big.csv");
        ExpeditionAlgorithms exp2 = new ExpeditionAlgorithms(big);
        assertEquals(189, exp2.expeditionListWithNoRestrictions(3).size());
    }

    @Test
    void tradeGetter() {
    }


    @Test
    void testMinDistributionRoute() {
        LoadBaskets small = new LoadBaskets();
        ExpeditionAlgorithms ex =new ExpeditionAlgorithms(small);

        Client c1 = new Client("CT1", 40.6389, -8.6553, "C1");
        Client c2 = new Client("CT2", 38.0333, -7.8833, "C2");
        Client c3 = new Client("CT3", 41.5333, -8.4167, "C3");
        Client c4 = new Client("CT15", 41.7, -8.8333, "C4");
        Client c5 = new Client("CT16", 41.3002, -7.7398, "C5");
        Client c6 = new Client("CT12", 41.1495, -8.6108, "C6");
        Client c7 = new Client("CT7", 38.5667, -7.9, "C7");
        Client c8 = new Client("CT8", 37.0161, -7.935, "C8");
        Client c9 = new Client("CT13", 39.2369, -8.685, "C9");
        Company e1 = new Company("CT14", 38.5243, -8.8926, "E1");
        Company e2 = new Company("CT11", 39.3167, -7.4167, "E2");
        Company e3 = new Company("CT5", 39.823, -7.4931, "E3");
        Company e4 = new Company("CT9", 40.5364, -7.2683, "E4");
        Company e5 = new Company("CT4", 41.8, -6.75, "E5");
        Producer p1 = new Producer("CT17", 40.6667, -7.9167, "P1");
        Producer p2 = new Producer("CT6", 40.2111, -8.4291, "P2");
        Producer p3 = new Producer("CT10", 39.7444, -8.8072, "P3");

// add users to graph
        DistributionNet graph = new DistributionNet();
        graph.addUser(c1);
        graph.addUser(c2);
        graph.addUser(c3);
        graph.addUser(c4);
        graph.addUser(c5);
        graph.addUser(c6);
        graph.addUser(c7);
        graph.addUser(c8);
        graph.addUser(c9);
        graph.addUser(e1);
        graph.addUser(e2);
        graph.addUser(e3);
        graph.addUser(e4);
        graph.addUser(e5);
        graph.addUser(p1);
        graph.addUser(p2);
        graph.addUser(p3);

        graph.addDistance("CT10", "CT13", 63448L);
        graph.addDistance("CT10", "CT6", 67584L);
        graph.addDistance("CT10", "CT1", 110848L);
        graph.addDistance("CT10", "CT5", 125041L);
        graph.addDistance("CT12", "CT3", 50467L);
        graph.addDistance("CT12", "CT1", 62877L);
        graph.addDistance("CT12", "CT15", 70717L);
        graph.addDistance("CT11", "CT5", 62655L);
        graph.addDistance("CT11", "CT13", 121584L);
        graph.addDistance("CT11", "CT10", 142470L);
        graph.addDistance("CT14", "CT13", 89813L);
        graph.addDistance("CT14", "CT7", 95957L);
        graph.addDistance("CT14", "CT2", 114913L);
        graph.addDistance("CT14", "CT8", 207558L);
        graph.addDistance("CT13", "CT7", 111686L);
        graph.addDistance("CT16", "CT3", 68957L);
        graph.addDistance("CT16", "CT17", 79560L);
        graph.addDistance("CT16", "CT12", 82996L);
        graph.addDistance("CT16", "CT9", 103704L);

        // create test expedition list and client hub map
        ArrayList<Basket> expeditionList = new ArrayList<>();
        HashMap<User, User> clientHub = new HashMap<>();
        Product pr1= new Product(1,15);
        Product pr2= new Product(2,14);
        Product pr3= new Product(3,13);

        Trade t1 = new Trade(p1.getIdClientProducer(),pr1);
        Trade t2 = new Trade(p2.getIdClientProducer(),pr2);
        Trade t3 = new Trade(p3.getIdClientProducer(),pr3);
        Trade t4 = new Trade(p3.getIdClientProducer(),pr1);
        Trade t5 = new Trade(p2.getIdClientProducer(),pr1);


        HashMap<Product,Trade> received1 = new HashMap<>();
        received1.put(pr1,t1);
        HashMap<Product,Trade> received2 = new HashMap<>();
        received2.put(pr2,t2);
        received2.put(pr3,t3);
        HashMap<Product,Trade> received3 = new HashMap<>();
        received3.put(pr1,t4);
        received3.put(pr1,t5);
        expeditionList.add(new Basket(c1.getIdClientProducer(), received1));
        expeditionList.add(new Basket(c2.getIdClientProducer(), received2));
        expeditionList.add(new Basket(c3.getIdClientProducer(), received2));
        expeditionList.add(new Basket(c3.getIdClientProducer(), received1));
        expeditionList.add(new Basket(c4.getIdClientProducer(), received3));


        clientHub.put(c1, e1);
        clientHub.put(c3,e2);
        clientHub.put(c2,e2);
        clientHub.put(c4,e3);




        MatrixGraph<User, Long> shortPath =  GraphAlgorithms.minDistGraph(DistributionNet.getDistribution(), Long::compare, Long::sum);


        LinkedHashSet<User> result =ex.minDistributionRoute(shortPath, expeditionList, clientHub);

        LinkedHashSet<User> expectedResult = new LinkedHashSet<>();
        expectedResult.add(p1);
        expectedResult.add(p2);
        expectedResult.add(p3);
        expectedResult.add(e3);
        expectedResult.add(e2);
        expectedResult.add(e1);


        assertEquals(expectedResult, result);
    }


        @Test

    void expStatitics(){

        TreeMap<Float, User> hubs=netAlg.allCompanyHubs(3, DistributionNet.getDistribution());
        HashMap<User, User> clientHub=netAlg.nearestHub(hubs, DistributionNet.getDistribution());
        ArrayList<Integer> days = new ArrayList<>();
        days.add(1);
        HashMap<User, Set<String>>clientPerHub=new HashMap<>();
        HashMap<User, Set<String>>producerPerHub=new HashMap<>();
        for(Map.Entry<Float, User> c:hubs.entrySet()){

            producerPerHub.put(c.getValue(), new HashSet<>());
            clientPerHub.put(c.getValue(), new HashSet<>());


        }
        HashMap<String, ArrayList<String>> clientebaskets = new HashMap<>();
        HashMap<String, HashMap<String, Integer>> numberofGivenBaskets=new HashMap<>();
        HashMap<String, ArrayList<String>> distinctProd=new HashMap<>();
        //----mapas para teste----//
        HashMap<User, Set<String>>clientPerHub2=new HashMap<>();
        HashMap<User, Set<String>>producerPerHub2=new HashMap<>();
        for(Map.Entry<Float, User> c:hubs.entrySet()){

            producerPerHub2.put(c.getValue(), new HashSet<>());
            clientPerHub2.put(c.getValue(), new HashSet<>());


        }
        HashMap<String, ArrayList<String>> clientebaskets2 = new HashMap<>();
        HashMap<String, HashMap<String, Integer>> numberofGivenBaskets2=new HashMap<>();
        HashMap<String, ArrayList<String>> distinctProd2=new HashMap<>();

        clientebaskets2.put("C3", new ArrayList<>());
        clientebaskets2.get("C3").add("insatisfeito");
        distinctProd2.put("C3", new ArrayList<>());
        distinctProd2.get("C3").add("P3");

        clientebaskets2.put("E5", new ArrayList<>());
        clientebaskets2.get("E5").add("insatisfeito");
        distinctProd2.put("E5", new ArrayList<>());
        distinctProd2.get("E5").add("P3");
        distinctProd2.get("E5").add("P1");

        clientebaskets2.put("C8", new ArrayList<>());
        clientebaskets2.get("C8").add("insatisfeito");
        distinctProd2.put("C8", new ArrayList<>());
        distinctProd2.get("C8").add("P3");

        clientebaskets2.put("C9", new ArrayList<>());
        clientebaskets2.get("C9").add("insatisfeito");
        distinctProd2.put("C9", new ArrayList<>());
        distinctProd2.get("C9").add("P3");

        clientebaskets2.put("E2", new ArrayList<>());
        clientebaskets2.get("E2").add("insatisfeito");
        distinctProd2.put("E2", new ArrayList<>());
        distinctProd2.get("E2").add("P1");
        distinctProd2.get("E2").add("P3");
        distinctProd2.get("E2").add("P2");

        clientebaskets2.put("C1", new ArrayList<>());
        clientebaskets2.get("C1").add("insatisfeito");
        distinctProd2.put("C1", new ArrayList<>());
        distinctProd2.get("C1").add("P2");
        distinctProd2.get("C1").add("P1");

        clientebaskets2.put("C2", new ArrayList<>());
        clientebaskets2.get("C2").add("insatisfeito");
        distinctProd2.put("C2", new ArrayList<>());
        distinctProd2.get("C2").add("P1");
        distinctProd2.get("C2").add("P2");

        clientebaskets2.put("E4", new ArrayList<>());
        clientebaskets2.get("E4").add("insatisfeito");
        distinctProd2.put("E4", new ArrayList<>());
        distinctProd2.get("E4").add("P2");
        distinctProd2.get("E4").add("P1");
        distinctProd2.get("E4").add("P3");

        numberofGivenBaskets2.put("P1", new HashMap<>());
        numberofGivenBaskets2.get("P1").put("satisfeito", 0);
        numberofGivenBaskets2.get("P1").put("insatisfeito", 7);

        numberofGivenBaskets2.put("P2", new HashMap<>());
        numberofGivenBaskets2.get("P2").put("satisfeito", 0);
        numberofGivenBaskets2.get("P2").put("insatisfeito", 5);

        numberofGivenBaskets2.put("P3", new HashMap<>());
        numberofGivenBaskets2.get("P3").put("satisfeito", 3);
        numberofGivenBaskets2.get("P3").put("insatisfeito", 5);


        User u1=new User("noone", 0, 0);
        for (Float u:hubs.keySet()){
            if(hubs.get(u) instanceof Company){
                if(((Company) hubs.get(u)).getIdClientProducer().equals("E1")){
                    u1=hubs.get(u);
                }
            }
        }
        clientPerHub2.get(u1).add("C8");
        clientPerHub2.get(u1).add("C9");
        clientPerHub2.get(u1).add("C2");


        for (Float u:hubs.keySet()){
            if(hubs.get(u) instanceof Company){
                if(((Company) hubs.get(u)).getIdClientProducer().equals("E2")){
                    System.out.println("\nESTOUROU2");
                    u1=hubs.get(u);
                }
            }
        }
        producerPerHub2.get(u1).add("P1");
        producerPerHub2.get(u1).add("P2");
        producerPerHub2.get(u1).add("P3");

        for (Float u:hubs.keySet()){
            if(hubs.get(u) instanceof Company){
                if(((Company) hubs.get(u)).getIdClientProducer().equals("E3")){
                    u1=hubs.get(u);
                }
            }
        }
        clientPerHub2.get(u1).add("C3");
        clientPerHub2.get(u1).add("C6");
        clientPerHub2.get(u1).add("C1");
        producerPerHub2.get(u1).add("P1");
        producerPerHub2.get(u1).add("P2");
        producerPerHub2.get(u1).add("P3");

        exp.expStatitics(hubs, clientHub, days, clientPerHub, producerPerHub, clientebaskets, numberofGivenBaskets, distinctProd);
        for (Map.Entry<User, Set<String>> ch:clientPerHub2.entrySet()){
            assertEquals(ch.getValue(), clientPerHub.get(ch.getKey()));
        }
        for (Map.Entry<User, Set<String>> ph:producerPerHub2.entrySet()){
            assertEquals(ph.getValue(), producerPerHub.get(ph.getKey()));
        }
        for (Map.Entry<String, ArrayList<String>> cb:clientebaskets2.entrySet()){

            assertEquals(cb.getValue(), clientebaskets.get(cb.getKey()));
        }
        for (Map.Entry<String, ArrayList<String>> cb:distinctProd2.entrySet()){

            assertEquals(cb.getValue(), distinctProd.get(cb.getKey()));
        }
        for (Map.Entry<String, HashMap<String, Integer>> cb:numberofGivenBaskets2.entrySet()){
            assertEquals(cb.getValue(), numberofGivenBaskets.get(cb.getKey()));
        }

    }


/*
    @Test
    void expeditionListWithRestrictions() throws IOException {
        LoadBaskets small = new LoadBaskets();
        DistributionNet dNet = new DistributionNet();
        LoadNetDistribution lNetDist = new LoadNetDistribution(dNet);
        DistributionNetAlgorithms dNetAlg = new DistributionNetAlgorithms();
        DistributionManagerController ctrl = new DistributionManagerController();
        ctrl.s
        dNetAlg.getHubs(3)
        lNetDist.loadDistance("src/main/resources/load/Small/distancias_small.csv");
        lNetDist.loadUser("src/main/resources/load/Small/clientes-produtores_small.csv");
        small.fillStockAndOrders("src/main/resources/load/Small/cabazes_small.csv");
        ExpeditionAlgorithms exp1 = new ExpeditionAlgorithms(small);
        assertEquals(12, exp1.expeditionListWithRestrictions(3, 3, , dNet.getProducerList(), DistributionNet.getDistribution()).size());
    }
    */

    @Test
    public void testGetNProducersStock() throws FileNotFoundException {
        LoadBaskets small = new LoadBaskets();
        small.fillStockAndOrders("src/main/resources/load/Small/cabazes_small.csv");
        // Create a TreeMap of users
        TreeMap<Long, User> nNearestProducers = new TreeMap<>();
        User user1 = new User("user1",0,0);
        User user2 = new User("user2",0,0);
        nNearestProducers.put(1L, user1);
        nNearestProducers.put(2L, user2);

        // Create a HashMap of stocks for each user
        HashMap<String, HashMap<Integer, ArrayList<Product>>> stock = new HashMap<>();
        HashMap<Integer, ArrayList<Product>> user1Stock = new HashMap<>();
        ArrayList<Product> user1StockList = new ArrayList<>();
        user1StockList.add(new Product(1, 10));
        user1Stock.put(1, user1StockList);
        stock.put("user1", user1Stock);

        HashMap<Integer, ArrayList<Product>> user2Stock = new HashMap<>();
        ArrayList<Product> user2StockList = new ArrayList<>();
        user2StockList.add(new Product(2, 20));
        user2Stock.put(2, user2StockList);
        stock.put("user2", user2Stock);

        // Call the getNProducersStock method
        ExpeditionAlgorithms classUnderTest = new ExpeditionAlgorithms(small);
        HashMap<String, HashMap<Integer, ArrayList<Product>>> result = classUnderTest.getNProducersStock(nNearestProducers);

        // Assert that the result is correct
        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals(user1Stock, result.get("user1"));
        assertEquals(user2Stock, result.get("user2"));
    }
}

