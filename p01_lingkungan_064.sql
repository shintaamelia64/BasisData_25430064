-- Nama: Shinta Amelia 
-- NIM: 25430064 
-- Modul 1: Lingkungan Kerja (XAMPP & MariaDB) 
 
CREATE DATABASE IF NOT EXISTS praktikum_db_064; 
USE praktikum_db_064; 
 
CREATE TABLE IF NOT EXISTS mahasiswa ( 
    nim VARCHAR(10) PRIMARY KEY, 
    nama VARCHAR(100) 
); 
 
INSERT INTO mahasiswa VALUES ('25430064', 'Shinta Amelia'); 
SELECT * FROM mahasiswa; 
