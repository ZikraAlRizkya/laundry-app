/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Zikra.Model;
import java.util.ArrayList;
/**
 *
 * @author Muhammad Zikra
 */
public class Laporan {
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
    private ArrayList<String> city = new ArrayList<>();
    private ArrayList<Integer> totalOrderCity = new ArrayList<>();
    private ArrayList<String> date = new ArrayList<>();
    private ArrayList<Integer> totalOrderDate = new ArrayList<>();
    private ArrayList<String> service = new ArrayList<>();
    private ArrayList<Integer> totalOrderService = new ArrayList<>();
    
    public Laporan(){}
    
    public ArrayList<String> getService() {
        return service;
    }

    public void addService(String newService) {
        service.add(newService);
    }

    public ArrayList<Integer> getTotalOrderService() {
        return totalOrderService;
    }
    public void addTotalOrderService(int newTotalOrder) {
        totalOrderService.add(newTotalOrder);
    }
    
    public ArrayList<String> getDate() {
        return date;
    }

    public void addDate(String newDate) {
        date.add(newDate);
    }

    public ArrayList<Integer> getTotalOrderDate() {
        return totalOrderDate;
    }
    public void addTotalOrderDate(int newTotalOrder) {
        totalOrderDate.add(newTotalOrder);
    }
    
    public ArrayList<String> getCity() {
        return city;
    }

    public void addCity(String newCity) {
        city.add(newCity);
    }

    public ArrayList<Integer> getTotalOrderCity() {
        return totalOrderCity;
    }
    public void addTotalOrderCity(int newTotalOrder) {
        totalOrderCity.add(newTotalOrder);
    }
    
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
}

