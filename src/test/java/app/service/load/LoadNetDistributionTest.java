package app.service.load;

import app.service.load.LoadNetDistribution;
import app.graph.map.DistributionNet;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.assertEquals;

class LoadNetDistributionTest {

    private LoadNetDistribution load;
    private DistributionNet distributionNet;

    @BeforeEach
    void setUp() {
        distributionNet = new DistributionNet();
        load = new LoadNetDistribution(distributionNet);
    }

    @Test
    void loadUser() {
        try {
            load.loadUser("src/main/resources/load/Small/clientes-produtores_small.csv");
        } catch (IOException e) {
            e.printStackTrace();
        }
        assertEquals(17, distributionNet.getDistribution().numVertices());
    }

    @Test
    void loadDistance() {
        try {
            load.loadUser("src/main/resources/load/Small/clientes-produtores_small.csv");
            load.loadDistance("src/main/resources/load/Small/distancias_small.csv");
        } catch (IOException e) {
            e.printStackTrace();
        }
        assertEquals(66, distributionNet.getDistribution().numEdges());
    }
}