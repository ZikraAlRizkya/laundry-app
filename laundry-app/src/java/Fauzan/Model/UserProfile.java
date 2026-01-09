package Fauzan.Model;

import java.sql.Date;

//data pribadi menggunakan private
//Composition Relations dari User HAS-A UserProfile dan User inisiasi nya di AbstractUser.java
//Composition karena UserProfile ikut terhapus jika User terhapus

public class UserProfile {
    private String firstName;
    private String lastName;
    private String city;
    private String phoneNumber;
    private Date birthDate;
    
    public UserProfile() {}
    
    public String getFirstName() {
        return firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String getCity() {
        return city;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
    
    public String getPhoneNumber() {
        return phoneNumber;
    }
    
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    
    public Date getBirthDate() {
        return birthDate;
    }
    
    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }
}
