package app.service;

import app.domain_model.*;
import app.graph.Graph;
import app.graph.algorithm.GraphAlgorithms;
import app.graph.map.DistributionNet;
import app.service.load.LoadBaskets;

import java.util.*;

import static app.graph.map.DistributionNet.getVertexByUser;


public class ExpeditionAlgorithms {

    HashMap<String, HashMap<Integer, ArrayList<Product>>> stock;
    HashMap<String, HashMap<Integer, ArrayList<Product>>> orders;


    public ExpeditionAlgorithms(LoadBaskets baskets) {
        this.orders = baskets.getOrders();
        this.stock = baskets.getStock();
    }

    public ArrayList<Basket> expeditionListWithNoRestrictions(int day) {
        String idClient;
        ArrayList<Basket> expeditionList = new ArrayList<>();
        for (Map.Entry<String, HashMap<Integer, ArrayList<Product>>> entry : this.orders.entrySet()) {
            idClient = entry.getKey();
            HashMap<Integer, ArrayList<Product>> value = entry.getValue();
            for (Map.Entry<Integer, ArrayList<Product>> innerEntry : value.entrySet()) {
                if (day == innerEntry.getKey()) {
                    HashMap<Product, Trade> tradedProducts = new HashMap<>();
                    for (Product product : innerEntry.getValue()) {
                        if (product.getQuantity() != 0) {
                            Trade trade = tradeGetter(day, this.stock, product);
                            tradedProducts.put(product, trade);
                        }
                    }
                    if (!tradedProducts.isEmpty()) {
                        Basket basket = new Basket(idClient, tradedProducts);
                        expeditionList.add(basket);
                    }
                }
            }
        }
        return expeditionList;
    }

    public Trade tradeGetter(int day, HashMap<String, HashMap<Integer, ArrayList<Product>>> stock, Product requested) {
        double bestDeal = 0;
        Product bestDealProduct;
        String idProducer;
        Trade trade = new Trade(" - ", new Product(requested.getId_number(), 0));

        for (Map.Entry<String, HashMap<Integer, ArrayList<Product>>> entry : stock.entrySet()) {
            idProducer = entry.getKey();
            HashMap<Integer, ArrayList<Product>> value = entry.getValue();
            for (Map.Entry<Integer, ArrayList<Product>> innerEntry : value.entrySet()) {
                if (innerEntry.getKey() == day || innerEntry.getKey() == day - 1 || innerEntry.getKey() == day - 2) {
                    for (Product product : innerEntry.getValue()) {
                        if (Objects.equals(product.getProduct_number(), requested.getProduct_number())) {
                            if (product.getQuantity() >= requested.getQuantity()) {
                                product.setQuantity(product.getQuantity() - requested.getQuantity());
                                trade = new Trade(idProducer, requested);
                                return trade;
                            } else if (product.getQuantity() > bestDeal) {
                                bestDeal = product.getQuantity();
                                bestDealProduct = product;
                                trade = new Trade(idProducer, bestDealProduct);
                                if (innerEntry.getKey() > day) {
                                    stock.get(trade.getIdProducer()).get(day).get(bestDealProduct.getId_number() - 1).setQuantity(0);
                                    bestDeal = 0;
                                }
                            }
                        }
                    }
                }
            }
        }
        return trade;
    }



    //GraphAlgorithms.shortestPath(allUsersGraph, u1, u2, Long::compare, Long::sum, 0L, paths)


    /*
    public Trade tradeGetter(int day, HashMap<String, HashMap<Integer, ArrayList<Product>>> stock, Product requested) {

        double bestDeal = 0;
        Product bestDealProduct;
        String idProducer;
        Trade trade = new Trade("Nobody", null);


        for (Map.Entry<String, HashMap<Integer, ArrayList<Product>>> entry : stock.entrySet()) {
            idProducer = entry.getKey();
            HashMap<Integer, ArrayList<Product>> value = entry.getValue();
            for (Map.Entry<Integer, ArrayList<Product>> innerEntry : value.entrySet()) {
                if (day - 2 > 0) {
                    for (Product product1 : innerEntry.getValue()) {
                        if (Objects.equals(product1.getProduct_number(), requested.getProduct_number())) {
                            if (product1.getQuantity() >= requested.getQuantity() && day - 2 == innerEntry.getKey()) {
                                product1.setQuantity(product1.getQuantity() - requested.getQuantity());
                                trade = new Trade(idProducer, requested);
                                return trade;

                            } else if (day - 1 > 0) {
                                for (Product product2 : innerEntry.getValue()) {
                                    if (Objects.equals(product2.getProduct_number(), requested.getProduct_number())) {
                                        product2.setQuantity(product2.getQuantity() + product1.getQuantity());
                                        if (product2.getQuantity() >= requested.getQuantity() && day - 1 == innerEntry.getKey()) {
                                            product1.setQuantity(0);
                                            product2.setQuantity(product2.getQuantity() - requested.getQuantity());
                                            trade = new Trade(idProducer, requested);
                                            return trade;

                                        } else if (day > 0) {
                                            for (Product product3 : innerEntry.getValue()) {
                                                if (Objects.equals(product3.getProduct_number(), requested.getProduct_number())) {
                                                    product3.setQuantity(product3.getQuantity() + product2.getQuantity());
                                                    if (product3.getQuantity() >= requested.getQuantity() && day == innerEntry.getKey()) {
                                                        product2.setQuantity(0);
                                                        product3.setQuantity(product3.getQuantity() - requested.getQuantity());
                                                        trade = new Trade(idProducer, requested);
                                                        return trade;

                                                    } else if (product3.getQuantity() > bestDeal) {
                                                        bestDeal = product3.getQuantity();
                                                        bestDealProduct = product3;
                                                        trade = new Trade(idProducer, bestDealProduct);
                                                        if (innerEntry.getKey() > day) {
                                                            stock.get(trade.getIdProducer()).get(day).get(bestDealProduct.getId_number() - 1).setQuantity(0);
                                                            bestDeal = 0;
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else if (day - 1 > 0) {
                    for (Product product2 : innerEntry.getValue()) {
                        if (Objects.equals(product2.getProduct_number(), requested.getProduct_number())) {
                            if (product2.getQuantity() >= requested.getQuantity() && day - 1 == innerEntry.getKey()) {
                                product2.setQuantity(product2.getQuantity() - requested.getQuantity());
                                trade = new Trade(idProducer, requested);
                                return trade;

                            } else if (day > 0) {
                                for (Product product3 : innerEntry.getValue()) {
                                    if (Objects.equals(product3.getProduct_number(), requested.getProduct_number())) {
                                        product3.setQuantity(product3.getQuantity() + product2.getQuantity());
                                        if (product3.getQuantity() >= requested.getQuantity() && day == innerEntry.getKey()) {
                                            product2.setQuantity(0);
                                            product3.setQuantity(product3.getQuantity() - requested.getQuantity());
                                            trade = new Trade(idProducer, requested);
                                            return trade;

                                        } else if (product3.getQuantity() > bestDeal) {
                                            bestDeal = product3.getQuantity();
                                            bestDealProduct = product3;
                                            trade = new Trade(idProducer, bestDealProduct);
                                            if (innerEntry.getKey() > day) {
                                                stock.get(trade.getIdProducer()).get(day).get(bestDealProduct.getId_number() - 1).setQuantity(0);
                                                bestDeal = 0;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else if (day > 0) {
                    for (Product product3 : innerEntry.getValue()) {
                        if (Objects.equals(product3.getProduct_number(), requested.getProduct_number())) {
                            if (product3.getQuantity() >= requested.getQuantity() && day == innerEntry.getKey()) {
                                product3.setQuantity(product3.getQuantity() - requested.getQuantity());
                                trade = new Trade(idProducer, requested);
                                return trade;

                            } else if (product3.getQuantity() > bestDeal) {
                                bestDeal = product3.getQuantity();
                                bestDealProduct = product3;
                                trade = new Trade(idProducer, product3);
                                if (innerEntry.getKey() > day) {
                                    stock.get(trade.getIdProducer()).get(day).get(bestDealProduct.getId_number() - 1).setQuantity(0);
                                    bestDeal = 0;
                                }
                            }
                        }
                    }
                }
            }
        }
        return trade;
    }
*/


    public TreeMap<Long, User> getNNearestProducers(User client, int n, HashMap<User, User> clientHub, ArrayList<User> allProducers) {
        User hub = getClientsHub(clientHub, client);
        TreeMap<Long, User> nearestNProducers = new TreeMap<>();
        Long distance;
        LinkedList<User> paths = new LinkedList<>();
        for (User producer : allProducers) {
            distance = GraphAlgorithms.shortestPath(DistributionNet.getDistribution(), hub, producer, Long::compare, Long::sum, 0L, paths);
            if (nearestNProducers.size() == n) {
                nearestNProducers.put(distance, producer);
                nearestNProducers.remove(nearestNProducers.lastKey());
            } else {
                nearestNProducers.put(distance, producer);
            }
        }
        return nearestNProducers;
    }

    public User getClientsHub(HashMap<User, User> clientHub, User client) {
        User hub;
        for (User clientIterator : clientHub.keySet()) {

            if (clientIterator.equals(client)) {
                hub = clientHub.get(clientIterator);
                return hub;
            }
        }
        return null;
    }


    private List<User> getProducersOfExpeditionList(ArrayList<Basket> expeditionList) {
        ArrayList<User> producers = new ArrayList<>();
        for (Basket basket : expeditionList) {
            for (Trade trade : basket.getRequested().values()) {
                User producer = getVertexByUser(trade.getIdProducer());
                if (!producers.contains(producer)) {
                    producers.add(producer);
                }
            }
        }
        return producers;
    }

    // Deve-se correr primeiro a US303 e 304 para obter os hubs de todos os clientes
    private List<User> getClientHubsOfExpeditionList(ArrayList<Basket> expeditionList, HashMap<User, User> clientHub) {
        ArrayList<User> hubs = new ArrayList<>();
        for (Basket basket : expeditionList) {
            User client = getVertexByUser(basket.getIdClient());
            User hub = clientHub.get(client);
            if(!hubs.contains(hub) && hub!=null){
                hubs.add(hub);
            }

        }
        return hubs;
    }

    public void getBasketsByHub(ArrayList<Basket> expeditionList, HashMap<User, User> clientHub) {
        HashMap<User, ArrayList<Basket>> basketsByHub = new HashMap<>();

        for (Basket basket : expeditionList) {
            User client = getVertexByUser(basket.getIdClient());
            User hub = clientHub.get(client);
            if (!basketsByHub.containsKey(hub)) {
                basketsByHub.put(hub, new ArrayList<>());
            }
            basketsByHub.get(hub).add(basket);
        }
        System.out.println("Baskets delivered in each Hub:");
        for (Map.Entry<User, ArrayList<Basket>> entry : basketsByHub.entrySet()) {
            if (entry.getKey() instanceof Company) {
                System.out.print("To the Hub "+((Company) entry.getKey()).getIdClientProducer() + " was delievered ");
            }
            Set<String> printedValues = new HashSet<>();  // create a set to store printed values
            for (Basket basket : entry.getValue()) {
                for (Trade trade : basket.getRequested().values()) {
                    String productNumber = trade.getProduct().getProduct_number();  // get the product number
                    if (!printedValues.contains(productNumber)) {  // check if it has been printed
                        System.out.print(productNumber + " ");  // print the product number
                        printedValues.add(productNumber);  // add it to the set of printed values
                    }
                }
            }
            System.out.println("");
        }
    }


    public LinkedHashSet<User> minDistributionRoute(Graph<User, Long> graph, ArrayList<Basket> expeditionList, HashMap<User, User> clientHub) {
        List<User> users = getProducersOfExpeditionList(expeditionList);
        List<User> companies = getClientHubsOfExpeditionList(expeditionList, clientHub);
        TreeMap<Long, User> map = new TreeMap<>((a, b) -> (int) (b - a));
        long min = Long.MAX_VALUE;
        User closestCompany = null;
        for(User producer : users){
            long minValue = Long.MAX_VALUE;
            User comp = null;
            for (User company : companies){
                long weight = graph.edge(producer, company).getWeight();
                if(minValue > weight){
                    minValue = weight;
                    comp = company;
                }
            }
            if(min > minValue){
                closestCompany = comp;}
        }
        map.put(0L, closestCompany);
        for(User producer : users){
            long weight = graph.edge(producer, closestCompany).getWeight();
            map.put(weight, producer);
        }
        companies.remove(closestCompany);
        for(User company : companies){
            long weight = graph.edge(company, closestCompany).getWeight();
            map.put(-weight, company);
        }
        LinkedList<User> listCompaniesProducers = new LinkedList<>(map.values());
        LinkedHashSet<User> finalList = new LinkedHashSet<>();
        LinkedList<User> aux;
        for (int i = 0; i < listCompaniesProducers.size() - 1; i++) {
            aux = new LinkedList<>();
            GraphAlgorithms.shortestPath(graph, listCompaniesProducers.get(i), listCompaniesProducers.get(i + 1), Long::compare, Long::sum, 0L, aux);
            finalList.addAll(aux);
        }
        System.out.println("Passing points in rote: "+finalList);
        printTotalDistance(graph, listCompaniesProducers);
        System.out.println("");
        printDistancesBetweenWaypoints(graph, listCompaniesProducers);
        System.out.println("");
        return finalList;
    }


    private void printDistancesBetweenWaypoints(Graph<User, Long> graph, LinkedList<User> finalList) {
        System.out.println("Distance between rote points: ");
        for (int i = 0; i < finalList.size() - 1; i++) {
            System.out.println(finalList.get(i) + " - " + finalList.get(i + 1) + ": " + graph.edge(finalList.get(i), finalList.get(i + 1)).getWeight());
        }
    }

    private void printTotalDistance(Graph<User, Long> graph, LinkedList<User> finalList) {
        long totalDistance = 0;
        for (int i = 0; i < finalList.size() - 1; i++) {
            totalDistance += graph.edge(finalList.get(i), finalList.get(i + 1)).getWeight();
        }
        System.out.println("Total distance: " + totalDistance);

    }
    public User findHubCompany(String id, HashMap<User, User> hubClient){
        for(Map.Entry<User, User> hc: hubClient.entrySet()){
            if(hc.getKey() instanceof Company){
                if(((Company) hc.getKey()).getIdClientProducer().equals(id)){
                    return hc.getValue();
                }
            }
        }
        return new User("empty", 0, 0);
    }
    public User findHubClient(String id, HashMap<User, User> hubClient){
        for(Map.Entry<User, User> hc: hubClient.entrySet()){
            if(hc.getKey() instanceof Client){
                if(((Client) hc.getKey()).getIdClientProducer().equals(id)){
                    return hc.getValue();
                }
            }
        }
        return new User("empty", 0, 0);
    }
    public void getClientHub(HashMap<String, ArrayList<String>> clientGivenProducers, HashMap<User, Set<String>>clientPerHub,
                             HashMap<User, Set<String>>producerPerHub, HashMap<User, User> hubClient){
        User u1;
        HashMap<String, Set<String>> clPerHub=new HashMap<>();
        for(Map.Entry<String, ArrayList<String>> cp:clientGivenProducers.entrySet()){
            if(cp.getKey().charAt(0)=='E'){
                u1=findHubCompany(cp.getKey(), hubClient);
                if(!u1.getIdLoc().equals("empty")){
                    for (String p:cp.getValue()){
                        producerPerHub.get(u1).add(p);
                    }
                }
            }else{
                u1=findHubClient(cp.getKey(), hubClient);
                if(!u1.getIdLoc().equals("empty")){
                    clientPerHub.get(u1).add(cp.getKey());
                }
            }
        }
    }
    public ArrayList<Integer> getOrdersDays(){
        ArrayList<Integer> days = new ArrayList<>();
        for (Map.Entry<String, HashMap<Integer, ArrayList<Product>>> o: orders.entrySet()){
            for(Map.Entry<Integer, ArrayList<Product>> d:o.getValue().entrySet()){
                if(!days.contains(d.getKey())){
                    days.add(d.getKey());
                }
            }
        }
        return days;
    }
    public void setupStatistics(ArrayList<Integer>days, TreeMap<Float, User> hubs, HashMap<User, User>clientHubs){
        //Mapa que armazena um hub e a lista de id de clientes que tiveram os seus cabazes entregues a respetivo hub
        HashMap<User, Set<String>>clientPerHub=new HashMap<>();
        //Mapa que armazena um hub e a lista de id de produtores distintos que forneceram cabazes ao hub
        HashMap<User, Set<String>>producerPerHub=new HashMap<>();
        for(Map.Entry<Float, User> c:hubs.entrySet()){
            //preencher os maps com todos os hubs existentes no programa
            producerPerHub.put(c.getValue(), new HashSet<>());
            clientPerHub.put(c.getValue(), new HashSet<>());


        }

        HashMap<String, ArrayList<String>> clientebaskets = new HashMap<>();//cabazes satisfeitos e parcialmente satisfeitos por cliente
        HashMap<String, HashMap<String, Integer>> numberofGivenBaskets=new HashMap<>();//numero de cabazes fornecidos, totalmente e parcialmente
        //mapa com uma key associada a um cliente id e um arraylist com os produtores distintos que forneceram cabazes a clientes
        HashMap<String, ArrayList<String>> distinctProd=new HashMap<>();
        //método que usara os maps criados para executar os calculos necessarios
        expStatitics(hubs, clientHubs, days, clientPerHub, producerPerHub, clientebaskets, numberofGivenBaskets, distinctProd);
    }


    public void expStatitics(TreeMap<Float, User> hubs, HashMap<User, User>clientHubs, ArrayList<Integer> days, HashMap<User, Set<String>>clientPerHub,
                             HashMap<User, Set<String>>producerPerHub, HashMap<String, ArrayList<String>> clientebaskets, HashMap<String, HashMap<String, Integer>> numberofGivenBaskets,
                             HashMap<String, ArrayList<String>> distinctProd){

        //percorrer todods os dias com encomendas de cabazes
        for(int day:days){
            //lista de expedição diária sem restrições
            ArrayList<Basket> expedition = expeditionListWithNoRestrictions(day);
            if(!(expedition ==null)){
                //calculos para preencher outros maps e gerar lista com as contas por cabaz
                expCalculations(expedition, clientebaskets, numberofGivenBaskets,
                        distinctProd);
            }
        }
        System.out.println("|_|_|_|_|  CALCULOS DE ESTATISTICA POR CLIENTE  |_|_|_|_|");
        for(Map.Entry<String, ArrayList<String>> cl:clientebaskets.entrySet()){
            System.out.println("\nCliente -> " + cl.getKey());//id de cliente
            int filled=Collections.frequency(cl.getValue(), "satisfeito");//numero de vezes que os cabazes foram satisfeitos
            int unfilled=Collections.frequency(cl.getValue(), "insatisfeito");//numero de vezes que os cabazes foram parcialmente satisfeitos
            System.out.println("\nnº de cabazes totalmente satisfeitos: " + filled);
            System.out.println("\nnº de cabazes parcialmente satisfeitos: " + unfilled);
            if(distinctProd.containsKey(cl.getKey())){
                //todos os produtores que forneceram cabazes ao cliente
                System.out.println("\nprodutores que forneceram os cabazes: " + distinctProd.get(cl.getKey()));
            }
        }
        System.out.println("|_|_|_|_|  CALCULOS DE ESTATISTICA POR PRODUTOR  |_|_|_|_|");
        //for each de produtores
        for(Map.Entry<String, HashMap<String, Integer>> prodMath:numberofGivenBaskets.entrySet()){
            String idP=prodMath.getKey();
            int numberHubs=0;

            for(Map.Entry<String, ArrayList<String>> c:clientebaskets.entrySet()){
                String idC=c.getKey();
                if(c.getValue().contains(idP)&&idC.charAt(0)=='E'){
                    for(Map.Entry<Float, User> hub:hubs.entrySet()){
                        if(hub.getValue() instanceof Company){
                            if(((Company) hub.getValue()).getIdClientProducer()==idC) {
                                numberHubs++;
                            }
                        }
                    }
                }

            }
            System.out.println("\nProducer -> "+idP);
            System.out.println("\nnº de cabazes totalmente fornecidos: " + prodMath.getValue().get("satisfeito"));
            System.out.println("\nnº de cabazes parcialmente fornecidos: " + prodMath.getValue().get("insatisfeito"));
            System.out.println("\nnº de cabazes esgotados fornecidos: " + prodMath.getValue().get("esgotado"));
            System.out.println("\nnº de cabazes hubs fornecidos: " + numberHubs);

        }
        System.out.println("|_|_|_|_|  CALCULOS DE ESTATISTICA POR HUB  |_|_|_|_|");
        getClientHub(distinctProd, clientPerHub, producerPerHub, clientHubs);
        for(Map.Entry<Float, User> c:hubs.entrySet()){
            if(c.getValue() instanceof Company){
                System.out.println("Hub -> " + ((Company) c.getValue()).getIdClientProducer());
            }
            System.out.println("\nnumber of clients per hub: " + clientPerHub.get(c.getValue()).size());
            System.out.println("\nnumber of producers that gave products to hub: " + producerPerHub.get(c.getValue()).size());
        }

    }



    public void expCalculations(ArrayList<Basket> baskets, HashMap<String, ArrayList<String>>clientebaskets,
                                HashMap<String, HashMap<String, Integer>> numberofGivenBaskets, HashMap<String, ArrayList<String>> distinctProd){

        String idC;//id do cliente
        int demanded=0;//numero de produtos encomendados por cliente
        int received=0;//numero de vezes que o produto foi totalmente fornecido
        float basketSatisfaction=0;//percentagem de
        ArrayList<String> producers = new ArrayList<>();//list com os diferentes produtores que forneceram os cabazes
        System.out.println("|_|_|_|_|  CALCULOS DE ESTATISTICA POR CABAZ  |_|_|_|_|");

        for(int i=0; i<baskets.size(); i++){
            //get id do cliente
            idC=baskets.get(i).getIdClient();

            HashMap<Product, Trade> rec = baskets.get(i).getRequested();


            //caso o cliente não exista no map distinctProd entao é preciso inicializar uma key com o idC

            if(!distinctProd.containsKey(idC)){
                distinctProd.put(idC, new ArrayList<>());
            }
            for(Map.Entry<Product, Trade> product: rec.entrySet()) {
                //calculos dos cabazes
                demanded++;
                if (!product.getValue().getIdProducer().equals("Nobody")){
                    //quantidade pedida==quantidade recebida
                    if (product.getKey().getQuantity() == product.getValue().getProduct().getQuantity()) {
                        received++;
                    }
                    //adicionar produtor a distinctProd caso não exista
                    if(!distinctProd.get(idC).contains(product.getValue().getIdProducer())) {
                        distinctProd.get(idC).add(product.getValue().getIdProducer());
                    }
                    if (!producers.contains(product.getValue().getIdProducer())) {
                        //produtores distintos
                        producers.add(product.getValue().getIdProducer());
                    }
                }else{

                    distinctProd.get(idC).add("esgotado");
                }

            }
            /**calcular percentagem de satisfação do cabaz
             * adicionar à lista de clientes se o cabaz foi 100% satisfeito ou não
             */
            if(received!=0){
                basketSatisfaction=received/demanded * 100;
                if(basketSatisfaction==100){
                    //adicionar id do client a clientebaskets e se foi totalmente satisfeito ou nao
                    if(!clientebaskets.containsKey(idC)){
                        clientebaskets.put(idC, new ArrayList<>());
                    }
                    clientebaskets.get(idC).add("satisfeito");
                }else{//incrementar o contador de cabazes parcialmento satisfeitos no cliente do cabaz atual
                    if(!clientebaskets.containsKey(idC)){
                        clientebaskets.put(idC, new ArrayList<>());
                    }
                    clientebaskets.get(idC).add("insatisfeito");
                }
            }
            //print por cabaz
            System.out.println("Cabaz do cliente com id -> " + baskets.get(i).getIdClient() +
                    "\n numero de produtos totalmente satisfeitos: " + received +
                    "\n numero de produtos parcialmente satisfeitos: " + (demanded - received) +
                    "\n numero de produtores que forneceram o cabaz: " + producers.size());


            //adicionar à lista de produtores elementos que indicam se o cabaz foi 100% satisfeito ou não
            if(producers.size()!=0) {
                for (String prod : producers) {
                    if (!numberofGivenBaskets.containsKey(prod)) {
                        HashMap<String, Integer> givenBasket = new HashMap<>();
                        givenBasket.put("satisfeito", 0);
                        givenBasket.put("insatisfeito", 0);
                        numberofGivenBaskets.put(prod, givenBasket);
                    }
                }
                if(producers.size()==1) {
                    HashMap<String, Integer> giveBasket = numberofGivenBaskets.get(producers.get(0));
                    int count = giveBasket.get("satisfeito");
                    numberofGivenBaskets.get(producers.get(0)).put("satisfeito", count+1);
                }else{
                    for (String prod2 : producers) {
                        HashMap<String, Integer> giveBasket2 = numberofGivenBaskets.get(prod2);
                        int count = giveBasket2.get("insatisfeito");
                        numberofGivenBaskets.get(prod2).put("insatisfeito", count + 1);
                    }
                }

            }
            //resetar os valores para o proximo ciclo
            demanded = 0;
            received = 0;
            System.out.println("antes: "+producers.size());
            producers.removeAll(producers);
            basketSatisfaction=0;
        }


        System.out.println("\n--------------------------------------\n");

    }

    public ArrayList<Basket> expeditionListWithRestrictions( int day, int n, HashMap<User, User > clientHub, ArrayList < User > allProducersList){

        TreeMap<Long, User> nProducers;
        User client;
        String idClient;
        ArrayList<Basket> expeditionList = new ArrayList<>();
        for (Map.Entry<String, HashMap<Integer, ArrayList<Product>>> entry : this.orders.entrySet()) {
            HashMap<String, HashMap<Integer, ArrayList<Product>>> nProducersStock = new HashMap<>();
            idClient = entry.getKey();
            client = getVertexByUser(idClient);
            nProducers = getNNearestProducers(client, n, clientHub, allProducersList);
            HashMap<Integer, ArrayList<Product>> value = entry.getValue();
            nProducersStock=getNProducersStock(nProducers);
            for (Map.Entry<Integer, ArrayList<Product>> innerEntry : value.entrySet()) {
                if (day == innerEntry.getKey()) {
                    HashMap<Product, Trade> tradedProducts = new HashMap<>();
                    for (Product product : innerEntry.getValue()) {
                        if (product.getQuantity() != 0) {
                            Trade trade = tradeGetter(day,nProducersStock, product);
                            tradedProducts.put(product, trade);
                        }
                    }
                    if (!tradedProducts.isEmpty()) {
                        Basket basket = new Basket(idClient, tradedProducts);
                        expeditionList.add(basket);
                    }
                }

            }
        }


        return expeditionList;
    }

    public HashMap<String, HashMap<Integer, ArrayList<Product>>> getNProducersStock(TreeMap < Long, User > nNearestProducers){
        HashMap<String, HashMap<Integer, ArrayList<Product>>> nProducerStock = new HashMap<>();
        for (User producer : nNearestProducers.values()) {
            for (String idProducer : stock.keySet()) {
                if (getVertexByUser(idProducer).equals(producer)) {
                    nProducerStock.put(idProducer, stock.get(idProducer));
                }
            }
        }
        return nProducerStock;
    }

}


