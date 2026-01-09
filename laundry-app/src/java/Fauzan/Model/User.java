package Fauzan.Model;

import java.sql.Date;

public class User extends AbstractUser {
    public User() {
        super();
    }
    
    @Override
    public int getId() {
        return id;
    }
    
    @Override
    public void setId(int id) {
        this.id = id;
    }
    
    @Override
    public String getEmail() {
        return email;
    }
    
    @Override
    public void setEmail(String email) {
        this.email = email;
    }
    
    @Override
    public String getPassword() {
        return password;
    }
    
    @Override
    public void setPassword(String password) {
        this.password = password;
    }
    
    @Override
    public String getRole() {
        return role;
    }
    
    @Override
    public void setRole(String role) {
        this.role = role;
    }
    
    @Override
    public String getFirstName() {
        return profile.getFirstName();
    }
    
    @Override
    public void setFirstName(String firstName) {
        profile.setFirstName(firstName);
    }
    
    @Override
    public String getLastName() {
        return profile.getLastName();
    }
    
    @Override
    public void setLastName(String lastName) {
        profile.setLastName(lastName);
    }
    
    @Override
    public String getCity() {
        return profile.getCity();
    }
    
    @Override
    public void setCity(String city) {
        profile.setCity(city);
    }
    
    @Override
    public String getPhoneNumber() {
        return profile.getPhoneNumber();
    }
    
    @Override
    public void setPhoneNumber(String phoneNumber) {
        profile.setPhoneNumber(phoneNumber);
    }
    
    @Override
    public Date getBirthDate() {
        return profile.getBirthDate();
    }
    
    @Override
    public void setBirthDate(Date birthDate) {
        profile.setBirthDate(birthDate);
    }

    public void setFirstName(String firstName, String lastName) {
        profile.setFirstName(firstName);
        profile.setLastName(lastName);
    }
}