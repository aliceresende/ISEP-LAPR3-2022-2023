package app.graph.map;

import app.domain_model.Client;
import app.domain_model.User;

import app.graph.map.DistributionNet;
import app.service.load.LoadNetDistribution;
import org.junit.jupiter.api.Test;

import java.io.IOException;

import static app.graph.map.DistributionNet.getVertexByUser;
import static org.junit.jupiter.api.Assertions.*;

class DistributionNetTest {
    private final DistributionNet dNet;
    public DistributionNetTest() throws IOException {
        dNet = new DistributionNet();
        LoadNetDistribution load= new LoadNetDistribution(dNet);
        load.loadUser("src/main/resources/load/Small/clientes-produtores_small.csv");
        load.loadDistance("src/main/resources/load/Small/distancias_small.csv");

    }

    @Test
    void addDistance() {
        User usr1 = new User("CT18",40.6389,-8.6553);
        User usr2 = new User("CT19",39.7444,-8.8072);
        DistributionNet.getDistribution().addEdge(usr1,usr2,12420L);
        dNet.addDistance(usr1.getIdLoc(),usr2.getIdLoc(),12420L);
        Long expected = DistributionNet.getDistribution().edge(usr1,usr2).getWeight();
        assertEquals(expected, 12420L);
    }

    @Test
    void addUser() {
        User actual = new User("CT18",40.6389,-8.6553);
        dNet.addUser(actual);
        User expected = DistributionNet.getDistribution().vertex(17);
        //User CT18 should be the last in the list
        assertEquals(expected, actual);


    }

    @Test
    void getDistribution() {
       int expectedEdges = 66;
       int expectedVert = 17;
       int actualEdges = DistributionNet.getDistribution().numEdges();
       int actualVert = DistributionNet.getDistribution().numVertices();
       assertEquals(expectedEdges, actualEdges);
       assertEquals(expectedVert, actualVert);
    }
    @Test
    void testGetVertexByUser() {

        Client c1 = new Client("CT1",1.0,1.0,"C1");
        Client c2 = new Client("CT2",2.0,2.0,"C2");

        MapGraph<User, Long> graph = new MapGraph<>(false);
        graph.addVertex(c1);
        graph.addVertex(c2);

        User result = DistributionNet.getVertexByUser("C1");

        User expectedResult = c1;

        assertEquals(expectedResult, result);
    }
}