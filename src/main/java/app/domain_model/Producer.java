package app.domain_model;

/**
 * The type Producer.
 */
public class Producer extends User {
    private final String idClientProducer;

    /**
     * Instantiates a new Producer.
     *
     * @param idLoc            the id loc
     * @param latitude         the latitude
     * @param longitude        the longitude
     * @param idClientProducer the id client producer
     */
    public Producer(String idLoc, double latitude, double longitude, String idClientProducer) {
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
        return idClientProducer ;
    }
}
