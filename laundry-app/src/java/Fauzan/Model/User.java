package Fauzan.Model;

public class User extends BaseEntity {

    private String email;
    private String password;
    private String role;
    private UserProfile profile;

    public User() {
        this.profile = new UserProfile();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
 
    public void setPassword(String password) {
        this.password = password;
    }
 
    public String getRole() {
        return role;
    }
 
    public void setRole(String role) {
        this.role = role;
    }

    public String getFirstName() {
        return profile.getFirstName();
    }

    public void setFirstName(String firstName) {
        profile.setFirstName(firstName);
    }

    public String getLastName() {
        return profile.getLastName();
    }

    public void setLastName(String lastName) {
        profile.setLastName(lastName);
    }

    public String getCity() {
        return profile.getCity();
    }

    public void setCity(String city) {
        profile.setCity(city);
    }

    public String getPhoneNumber() {
        return profile.getPhoneNumber();
    }

    public void setPhoneNumber(String phoneNumber) {
        profile.setPhoneNumber(phoneNumber);
    }

    public java.sql.Date getBirthDate() {
        return profile.getBirthDate();
    }

    public void setBirthDate(java.sql.Date birthDate) {
        profile.setBirthDate(birthDate);
    }
}
