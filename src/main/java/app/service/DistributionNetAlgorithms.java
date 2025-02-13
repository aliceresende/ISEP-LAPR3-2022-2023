package app.service;

import app.domain_model.Client;
import app.domain_model.Company;
import app.domain_model.Producer;
import app.domain_model.User;
import app.graph.Edge;
import app.graph.Graph;
import app.graph.algorithm.GraphAlgorithms;
import app.graph.matrix.MatrixGraph;

import java.util.*;

public class DistributionNetAlgorithms {

    GraphAlgorithms alg = new GraphAlgorithms();

    public static <V, E> void DepthFirstSearch(Graph<V, E> g, V vOrig, List<V> targets, boolean[] visited, List<V> path) {
        int vKey = g.key(vOrig);
        if (visited[vKey]) return;

        path.add(vOrig);
        visited[vKey] = true;

        if (targets.contains(vOrig)) return;

        for (V vAdj : g.adjVertices(vOrig)) {
            DepthFirstSearch(g, vAdj, targets, visited, path);
        }
    }
    /**
     * Is connected boolean.
     *
     * @param graphDistribution the graph distribution
     * @return the boolean
     */
    public boolean isConnected(Graph<User, Long> graphDistribution) {

        LinkedList<User> qbfs = alg.BreadthFirstSearch(graphDistribution, graphDistribution.vertex(0));

        assert qbfs != null;
        return graphDistribution.numVertices() == qbfs.size();
    }

    /**
     * Gets min connections.
     *
     * @param graphDist the graph dist
     * @return the min connections
     */
    public int getMinConnections(Graph<User, Long> graphDist) {
        int numverts = graphDist.numVertices();
        int max = 0;

        if (isConnected(graphDist)) {
            for (int i = 0; i < numverts; i++) {
                for (int w = i + 1; w < numverts - 1; w++) {
                    int result = shortestPath(i, w, graphDist).size();
                    if (result > max) {
                        max = result;
                    }
                }
            }
        }

        return max - 1;
    }


    /**
     * Reconstruct path list.
     *
     * @param source the source
     * @param dest   the dest
     * @param prev   the prev
     * @return the list
     */
    public List<Integer> reconstructPath(int source, int dest, int[] prev) {
        List<Integer> path = new ArrayList<>();

        for (int i = dest; i != -1; i = prev[i]) {
            path.add(i);
        }
        Collections.reverse(path);
        if (path.get(0) == source) {
            return path;
        }
        return null;
    }

    /**
     * Shortest path list.
     *
     * @param source    the source
     * @param dest      the dest
     * @param graphDist the graph dist
     * @return the list
     */
    public List<Integer> shortestPath(int source, int dest, Graph<User, Long> graphDist) {
        int[] prev;
        prev = solve(source, graphDist);
        return reconstructPath(source, dest, prev);
    }

    /**
     * Solve int [ ].
     *
     * @param source    the source
     * @param graphDist the graph dist
     * @return the int [ ]
     */
    public int[] solve(int source, Graph<User, Long> graphDist) {
        int numeroNodes = graphDist.numVertices();
        Queue<Integer> queue = new LinkedList<>();
        queue.add(source);

        boolean[] visited = new boolean[numeroNodes];
        int[] prev = new int[numeroNodes];

        for (int i = 0; i < numeroNodes; i++) {
            visited[i] = false;
            prev[i] = -1;
        }
        visited[source] = true;

        while (!queue.isEmpty()) {
            int node = queue.remove();
            List<Integer> adjVerts = getAdjVerticesIndex(node, graphDist);
            for (int next : adjVerts) {
                if (!visited[next]) {
                    queue.add(next);
                    visited[next] = true;
                    prev[next] = node;
                }
            }
        }

        return prev;
    }

    /**
     * Gets adj vertices index.
     *
     * @param node      the node
     * @param graphDist the graph dist
     * @return the adj vertices index
     */
    public List<Integer> getAdjVerticesIndex(int node, Graph<User, Long> graphDist) {
        List<Integer> adjUsersList = new ArrayList<>();
        for (int i = 0; i < graphDist.numVertices(); i++) {
            if (graphDist.edge(node, i) != null) {
                adjUsersList.add(i);
            }
        }
        return adjUsersList;
    }


    public Graph<User, Long> kruskall_mst(Graph<User, Long> graph) {

        Graph<User, Long> mst = alg.kruskalAlgorithm(graph);
        return mst;

    }

    /**
     * All company hubs tree map.
     *
     * @param N             the n
     * @param allUsersGraph the all users graph
     * @return the tree map
     */
//-----------------Exercise 3------------------------------------------------
    public TreeMap<Float, User> allCompanyHubs(int N, Graph<User, Long> allUsersGraph) {
        //lista com todos os vertices introduzidos no grafo
        List<User> allUsers = allUsersGraph.vertices();
        //treemap que conterá o valor da proximidade e a empresa com esse valor
        TreeMap<Float, User> companyHubs = new TreeMap<>();
        Long sumOfDistances = 0L;
        LinkedList<User> paths = new LinkedList<>();

        List<User> allClient = new ArrayList<>();
        for (User u : allUsers) {
            if (u instanceof Client || u instanceof Producer) {
                allClient.add(u);
            }
        }

        for (User u : allUsers) {
            if (u instanceof Company) {
                //primeiro for each vai pegar em cada vertice que é empresa e passar para a seguinte condição

                float count = 0;
                //após encontrar um empresa é preciso percorrer a lista para encontrar os produtores e clientes e fazer o claculo da distancia
                for (User u2 : allClient) {

                    //adiciona a variavel a distancia retornada no algoritmo de dijkstra
                    sumOfDistances += GraphAlgorithms.shortestPath(allUsersGraph, u, u2, Long::compare, Long::sum, 0L, paths);
                    //acrementa o numero de produtores e clientes
                    count++;

                }
                if (companyHubs.size() == N) {
                    companyHubs.put((float) sumOfDistances / count, u);
                    companyHubs.remove(companyHubs.lastKey());
                } else {
                    companyHubs.put((float) sumOfDistances / count, u);
                }


            }
        }
        return (companyHubs);
    }
//////////////exercise 4

    /**
     * Nearest hub hash map.
     *
     * @param companyHubs   the company hubs
     * @param allUsersGraph the all users graph
     * @return the hash map
     */
    public HashMap<User, User> nearestHub(TreeMap<Float, User> companyHubs, Graph<User, Long> allUsersGraph) {

        Long lowestDistance;
        ArrayList<User> allUsers = allUsersGraph.vertices();
        LinkedList<User> paths = new LinkedList<>();
        HashMap<User, User> clientsHubs = new HashMap<>();
        User hub;
        ArrayList<User> hubs = new ArrayList<>(companyHubs.values());

        for (User u1 : allUsers) {
            if (!(u1 instanceof Producer)) {
                lowestDistance = GraphAlgorithms.shortestPath(allUsersGraph, u1, hubs.get(0), Long::compare, Long::sum, 0L, paths);
                hub = hubs.get(0);
                for (User u2 : hubs) {
                    if (GraphAlgorithms.shortestPath(allUsersGraph, u1, u2, Long::compare, Long::sum, 0L, paths) < lowestDistance) {
                        lowestDistance = GraphAlgorithms.shortestPath(allUsersGraph, u1, u2, Long::compare, Long::sum, 0L, paths);
                        hub = u2;
                    }
                }
                clientsHubs.put(u1, hub);
            }
        }
        return clientsHubs;
    }


    public TreeMap<Float, User> getHubs(MatrixGraph<User, Long> shortPath, int n){ // return List<List<User>> paths
        ArrayList<User> numverts = shortPath.vertices();
        Edge<User, Long> e;
        Long sumOfDistances = 0L;
        float count=0;
        TreeMap<Float,User> hubs = new TreeMap<>();
        for(int i=0; i<numverts.size(); i++){
            if(numverts.get(i) instanceof Company){
                for (int j=0; j<numverts.size();j++){
                    if(numverts.get(j) instanceof Client || numverts.get(j) instanceof Producer){
                        e=shortPath.edge(i, j);
                            sumOfDistances += e.getWeight();
                            count++;

                    }
                }

                if (hubs.size() == n) {
                    hubs.put((float) sumOfDistances / count, numverts.get(i));
                    hubs.remove(hubs.lastKey());
                } else {
                    hubs.put((float) sumOfDistances / count, numverts.get(i));
                }
                count=0f;
                sumOfDistances=0L;
            }
        }
        return hubs;
    }


}
