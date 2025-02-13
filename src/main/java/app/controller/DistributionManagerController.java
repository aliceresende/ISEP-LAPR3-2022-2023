package app.controller;


import app.domain_model.*;
import app.graph.Graph;

import app.graph.algorithm.GraphAlgorithms;
import app.service.DistributionNetAlgorithms;
import app.service.load.LoadNetDistribution;
import app.graph.map.DistributionNet;
import app.graph.matrix.MatrixGraph;
import app.service.ExpeditionAlgorithms;
import app.service.load.LoadWatering;
import app.service.load.LoadBaskets;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.*;

/**
 * The type Distribution manager controller.
 */
public class DistributionManagerController {
    /**
     * The D net.
     */
    DistributionNet dNet = new DistributionNet();

    DistributionNetAlgorithms netAlgoritms = new DistributionNetAlgorithms();
    /**
     * The Sys.
     */
    WateringSystem sys = new WateringSystem();

    LoadBaskets baskets = new LoadBaskets();

    ExpeditionAlgorithms exp;

    /**
     * The N hubs.
     */
    int nHubs;
    TreeMap<Float, User> result = new TreeMap<>();

    HashMap<User, User> clientHubDist;

    String loadUserSmall="src/main/resources/load/Small/clientes-produtores_small.csv";
    String loadUserBig="src/main/resources/load/Big/clientes-produtores_big.csv";

    String loadDistanceSmall="src/main/resources/load/Small/distancias_small.csv";
    String loadDistanceBig="src/main/resources/load/Big/distancias_big.csv";

    String loadBasketSmall="src/main/resources/load/Small/cabazes_small.csv";
    String loadBasketsBig="src/main/resources/load/Big/cabazes_big.csv";


    /**
     * Print distribution network graph.
     *
     * @throws IOException the io exception
     */
    public void printDistributionNetworkGraph() throws IOException {
        LoadNetDistribution load = new LoadNetDistribution(dNet);


        load.loadUser(loadUserSmall);
        load.loadDistance(loadDistanceSmall);
        System.out.println(DistributionNet.getDistribution().toString());
    }

    /**
     * Graph connection.
     */
    public void graphConnection() {
        if (netAlgoritms.isConnected(DistributionNet.getDistribution())) {
            System.out.println("The graph is connected! :)");
        } else {
            System.out.println("The graph is not connected! :(");
        }
    }

    /**
     * Get minimum connection between pc.
     */
    public void getMinimumConnectionBetweenPC() {
        int minConnect = netAlgoritms.getMinConnections(DistributionNet.getDistribution());
        System.out.println("Minimum connections between producer and client: " + minConnect);
    }


    /**
     * Get mst.
     */
    public void getMST() {
        Graph<User, Long> mst = netAlgoritms.kruskall_mst(DistributionNet.getDistribution());
        System.out.println(mst);
    }


    /**
     * Check watering system.
     */
    public void checkWateringSystem() {
        LoadWatering load = new LoadWatering();
        load.LoadWatering(sys);
        System.out.println(sys);
        String check = sys.checkWatering();
        System.out.println(check);
    }
    private MatrixGraph<User, Long> shortPath(){
        return  GraphAlgorithms.minDistGraph(DistributionNet.getDistribution(), Long::compare, Long::sum);

    }
    /**
     * Check all company hubs.
     *
     * @param N the n
     */
    public TreeMap<Float, User> checkAllCompanyHubs(int N) {
        if (shortPath() != null) {
            this.result = netAlgoritms.getHubs(shortPath(), N);
        }
        return this.result;
    }

    /**
     * Client hub distance.
     */
    public HashMap<User, User> clientHubDistance() {
        clientHubDist = netAlgoritms.nearestHub(this.result, DistributionNet.getDistribution());
        return clientHubDist;

    }

    public void loadBaskets() throws FileNotFoundException {

        baskets.fillStockAndOrders(loadBasketSmall);

        this.exp = new ExpeditionAlgorithms(baskets);

        System.out.println("=============== STOCK =================");
        baskets.toStringStock();
        System.out.println("=============== ORDERS =================");
        baskets.toStringOrder();

    }


    public List<Basket> generateExpeditionListWithNoRestrictions(int day) {
        return exp.expeditionListWithNoRestrictions(day);
    }

    public void minimumPath(int day) {
        exp.minDistributionRoute(shortPath(), (ArrayList<Basket>) generateExpeditionListWithNoRestrictions(day),clientHubDistance());
        System.out.println("");
        exp.getBasketsByHub((ArrayList<Basket>) generateExpeditionListWithNoRestrictions(day),clientHubDistance());
    }

    public void generateExpeditionListWithRestrictions(int day, int n) {

       ArrayList<Basket> b = exp.expeditionListWithRestrictions(day, n, clientHubDist, dNet.getProducerList());
        System.out.println(b);

    }
    public void expeditionCalculations() {
        ArrayList<Integer> days=exp.getOrdersDays();
        exp.setupStatistics(days, result, clientHubDist);
    }
}


