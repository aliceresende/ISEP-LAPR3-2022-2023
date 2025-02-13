package app.ui;

import app.utils.Utils;

/**
 * The type Menu item.
 */
public class MenuItem{
    private String description;
    private Runnable ui;

    /**
     * Instantiates a new Menu item.
     *
     * @param description the description
     * @param ui          the ui
     */
    public MenuItem(String description, Runnable ui) {
        if(description.length()==0)
        throw new IllegalArgumentException("MenuItem description cannot be null or empty.");
        if(Utils.isNull(ui))
            throw new IllegalArgumentException("MenuItem does not support a null UI.");
        this.description = description;
        this.ui = ui;
    }

    /**
     * Run.
     */
    public void run(){
        this.ui.run();
    }

    /**
     * Has description boolean.
     *
     * @param description the description
     * @return the boolean
     */
    public boolean hasDescription(String description)
    {
        return this.description.equals(description);
    }
    @Override
    public String toString() {
        return this.description;
    }
}
