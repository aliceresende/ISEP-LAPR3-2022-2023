package app.ui;

import app.utils.Utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * The type Main.
 */
public class Main {

    /**
     * The entry point of application.
     *
     * @param args the input arguments
     * @throws IOException the io exception
     */
    public static void main(String[] args) throws IOException {

        List<MenuItem> options=new ArrayList<>();
        options.add(new MenuItem("Distribution Manager Features", new DistributionManagerUI()));

        int option = 0;
        do{
            option= Utils.showAndSelectIndex(options, "\n\n#########-Main Menu-############\n\n");
            if((option>=0)&&(option<options.size())){
                options.get(option).run();
                System.out.println("Input -1 to stop the program");
            }
        }while(option!=-1);
    }
}