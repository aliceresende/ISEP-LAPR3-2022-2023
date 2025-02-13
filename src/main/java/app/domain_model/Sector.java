package app.domain_model;

/**
 * The type Sector.
 */
public class Sector {
    private String parcela;
    private int duration;
    private String regularidade;

    /**
     * Instantiates a new Sector.
     *
     * @param info the info
     */
    public Sector(String[] info) {
        String parcela=info[0];
        int duration=Integer.parseInt(info[1]);
        String regularidade=info[2];
        this.parcela = parcela;
        this.duration = duration;
        this.regularidade = regularidade;
    }

    /**
     * Gets duration.
     *
     * @return the duration
     */
    public int getDuration() {
        return duration;
    }

    /**
     * Gets regularidade.
     *
     * @return the regularidade
     */
    public String getRegularidade() {
        return regularidade;
    }

    /**
     * Gets parcela.
     *
     * @return the parcela
     */
    public String getParcela() {
        return parcela;
    }

    @Override
    public String toString() {
        return  "[ Parcela: " + parcela + '|' +
                " Duração: " + duration +
                "| Regularidade: " + regularidade + " ]"+ "\n";
    }
}
