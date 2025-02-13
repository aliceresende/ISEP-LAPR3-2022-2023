package app.graph.map;

import app.domain_model.Client;
import app.domain_model.Company;
import app.domain_model.Producer;
import app.domain_model.User;
import app.graph.Graph;

import java.util.ArrayList;


/**
 * The type Distribution net.
 */
public class DistributionNet {

    private static Graph<User, Long> distribution;

    /**
     * Instantiates a new Distribution net.
     */
    public DistributionNet() {
        distribution = new MapGraph<>(false);
    }

    /**
     * Add distance.
     *
     * @param v1       the v 1
     * @param v2       the v 2
     * @param distance the distance
     */
    public void addDistance(String v1, String v2, long distance) {
        User s1 = distribution.vertex(v -> v.getIdLoc().equals(v1));
        User s2 = distribution.vertex(v -> v.getIdLoc().equals(v2));
        distribution.addEdge(s1, s2, distance);
    }

    /**
     * Add user.
     *
     * @param soc the soc
     */
    public void addUser(User soc) {
        distribution.addVertex(soc);
    }

    /**
     * Gets distribution.
     *
     * @return the distribution
     */
    public static Graph<User, Long> getDistribution() {
        return distribution;
    }

    public static User getVertexByUser(String idUser) {
        for (User v : getDistribution().vertices()) {
            if (v instanceof Producer) {
                if (((Producer) v).getIdClientProducer().equals(idUser)) {
                    return v;
                }
            }
            if (v instanceof Client){
                if (((Client) v).getIdClientProducer().equals(idUser)) {
                    return v;
                }
            }
            if (v instanceof Company){
                if (((Company) v).getIdClientProducer().equals(idUser)) {
                    return v;
                }
            }
        }
        return null;
    }
    public ArrayList<User> getProducerList(){
        ArrayList<User> allUsers = new ArrayList<>(distribution.vertices());
        ArrayList<User> allProducers = new ArrayList<>();
        for (User user : allUsers){
            if (user instanceof Producer){
                allProducers.add(user);
            }
        }
        return allProducers;
    }

  }