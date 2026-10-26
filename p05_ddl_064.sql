-- ============================================================
-- Berkas      : p05_ddl_064.sql
-- Modul       : Modul 5 - DDL dan Constraint (Toko Daring Shinta)
-- NPM         : 25430064
-- Nama        : Shinta Amelia
-- Deskripsi   : Skrip DDL pemodelan fisik basis data Toko Daring (toko_064)
-- ============================================================

-- 1. Membuat dan menggunakan basis data proyek
CREATE DATABASE IF NOT EXISTS toko_064
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE toko_064;

-- ============================================================
-- 2. Menghapus tabel jika sudah ada (urutan: Anak -> Induk)
-- ============================================================
DROP TABLE IF EXISTS pengiriman;
DROP TABLE IF EXISTS pembayaran;
DROP TABLE IF EXISTS detail_pesanan;
DROP TABLE IF EXISTS pesanan;
DROP TABLE IF EXISTS transaksi;
DROP TABLE IF EXISTS produk;
DROP TABLE IF EXISTS kategori;
DROP TABLE IF EXISTS pelanggan;

-- ============================================================
-- 3. Membuat Tabel Master (Induk)
-- ============================================================

-- Tabel: pelanggan
CREATE TABLE pelanggan (
  id_pelanggan INT NOT NULL AUTO_INCREMENT,
  no_pelanggan CHAR(8) NOT NULL,
  nama_pelanggan VARCHAR(100) NOT NULL,
  email_pelanggan VARCHAR(100) NOT NULL,
  telepon_pelanggan VARCHAR(15) NULL,
  alamat_pelanggan TEXT NULL,
  tgl_daftar DATE NOT NULL,
  PRIMARY KEY (id_pelanggan),
  UNIQUE KEY uq_pelanggan_no (no_pelanggan),
  UNIQUE KEY uq_pelanggan_email (email_pelanggan)
) ENGINE=InnoDB;

-- Tabel: kategori
CREATE TABLE kategori (
  id_kategori INT NOT NULL AUTO_INCREMENT,
  nama_kategori VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_kategori),
  UNIQUE KEY uq_kategori_nama (nama_kategori)
) ENGINE=InnoDB;

-- Tabel: produk
CREATE TABLE produk (
  id_produk INT NOT NULL AUTO_INCREMENT,
  kode_produk VARCHAR(15) NOT NULL,
  nama_produk VARCHAR(100) NOT NULL,
  id_kategori INT NOT NULL,
  harga_jual DECIMAL(12,2) NOT NULL,
  stok_produk INT NOT NULL DEFAULT 0,
  stok_min_produk INT NOT NULL DEFAULT 5,
  PRIMARY KEY (id_produk),
  UNIQUE KEY uq_produk_kode (kode_produk),
  CONSTRAINT fk_produk_kategori FOREIGN KEY (id_kategori) REFERENCES kategori (id_kategori),
  CONSTRAINT ck_produk_harga CHECK (harga_jual >= 0),
  CONSTRAINT ck_produk_stok CHECK (stok_produk >= 0)
) ENGINE=InnoDB;

-- ============================================================
-- 4. Membuat Tabel Transaksi dan Pendukungnya
-- ============================================================

-- Tabel: transaksi (Kepala Transaksi Umum)
CREATE TABLE transaksi (
  id_transaksi INT NOT NULL AUTO_INCREMENT,
  no_transaksi CHAR(14) NOT NULL,
  tgl_transaksi DATETIME NOT NULL,
  id_pelanggan INT NOT NULL,
  total_transaksi DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (id_transaksi),
  UNIQUE KEY uq_transaksi_no (no_transaksi),
  CONSTRAINT fk_transaksi_pelanggan FOREIGN KEY (id_pelanggan) REFERENCES pelanggan (id_pelanggan)
) ENGINE=InnoDB;

-- Tabel: pesanan
CREATE TABLE pesanan (
  id_pesanan INT NOT NULL AUTO_INCREMENT,
  id_transaksi INT NOT NULL,
  status_pesanan ENUM('pending', 'dibayar', 'dikirim', 'selesai', 'batal') NOT NULL DEFAULT 'pending',
  catatan_pesanan TEXT NULL,
  PRIMARY KEY (id_pesanan),
  CONSTRAINT fk_pesanan_transaksi FOREIGN KEY (id_transaksi) REFERENCES transaksi (id_transaksi) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabel: detail_pesanan (Entitas Asosiatif untuk rincian produk dalam pesanan)
CREATE TABLE detail_pesanan (
  id_pesanan INT NOT NULL,
  id_produk INT NOT NULL,
  qty_pesanan INT NOT NULL,
  harga_satuan DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (id_pesanan, id_produk),
  CONSTRAINT fk_detail_pesanan FOREIGN KEY (id_pesanan) REFERENCES pesanan (id_pesanan) ON DELETE CASCADE,
  CONSTRAINT fk_detail_produk FOREIGN KEY (id_produk) REFERENCES produk (id_produk),
  CONSTRAINT ck_detail_qty CHECK (qty_pesanan > 0)
) ENGINE=InnoDB;

-- Tabel: pembayaran
CREATE TABLE pembayaran (
  id_pembayaran INT NOT NULL AUTO_INCREMENT,
  id_pesanan INT NOT NULL,
  tgl_pembayaran DATETIME NOT NULL,
  metode_pembayaran VARCHAR(50) NOT NULL,
  jumlah_bayar DECIMAL(12,2) NOT NULL,
  status_pembayaran ENUM('sukses', 'gagal', 'pending') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (id_pembayaran),
  CONSTRAINT fk_pembayaran_pesanan FOREIGN KEY (id_pesanan) REFERENCES pesanan (id_pesanan) ON DELETE CASCADE,
  CONSTRAINT ck_jumlah_bayar CHECK (jumlah_bayar >= 0)
) ENGINE=InnoDB;

-- Tabel: pengiriman
CREATE TABLE pengiriman (
  id_pengiriman INT NOT NULL AUTO_INCREMENT,
  id_pesanan INT NOT NULL,
  no_resi VARCHAR(50) NULL,
  kurir VARCHAR(50) NOT NULL,
  biaya_ongkir DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  status_pengiriman ENUM('proses', 'dikirim', 'diterima') NOT NULL DEFAULT 'proses',
  PRIMARY KEY (id_pengiriman),
  CONSTRAINT fk_pengiriman_pesanan FOREIGN KEY (id_pesanan) REFERENCES pesanan (id_pesanan) ON DELETE CASCADE
) ENGINE=InnoDB;