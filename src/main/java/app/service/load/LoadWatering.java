package app.service.load;

import app.domain_model.WateringSystem;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Scanner;

/**
 * The type Watering.
 */
public class LoadWatering {
    /**
     * The Sys.
     */
    WateringSystem sys=new WateringSystem();

    /**
     * Instantiates a new Watering.
     */
    public LoadWatering() {
    }

    /**
     * Load watering.
     *
     * @param sys the sys
     */
    public void LoadWatering(WateringSystem sys){
        String file="src/main/resources/load/Rega/SistemaRega.csv";
        Scanner read;
        try{
            read=new Scanner(new FileInputStream(file));
        }catch (FileNotFoundException e){
            throw new RuntimeException(e);
        }
        String hour=read.nextLine();
        hour=hour.replace(",", "|");
        hour=hour.replace(":", "|");
        String[] h=hour.split("\\|");
        sys.addHour(h);
        while(read.hasNextLine()){
            String line=read.nextLine();
            line=line.replace(",", "|");
            String[] info=line.split("\\|");
            sys.addSector(info);
        }

    }
}
