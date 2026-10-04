-- Nama: Shinta Amelia
-- NIM: 25430064
-- Tema: Toko Elektronik dan Aksesoris Komputer

CREATE DATABASE IF NOT EXISTS toko_elektronik_064;
USE toko_elektronik_064;

CREATE TABLE IF NOT EXISTS pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    no_telepon VARCHAR(15) NOT NULL,
    alamat TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(150) NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    stok INT NOT NULL
);

INSERT INTO produk (nama_produk, harga, stok) VALUES ('SSD Eksternal 512GB', 750000.00, 15);
SELECT * FROM produk;
