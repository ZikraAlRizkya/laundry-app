package Fauzan.Controller;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = 
        "jdbc:mysql://localhost:3306/laundry_db";
    private static final String USER = "root";
    private static final String PASS = "";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}

/*
DROP DATABASE IF EXISTS laundry_db;
CREATE DATABASE laundry_db;
USE laundry_db;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    city VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role ENUM('user','admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    layanan VARCHAR(50) NOT NULL,       -- Regular / Ekspres
    jenis_cucian VARCHAR(50) NOT NULL,  -- Pakaian / Selimut / dll
    price DECIMAL(10,2) NOT NULL,
    unit VARCHAR(10) DEFAULT 'kg',
    estimated_time VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    pickup_date TIMESTAMP NULL,
    status ENUM('pending','process','ready to taken','done') DEFAULT 'pending',
    total_price DECIMAL(12,2),

    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
);
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method ENUM('cash','transfer','qris') NOT NULL,
    payment_status ENUM('unpaid','paid','failed') DEFAULT 'unpaid',
    payment_date TIMESTAMP NULL,

    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE
);
CREATE TABLE order_details (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,

    CONSTRAINT fk_detail_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_detail_service
        FOREIGN KEY (service_id) REFERENCES services(service_id)
);
*/

// DATA DUMMY BUAT TEST

/*
-- USERS
INSERT INTO users (first_name, last_name, birth_date, city, email, password, phone, role)
VALUES
('Ahmad', 'Santoso', '1990-05-12', 'Bandung', 'ahmad.santoso@example.com', 'hashed_pw1', '081234567890', 'user'),
('Budi', 'Hartono', '1985-08-20', 'Jakarta', 'budi.hartono@example.com', 'hashed_pw2', '082345678901', 'user'),
('Siti', 'Aisyah', '1992-11-03', 'Surabaya', 'siti.aisyah@example.com', 'hashed_pw3', '083456789012', 'user'),
('Admin', 'Laundry', '1980-01-01', 'Bandung', 'admin@laundry.com', 'hashed_admin', '081111111111', 'admin');

-- SERVICES
INSERT INTO services (layanan, jenis_cucian, price, unit, estimated_time)
VALUES
('Regular', 'Pakaian', 7000.00, 'kg', '2 hari'),
('Ekspres', 'Pakaian', 12000.00, 'kg', '1 hari'),
('Regular', 'Selimut', 15000.00, 'kg', '3 hari'),
('Ekspres', 'Selimut', 25000.00, 'kg', '1 hari');

-- ORDERS
INSERT INTO orders (user_id, order_date, pickup_date, status, total_price)
VALUES
(1, '2025-12-20 10:00:00', '2025-12-22 10:00:00', 'done', 49000.00),   -- Ahmad order 1
(1, '2025-12-23 09:30:00', '2025-12-24 09:30:00', 'process', 24000.00), -- Ahmad order 2
(2, '2025-12-21 14:00:00', '2025-12-23 14:00:00', 'ready to taken', 15000.00), -- Budi order
(3, '2025-12-22 16:00:00', '2025-12-25 16:00:00', 'pending', 25000.00); -- Siti order

-- PAYMENTS
INSERT INTO payments (order_id, payment_method, payment_status, payment_date)
VALUES
(1, 'transfer', 'paid', '2025-12-20 11:00:00'),
(2, 'cash', 'unpaid', NULL),
(3, 'qris', 'paid', '2025-12-21 15:00:00'),
(4, 'transfer', 'unpaid', NULL);

-- ORDER_DETAILS
INSERT INTO order_details (order_id, service_id, quantity, price, subtotal)
VALUES
-- Order 1 (Ahmad)
(1, 1, 3.00, 7000.00, 21000.00),   -- 3kg pakaian regular
(1, 3, 2.00, 15000.00, 30000.00),  -- 2kg selimut regular
-- Order 2 (Ahmad)
(2, 2, 2.00, 12000.00, 24000.00),  -- 2kg pakaian ekspres
-- Order 3 (Budi)
(3, 3, 1.00, 15000.00, 15000.00),  -- 1kg selimut regular
-- Order 4 (Siti)
(4, 4, 1.00, 25000.00, 25000.00);  -- 1kg selimut ekspres
*/