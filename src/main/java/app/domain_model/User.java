package app.domain_model;

/**
 * The type User.
 */
public class User {
    /**
     * Instantiates a new User.
     *
     * @param idLoc     the id loc
     * @param latitude  the latitude
     * @param longitude the longitude
     */
    public User(String idLoc, double latitude, double longitude) {
        this.idLoc = idLoc;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    private final String idLoc;
    private final double latitude;
    private final double longitude;

    /**
     * Gets id loc.
     *
     * @return the id loc
     */
    public String getIdLoc() {
        return idLoc;
    }

    /**
     * Gets latitude.
     *
     * @return the latitude
     */
    public double getLatitude() {
        return latitude;
    }

    /**
     * Gets longitude.
     *
     * @return the longitude
     */
    public double getLongitude() {
        return longitude;
    }

    public boolean equals(User user){
        if (this.getIdLoc().equals(user.getIdLoc())){
            return true;
        }else {
            return false;
        }
    }
}
