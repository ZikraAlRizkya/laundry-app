package Fauzan.Model;

import java.sql.Date;

//Inheritance dari abstract user
//Encapsulation dari protected dan private variabel dengan method public untuk fetch data
//Abstract harus di implementasi lalu User dipakai sebagai model utama

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
    
    //Exception untuk validasi email untuk contoh
    //karena NOT NULL jadi di set invalid@example.com jika salah
    
    @Override
    public void setEmail(String email) {
        try {
            if (email == null || !email.contains("@")) {
                throw new IllegalArgumentException("Invalid email format");
            }
            this.email = email;
        } catch (IllegalArgumentException e) {
            System.err.println("Error: " + e.getMessage());
            this.email = "invalid@example.com";
        }
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

    //Polymorphism jika butuh input yang langsung set dua variabel
    
    public void setFirstName(String firstName, String lastName) {
        profile.setFirstName(firstName);
        profile.setLastName(lastName);
    }
}
