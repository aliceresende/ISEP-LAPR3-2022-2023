package app.service.load;

import app.domain_model.*;
import app.graph.map.DistributionNet;

import java.io.*;
import java.util.Scanner;

/**
 * The type Load.
 */
public class LoadNetDistribution {

    private final DistributionNet distributionNet;

    /**
     * Instantiates a new Load.
     *
     * @param distNet the dist net
     */
    public LoadNetDistribution(DistributionNet distNet) {
        this.distributionNet = distNet;
    }


    /**
     * Load distance.
     *
     * @param filepath the filepath
     * @throws IOException the io exception
     */
    public void loadDistance(String filepath) throws IOException {
        Scanner read = new Scanner(new FileInputStream(filepath));
        read.nextLine(); //header
        while (read.hasNextLine()) {
            String line = read.nextLine();
            String[] splitLine = line.split(",");
            distributionNet.addDistance(splitLine[0],splitLine[1],Long.parseLong(splitLine[2]));
        }
        read.close();
    }

    /**
     * Load user.
     *
     * @param filepath the filepath
     * @throws IOException the io exception
     */
    public void loadUser(String filepath) throws IOException {
        Scanner read = new Scanner(new FileInputStream(filepath));
        read.nextLine(); //header
        while (read.hasNextLine()) {
            String line = read.nextLine();
            String[] splitLine = line.split(",");
            if (splitLine[3].charAt(0)=='C') {
                Client cli = new Client(splitLine[0], Double.parseDouble(splitLine[1]), Double.parseDouble(splitLine[2]),splitLine[3]);
                distributionNet.addUser(cli);

            }else if(splitLine[3].charAt(0)=='E'){
                Company comp = new Company(splitLine[0], Double.parseDouble(splitLine[1]), Double.parseDouble(splitLine[2]),splitLine[3]);
                distributionNet.addUser(comp);

            }else if(splitLine[3].charAt(0)=='P'){
                Producer prod = new Producer(splitLine[0], Double.parseDouble(splitLine[1]), Double.parseDouble(splitLine[2]),splitLine[3]);
                distributionNet.addUser(prod);
            }
        }
        read.close();
    }





}
