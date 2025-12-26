/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Zikra.Model;

import java.sql.Date;

public class Edit {

    private int id;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String role;
    private String city;
    private String phoneNumber;
    private Date birthDate;
    private int totalPesananUser;
    private int totalDiprosesUser;
    private int totalSelesaiUser;
    private int totalPesananBaruAdmin;
    private int totalDiterimaAdmin;
    private int totalDiprosesAdmin;
    private int totalSiapDiambilAdmin;
    private int totalPelanggan;
    private int totalPendapatan;
    private int totalPesanan;
    private double rataRataPendapatanPerHari;

    // ===== Constructor =====
    public Edit() {}

    // ===== Getters & Setters =====
    
    public int getTotalPelanggan(){
        return totalPelanggan;
    }
    
    public void setTotalPelanggan(int totalPelanggan){
        this.totalPelanggan = totalPelanggan;
    }
    
    public int getTotalPendapatan(){
        return totalPendapatan;
    }
    
    public void setTotalPendapatan(int totalPendapatan){
        this.totalPendapatan = totalPendapatan;
    }
    
    public int getTotalPesanan(){
        return totalPesanan;
    }
    
    public void setTotalPesanan(int totalPesanan){
        this.totalPesanan = totalPesanan;
    }
    
    public double getRataRataPendapatanPerHari(){
        return rataRataPendapatanPerHari;
    }
    
    public void setRataRataPendapatanPerHari(double rataRataPendapatanPerHari){
        this.rataRataPendapatanPerHari = rataRataPendapatanPerHari;
    }
    
    public int getTotalPesananUser(){
        return totalPesananUser;
    }
    
    public void setTotalPesananUser(int totalPesananUser){
        this.totalPesananUser = totalPesananUser;
    }
    
    public int getTotalDiprosesUser(){
        return totalDiprosesUser;
    }
    
    public void setTotalDiprosesUser(int totalDiprosesUser){
        this.totalDiprosesUser = totalDiprosesUser;
    }
    
    public int getTotalSelesaiUser(){
        return totalSelesaiUser;
    }
    
    public void setTotalSelesaiUser(int totalSelesaiUser){
        this.totalSelesaiUser = totalSelesaiUser;
    }
    
    public int getTotalPesananBaruAdmin(){
        return totalPesananBaruAdmin;
    }
    
    public void setTotalPesananBaruAdmin(int totalPesananBaruAdmin){
        this.totalPesananBaruAdmin = totalPesananBaruAdmin;
    }
    
    public int getTotalDiterimaAdmin(){
        return totalDiterimaAdmin;
    }
    
    public void setTotalDiterimaAdmin(int totalDiterimaAdmin){
        this.totalDiterimaAdmin = totalDiterimaAdmin;
    }
    
    public int getTotalDiprosesAdmin(){
        return totalDiprosesAdmin;
    }
    
    public void setTotalDiprosesAdmin(int totalDiprosesAdmin){
        this.totalDiprosesAdmin = totalDiprosesAdmin;
    }
    
    public int getTotalSiapDiambilAdmin(){
        return totalSiapDiambilAdmin;
    }
    
    public void setTotalSiapDiambilAdmin(int totalSiapDiambilAdmin){
        this.totalSiapDiambilAdmin = totalSiapDiambilAdmin;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    // ⚠️ Only use when needed (never expose in JSP)
    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
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