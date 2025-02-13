package app.ui;

import app.controller.DistributionManagerController;
import app.domain_model.Basket;
import app.domain_model.User;
import app.utils.Utils;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.*;

/**
 * The type Distribution manager ui.
 */
public class DistributionManagerUI implements Runnable{
    /**
     * Instantiates a new Distribution manager ui.
     */
    public DistributionManagerUI() {
    }
    public void run(){
        Scanner read = new Scanner(System.in);
        List<String> options=new ArrayList<>();
        DistributionManagerController distManagerCtrl = new DistributionManagerController();
        options.add("Distribution Network Print");
        options.add("Verify if is connected and the minimum connections");
        options.add("Get minimal distance graph");
        options.add("Check watering system");
        options.add("Get company hubs");
        options.add("Client-Hub distances");
        options.add("Load Baskets");
        options.add("Expedition List With no Restriction");
        options.add("Expedition List With Restriction");
        options.add("Minimum delivery path");
        options.add("Expedition Calculations");
        options.add("Quit");
        int option;
        do{
            option= Utils.showAndSelectIndex(options, "\n\n#########- Distribution Manager Menu -############\n\n");
            switch (option) {
                case 0 -> {
                    try {
                        distManagerCtrl.printDistributionNetworkGraph();
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }
                case 1 -> {
                    try {
                        distManagerCtrl.graphConnection();
                        distManagerCtrl.getMinimumConnectionBetweenPC();
                    } catch (IndexOutOfBoundsException e) {
                        System.out.println("\n\nPlease do option 1 before any other!");
                    }
                }
                case 2 -> distManagerCtrl.getMST();

                case 3 -> {
                    distManagerCtrl.getMST();
                    distManagerCtrl.checkWateringSystem();
                }
                case 4 -> {
                    System.out.println("How many hubs would you like:");
                    int N = read.nextInt();
                    TreeMap<Float, User> result = distManagerCtrl.checkAllCompanyHubs(N);
                    for (Map.Entry<Float, User> entry : result.entrySet()) {
                        System.out.println(entry.getValue() + " | Average Proximity : " + entry.getKey() + " m");
                    }
                }

                case 5 -> {
                    HashMap<User, User> clientHubDist = distManagerCtrl.clientHubDistance();
                    for (Map.Entry<User, User> entry : clientHubDist.entrySet()) {
                    System.out.println("The closest hub to client " + entry.getKey() + " is " + entry.getValue());
                }
                }

                case 6 -> {
                    try {
                        distManagerCtrl.loadBaskets();
                    } catch (FileNotFoundException e) {
                        throw new RuntimeException(e);
                    }
                }

                case 7 -> {
                    System.out.println("Day of the expedition list: ");
                    int day = read.nextInt();
                    ArrayList<Basket> b = (ArrayList<Basket>) distManagerCtrl.generateExpeditionListWithNoRestrictions(day);
                    System.out.println(b);
                }

                case 8 -> {
                    System.out.println("Day of the expedition list: ");
                    int day = read.nextInt();

                    System.out.println("Number of producers: ");
                    int n = read.nextInt();
                    distManagerCtrl.generateExpeditionListWithRestrictions(day,n);
                }

                case 9 -> {
                    System.out.println("Day of the expedition list: ");
                    int day = read.nextInt();
                    distManagerCtrl.minimumPath(day);
                }

                case 10 -> {
                    HashMap<User, User> clientHubDist = distManagerCtrl.clientHubDistance();
                    System.out.println("");

                }
                case 11 -> distManagerCtrl.expeditionCalculations();
                case 12 -> {
                    if (Utils.confirm("Are you sure you want to quit? (Y/N)")) {
                        option = -1;
                    }
                }

            }
        } while (option != -1);
    }
}
