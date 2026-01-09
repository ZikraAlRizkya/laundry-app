package Fauzan.Model;

public abstract class BaseEntity implements Identifiable {

    protected int id;

    @Override
    public int getId() {
        return id;
    }

    @Override
    public void setId(int id) {
        this.id = id;
    }
}
