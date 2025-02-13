package app.domain_model;


import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * The type Watering system.
 */
public class WateringSystem {
    /**
     * The Hour.
     */
    HashMap<Integer, Integer> hour;
    /**
     * The Sec.
     */
    ArrayList<Sector> sec;


    /**
     * Instantiates a new Watering system.
     */
    public WateringSystem() {
        this.hour = new HashMap<>();
        this.sec = new ArrayList<>();
    }

    /**
     * Add sector.
     *
     * @param info the info
     */
    public void addSector(String[] info){
        this.sec.add(new Sector(info));
    }

    /**
     * Add hour.
     *
     * @param hour the hour
     */
    public void addHour(String[] hour){
        int h=Integer.parseInt(hour[0]);
        int m=Integer.parseInt(hour[1]);
        this.hour.put(h, m);
        h=Integer.parseInt(hour[2]);
        m=Integer.parseInt(hour[3]);
        this.hour.put(h, m);
    }

    @Override
    public String toString() {
        String s="";
        int ho, m;
        for(int h:this.hour.keySet()){
            ho=h;
            m=hour.get(h);
            s = s + " " + ho + ":" + m + "\n";
        }
        s = s + " Sectors: \n" + sec;
        return s;
    }

    /**
     * Check watering string.
     *
     * @return the string
     */
    public String checkWatering(){
        String current_watering= "There is currently no sectors being watered";
       int clock_h= LocalTime.now().getHour();
       Boolean confirm=false;
       int total_duration=0;
       for(int h:this.hour.keySet()){
           int minute=LocalTime.now().getMinute();
           int day=LocalDate.now().getDayOfMonth();
           String even=checkEven(day);
           if (h==clock_h){
               for(Sector s:sec){
                   if(even.equals(s.getRegularidade())){
                       total_duration+=s.getDuration();
                       if(total_duration>minute){
                           current_watering="Sector " + s.getParcela() + " is being watered\n" +
                                   "remaining time: " + (total_duration-minute);
                       }
                   }

               }


           }else{
             return current_watering;
           }
       }
        return current_watering;
    }

    /**
     * Check even string.
     *
     * @param day the day
     * @return the string
     */
    public String checkEven(int day){
        float rest=day%2;
        if (rest==0.0){
            return"p";
        }else{
            return"i";
        }
    }
}
