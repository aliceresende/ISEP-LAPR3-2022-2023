package app.graph.algoritms;

import app.domain_model.Company;

import app.domain_model.User;
import app.graph.Graph;
import app.graph.algorithm.GraphAlgorithms;
import app.service.DistributionNetAlgorithms;
import app.service.load.LoadNetDistribution;
import app.graph.map.DistributionNet;

import app.graph.map.MapGraph;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

class GraphAlgorithmsTest {

    final Graph<String, Integer> completeMap = new MapGraph<>(false);
    Graph<String, Integer> incompleteMap = new MapGraph<>(false);


    @BeforeEach
    public void setUp() {

        completeMap.addVertex("Porto");
        completeMap.addVertex("Braga");
        completeMap.addVertex("Vila Real");
        completeMap.addVertex("Aveiro");
        completeMap.addVertex("Coimbra");
        completeMap.addVertex("Leiria");

        completeMap.addVertex("Viseu");
        completeMap.addVertex("Guarda");
        completeMap.addVertex("Castelo Branco");
        completeMap.addVertex("Lisboa");
        completeMap.addVertex("Faro");

        completeMap.addEdge("Porto", "Aveiro", 75);
        completeMap.addEdge("Porto", "Braga", 60);
        completeMap.addEdge("Porto", "Vila Real", 100);
        completeMap.addEdge("Viseu", "Guarda", 75);
        completeMap.addEdge("Guarda", "Castelo Branco", 100);
        completeMap.addEdge("Aveiro", "Coimbra", 60);
        completeMap.addEdge("Coimbra", "Lisboa", 200);
        completeMap.addEdge("Coimbra", "Leiria", 80);
        completeMap.addEdge("Aveiro", "Leiria", 120);
        completeMap.addEdge("Leiria", "Lisboa", 150);

        incompleteMap = completeMap.clone();

        completeMap.addEdge("Aveiro", "Viseu", 85);
        completeMap.addEdge("Leiria", "Castelo Branco", 170);
        completeMap.addEdge("Lisboa", "Faro", 280);
    }

    public GraphAlgorithmsTest() throws IOException {

    }

    private void checkContentEquals(List<String> l1, List<String> l2, String msg) {
        Collections.sort(l1);
        Collections.sort(l2);
        assertEquals(l1, l2, msg);
    }


    /**
     * Test of BreadthFirstSearch method, of class Algorithms.
     */
    @Test
    public void testBreadthFirstSearch() {
        System.out.println("Test BreadthFirstSearch");

        Assertions.assertNull(GraphAlgorithms.BreadthFirstSearch(completeMap, "LX"), "Should be null if vertex does not exist");

        LinkedList<String> path = GraphAlgorithms.BreadthFirstSearch(incompleteMap, "Faro");

        assertEquals(1, path.size(), "Should be just one");

        assertEquals("Faro", path.peekFirst());

        path = GraphAlgorithms.BreadthFirstSearch(incompleteMap, "Porto");
        assertEquals(7, path.size(), "Should give seven vertices");

        assertEquals("Porto", path.removeFirst(), "BreathFirst Porto");

        LinkedList<String> expected = new LinkedList<>(Arrays.asList("Aveiro", "Braga", "Vila Real"));
        checkContentEquals(expected, path.subList(0, 3), "BreathFirst Porto");

        expected = new LinkedList<>(Arrays.asList("Coimbra", "Leiria"));
        checkContentEquals(expected, path.subList(3, 5), "BreathFirst Porto");

        expected = new LinkedList<>(Arrays.asList("Lisboa"));
        checkContentEquals(expected, path.subList(5, 6), "BreathFirst Porto");

        path = GraphAlgorithms.BreadthFirstSearch(incompleteMap, "Viseu");
        expected = new LinkedList<>(Arrays.asList("Viseu", "Guarda", "Castelo Branco"));
        assertEquals(expected, path, "BreathFirst Viseu");
    }

    /**
     * Test of DepthFirstSearch method, of class Algorithms.
     */
    @Test
    public void testDepthFirstSearch() {
        System.out.println("Test of DepthFirstSearch");

        assertNull(GraphAlgorithms.DepthFirstSearch(completeMap, "LX"), "Should be null if vertex does not exist");

        LinkedList<String> path = GraphAlgorithms.DepthFirstSearch(incompleteMap, "Faro");
        assertEquals(1, path.size(), "Should be just one");

        assertEquals("Faro", path.peekFirst());

        path = GraphAlgorithms.BreadthFirstSearch(incompleteMap, "Porto");
        assertEquals(7, path.size(), "Should give seven vertices");

        assertEquals("Porto", path.removeFirst(), "DepthFirst Porto");
        assertTrue(new LinkedList<>(Arrays.asList("Aveiro", "Braga", "Vila Real")).contains(path.removeFirst()), "DepthFirst Porto");

        path = GraphAlgorithms.BreadthFirstSearch(incompleteMap, "Viseu");
        List<String> expected = new LinkedList<>(Arrays.asList("Viseu", "Guarda", "Castelo Branco"));
        assertEquals(expected, path, "DepthFirst Viseu");
    }

    /**
     * Test of shortestPath method, of class Algorithms.
     */
    @Test
    public void testShortestPath() {
        System.out.println("Test of shortest path");

        LinkedList<String> shortPath = new LinkedList<>();

        Integer lenPath = GraphAlgorithms.shortestPath(completeMap, "Porto", "LX", Integer::compare, Integer::sum, 0, shortPath);
        assertNull(lenPath, "Length path should be null if vertex does not exist");
        assertEquals(0, shortPath.size(), "Shortest Path does not exist");

        lenPath = GraphAlgorithms.shortestPath(incompleteMap, "Porto", "Faro", Integer::compare, Integer::sum, 0, shortPath);
        assertNull(lenPath, "Length path should be null if vertex does not exist");
        assertEquals(0, shortPath.size(), "Shortest Path does not exist");

        lenPath = GraphAlgorithms.shortestPath(completeMap, "Porto", "Porto", Integer::compare, Integer::sum, 0, shortPath);
        assertEquals(0, lenPath, "Length path should be 0 if vertices are the same");
        assertEquals(Arrays.asList("Porto"), shortPath, "Shortest Path only contains Porto");

        lenPath = GraphAlgorithms.shortestPath(incompleteMap, "Porto", "Lisboa", Integer::compare, Integer::sum, 0, shortPath);
        assertEquals(335, lenPath, "Length path should be 0 if vertices are the same");
        assertEquals(Arrays.asList("Porto", "Aveiro", "Coimbra", "Lisboa"), shortPath, "Shortest Path Porto - Lisboa");

        lenPath = GraphAlgorithms.shortestPath(incompleteMap, "Braga", "Leiria", Integer::compare, Integer::sum, 0, shortPath);
        assertEquals(255, lenPath, "Length path should be 0 if vertices are the same");
        assertEquals(Arrays.asList("Braga", "Porto", "Aveiro", "Leiria"), shortPath, "Shortest Path Braga - Leiria");

        lenPath = GraphAlgorithms.shortestPath(completeMap, "Porto", "Castelo Branco", Integer::compare, Integer::sum, 0, shortPath);
        assertEquals(335, lenPath, "Length path should be 0 if vertices are the same");
        assertEquals(Arrays.asList("Porto", "Aveiro", "Viseu", "Guarda", "Castelo Branco"), shortPath, "Shortest Path Porto - Castelo Branco");

        //Changing Edge: Aveiro-Viseu with Edge: Leiria-C.Branco
        //should change shortest path between Porto and Castelo Branco

        completeMap.removeEdge("Aveiro", "Viseu");
        completeMap.addEdge("Leiria", "Castelo Branco", 170);

        lenPath = GraphAlgorithms.shortestPath(completeMap, "Porto", "Castelo Branco", Integer::compare, Integer::sum, 0, shortPath);
        assertEquals(365, lenPath, "Length path should be 0 if vertices are the same");
        assertEquals(Arrays.asList("Porto", "Aveiro", "Leiria", "Castelo Branco"), shortPath, "Shortest Path Porto - Castelo Branco");
    }

    /**
     * Test of shortestPaths method, of class Algorithms.
     */
    @Test
    public void testShortestPaths() {
        System.out.println("Test of shortest path");

        ArrayList<LinkedList<String>> paths = new ArrayList<>();
        ArrayList<Integer> dists = new ArrayList<>();

        GraphAlgorithms.shortestPaths(completeMap, "Porto", Integer::compare, Integer::sum, 0, paths, dists);

        assertEquals(paths.size(), dists.size(), "There should be as many paths as sizes");
        assertEquals(completeMap.numVertices(), paths.size(), "There should be a path to every vertex");
        assertEquals(Arrays.asList("Porto"), paths.get(completeMap.key("Porto")), "Number of nodes should be 1 if source and vertex are the same");
        assertEquals(Arrays.asList("Porto", "Aveiro", "Coimbra", "Lisboa"), paths.get(completeMap.key("Lisboa")), "Path to Lisbon");
        assertEquals(Arrays.asList("Porto", "Aveiro", "Viseu", "Guarda", "Castelo Branco"), paths.get(completeMap.key("Castelo Branco")), "Path to Castelo Branco");
        assertEquals(335, dists.get(completeMap.key("Castelo Branco")), "Path between Porto and Castelo Branco should be 335 Km");

        //Changing Edge: Aveiro-Viseu with Edge: Leiria-C.Branco
        //should change shortest path between Porto and Castelo Branco
        completeMap.removeEdge("Aveiro", "Viseu");
        completeMap.addEdge("Leiria", "Castelo Branco", 170);
        GraphAlgorithms.shortestPaths(completeMap, "Porto", Integer::compare, Integer::sum, 0, paths, dists);
        assertEquals(365, dists.get(completeMap.key("Castelo Branco")), "Path between Porto and Castelo Branco should now be 365 Km");
        assertEquals(Arrays.asList("Porto", "Aveiro", "Leiria", "Castelo Branco"), paths.get(completeMap.key("Castelo Branco")), "Path to Castelo Branco");

        GraphAlgorithms.shortestPaths(incompleteMap, "Porto", Integer::compare, Integer::sum, 0, paths, dists);
        assertNull(dists.get(completeMap.key("Faro")), "Length path should be null if there is no path");
        assertEquals(335, dists.get(completeMap.key("Lisboa")), "Path between Porto and Lisboa should be 335 Km");
        assertEquals(Arrays.asList("Porto", "Aveiro", "Coimbra", "Lisboa"), paths.get(completeMap.key("Lisboa")), "Path to Lisboa");

        GraphAlgorithms.shortestPaths(incompleteMap, "Braga", Integer::compare, Integer::sum, 0, paths, dists);
        assertEquals(255, dists.get(completeMap.key("Leiria")), "Path between Braga and Leiria should be 255 Km");
        assertEquals(Arrays.asList("Braga", "Porto", "Aveiro", "Leiria"), paths.get(completeMap.key("Leiria")), "Path to Leiria");
    }

    /**
     * Test minimum distance graph using Floyd-Warshall.
     */
    @Test
    public void testminDistGraph() {
        int[] ExpectedDistance = {
                60, 100, 75, 135, 195, 160, 235, 335, 335, 615,
                60, 160, 135, 195, 255, 220, 295, 395, 395, 675,
                100, 160, 175, 235, 295, 260, 335, 435, 435, 715,
                75, 135, 175, 60, 120, 85, 160, 260, 260, 540,
                135, 195, 235, 60, 80, 145, 220, 250, 200, 480,
                195, 255, 295, 120, 80, 205, 270, 170, 150, 430,
                160, 220, 260, 85, 145, 205, 75, 175, 345, 625,
                235, 295, 335, 160, 220, 270, 75, 100, 420, 700,
                335, 395, 435, 260, 250, 170, 175, 100, 320, 600,
                335, 395, 435, 260, 200, 150, 345, 420, 320, 280,
                615, 675, 715, 540, 480, 430, 625, 700, 600, 280};

        Graph<String, Integer> minDist = GraphAlgorithms.minDistGraph(completeMap, Integer::compare, Integer::sum);

        int k = 0;
        for (int i = 0; i < completeMap.numVertices(); i++) {
            for (int j = 0; j < completeMap.numVertices(); j++) {
                if (j != i)
                    assertEquals(ExpectedDistance[k++], minDist.edge(i, j).getWeight());
            }
        }
    }

    // ------------------------------------------------------------------
}