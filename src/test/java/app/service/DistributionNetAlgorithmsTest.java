package app.service;

import app.domain_model.Company;
import app.domain_model.User;
import app.graph.Graph;
import app.graph.algorithm.GraphAlgorithms;
import app.graph.map.DistributionNet;
import app.service.load.LoadNetDistribution;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

class DistributionNetAlgorithmsTest {
    private final DistributionNet dNet;
    private final GraphAlgorithms alg;

    private final DistributionNetAlgorithms netAlg;

    public DistributionNetAlgorithmsTest() throws IOException {
        dNet = new DistributionNet();
        LoadNetDistribution load= new LoadNetDistribution(dNet);
        load.loadUser("src/main/resources/load/Small/clientes-produtores_small.csv");
        load.loadDistance("src/main/resources/load/Small/distancias_small.csv");
        alg =new GraphAlgorithms();
        netAlg=new DistributionNetAlgorithms();
    }
    @Test
    void isConnected() {
        boolean actual = netAlg.isConnected(DistributionNet.getDistribution());
        boolean expected = true;
        assertEquals(expected,actual);
    }

    @Test
    void minConnections() {
        int actual = netAlg.getMinConnections(DistributionNet.getDistribution());
        int expected = 6;
        assertEquals(expected, actual);
    }

    @Test
    void reconstructPath() {
        int[] prev = new int[3];
        prev[0] = 1;
        prev[1] = -1;
        List<Integer> actual = netAlg.reconstructPath(1, 0, prev);
        List<Integer> expected = new ArrayList<>();
        expected.add(1);
        expected.add(0);


        assertTrue( expected.size() == 2);
        assertEquals(expected, actual);
    }

    @Test
    void solve() {
        int[] actual = netAlg.solve(0,dNet.getDistribution());
        int[] expected = new int[17];
        expected[0] = -1;
        expected[1] = 10;
        expected[2] = 5;
        expected[3] = 5;
        expected[4] = 5;
        expected[5] = 0;
        expected[6] = 8;
        expected[7] = 9;
        expected[8] = 16;
        expected[9] = 8;
        expected[10] = 16;
        expected[11] = 14;
        expected[12] = 14;
        expected[13] = 2;
        expected[14] = 0;
        expected[15] = 0;
        expected[16] = 0;


        assertArrayEquals(expected, actual);

    }

    @Test
    void getAdjVerticesIndex() {
        List<Integer> actual = netAlg.getAdjVerticesIndex(4, DistributionNet.getDistribution());
        List<Integer> expected = new ArrayList<>();

        expected.add(2);
        expected.add(5);
        expected.add(12);
        expected.add(13);
        expected.add(14);

        assertEquals(expected, actual);
    }
    LoadNetDistribution read;

    @Test
    public void testeKruskal_mst(){
        DistributionNet mst = new DistributionNet();
        read = new LoadNetDistribution(mst);

        try {
            read.loadUser("src/main/resources/load/Small/clientes-produtores_small.csv");
            read.loadDistance("src/main/resources/load/Small/expected_mst_distance.csv");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }


        Graph<User,Long> result = netAlg.kruskall_mst(DistributionNet.getDistribution());

        // number of vertexs
        assertEquals(DistributionNet.getDistribution().numVertices(),result.numVertices());
        // number of edges
        assertEquals(DistributionNet.getDistribution().numEdges(),result.numEdges());
        // testing some edges
        assertEquals(DistributionNet.getDistribution().edge(0,1),result.edge(0,1));
        assertEquals(DistributionNet.getDistribution().edge(5,8),result.edge(5,8));
        assertEquals(DistributionNet.getDistribution().edge(10,15),result.edge(10,15));

    }

    @Test
    public void testAllCompanyHubs() {

        TreeMap<Float,User> map = netAlg.allCompanyHubs(5, DistributionNet.getDistribution());
        TreeMap<Float,User> expectedMap = new TreeMap<>();

        List<User> allUsers = DistributionNet.getDistribution().vertices();

        List<Float> averagePathValues = new ArrayList<>();
        averagePathValues.add(243125.33F);
        averagePathValues.add(469430.25F);
        averagePathValues.add(678619.0F);
        averagePathValues.add(897061.06F);
        averagePathValues.add(1204249.1F);

        int i = 0;

        for(User u:allUsers) {
            if (u instanceof Company) {
                expectedMap.put(averagePathValues.get(i), u);
                i++;
            }
        }
        assertEquals(expectedMap.keySet(),map.keySet());
    }
    @Test
    public void testNearestHub(){
        TreeMap<Float,User> map = netAlg.allCompanyHubs(3, DistributionNet.getDistribution());
        HashMap<User,User> clientHub = netAlg.nearestHub(map, DistributionNet.getDistribution());
        ArrayList<User> actualUser = new ArrayList<>(clientHub.values());
        ArrayList<String> actual = new ArrayList<>();
        for (User u:actualUser){
            actual.add(u.getIdLoc());
        }
        ArrayList<String> expected = new ArrayList<>();
        expected.add("CT5");
        expected.add("CT14");
        expected.add("CT5");
        expected.add("CT5");
        expected.add("CT14");
        expected.add("CT14");
        expected.add("CT14");
        expected.add("CT11");
        expected.add("CT5");
        expected.add("CT5");
        expected.add("CT5");
        expected.add("CT5");
        expected.add("CT5");
        expected.add("CT14");
        assertEquals(expected,actual);
    }
}