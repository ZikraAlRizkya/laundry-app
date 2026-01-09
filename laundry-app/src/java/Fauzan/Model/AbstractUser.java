package Fauzan.Model;

import java.sql.Date;

public abstract class AbstractUser implements Identifiable {
    protected int id;
    protected String email;
    protected String password;
    protected String role;
    protected UserProfile profile;
    
    public AbstractUser() {
        this.profile = new UserProfile();
    }
    
    public abstract int getId();
    public abstract void setId(int id);
    public abstract String getEmail();
    public abstract void setEmail(String email);
    public abstract String getPassword();
    public abstract void setPassword(String password);
    public abstract String getRole();
    public abstract void setRole(String role);
    public abstract String getFirstName();
    public abstract void setFirstName(String firstName);
    public abstract String getLastName();
    public abstract void setLastName(String lastName);
    public abstract String getCity();
    public abstract void setCity(String city);
    public abstract String getPhoneNumber();
    public abstract void setPhoneNumber(String phoneNumber);
    public abstract Date getBirthDate();
    public abstract void setBirthDate(Date birthDate);
}
