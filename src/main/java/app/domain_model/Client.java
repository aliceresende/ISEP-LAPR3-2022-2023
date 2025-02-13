package app.domain_model;

import java.util.Objects;

/**
 * The type Client.
 */
public class Client extends User {
    private final String idClientProducer;

    /**
     * Instantiates a new Client.
     *
     * @param idLoc            the id loc
     * @param latitude         the latitude
     * @param longitude        the longitude
     * @param idClientProducer the id client producer
     */
    public Client(String idLoc, double latitude, double longitude, String idClientProducer) {
        super(idLoc, latitude, longitude);
        this.idClientProducer = idClientProducer;
    }

    /**
     * Gets id client producer.
     *
     * @return the id client producer
     */
    public String getIdClientProducer() {
        return idClientProducer;
    }

    @Override
    public String toString() {
        return "Client id = "+idClientProducer;
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Client client = (Client) o;
        return Objects.equals(idClientProducer, client.idClientProducer);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idClientProducer);
    }
}
