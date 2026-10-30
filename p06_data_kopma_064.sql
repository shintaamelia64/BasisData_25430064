-- =====================================================================
-- Nama      : Shinta Amelia
-- NPM       : 25430064
-- Topik     : Modul 6 - DML dan Pengujian Basis Data Koperasi (Kopma)
-- File      : p06_data_kopma_064.sql
-- =====================================================================

USE kopma_064;

-- ---------------------------------------------------------------------
-- A. PENGISIAN DATA INDUK (MASTER)
-- ---------------------------------------------------------------------

-- 1. Tabel Petugas (Kasir, Gudang, Ketua)
INSERT INTO petugas (kode_petugas, nama_petugas, peran_petugas) VALUES
('K01', 'Dimas Prasetyo', 'kasir'),
('K02', 'Sari Indah', 'kasir'),
('K03', 'Rina Wulandari', 'kasir'),
('G01', 'Joko Susilo', 'gudang'),
('P01', 'Ketua Kopma', 'ketua');

-- 2. Tabel Anggota (Mahasiswa terdaftar - Baris pertama disesuaikan dengan data Shinta Amelia)
INSERT INTO anggota (no_anggota, nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota, jumlah_poin) VALUES
('A-0457', '25430064', 'Shinta Amelia', 'Ilmu Komputer', '081234567801', 'aktif', '2026-08-15', 50),
('A-0458', '25430002', 'Citra Amalia', 'Sistem Informasi', '081234567802', 'aktif', '2026-08-16', 5),
('A-0459', '25430003', 'Doni Kurniawan', 'Teknik Informatika', NULL, 'nonaktif', '2024-01-10', 0),
('A-0460', '25430004', 'Eko Wijaya', 'Ilmu Komputer', '081234567804', 'aktif', '2026-09-01', 25);

-- 3. Tabel Barang (Katalog persediaan)
INSERT INTO barang (kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang) VALUES
('ATK-001', 'Pulpen Gel 0.5', 'ATK', 4000.00, 120, 20),
('ATK-002', 'Buku Tulis 58', 'ATK', 6500.00, 80, 20),
('MNM-001', 'Air Mineral 600', 'minuman', 4000.00, 48, 24),
('MKN-001', 'Roti Cokelat', 'makanan', 5000.00, 6, 10);

-- 4. Tabel Pemasok (Supplier)
INSERT INTO pemasok (nama_pemasok, telepon_pemasok, alamat_pemasok) VALUES
('CV Sumber ATK', '0725123456', 'Jl. Yos Sudarso No. 12, Metro'),
('UD Segar Jaya', '0725654321', 'Jl. Ahmad Yani No. 88, Metro');

-- ---------------------------------------------------------------------
-- B. PENGISIAN DATA TRANSAKSI PENJUALAN & PEMBELIAN
-- ---------------------------------------------------------------------

-- Nota Penjualan 1 (Pembeli Anggota Aktif)
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan) VALUES
('PJ-2609-0142', '2026-09-24 10:15:00', 3, 1, 30000.00);

-- Detail Penjualan Nota 1 (Memakai INSERT ... SELECT untuk salinan harga historis)
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT 1, id_barang, 3, harga_jual_barang FROM barang WHERE kode_barang = 'ATK-001';

INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT 1, id_barang, 2, harga_jual_barang FROM barang WHERE kode_barang = 'ATK-002';

-- Update stok barang setelah transaksi Nota 1
UPDATE barang SET stok_barang = stok_barang - 3 WHERE kode_barang = 'ATK-001';
UPDATE barang SET stok_barang = stok_barang - 2 WHERE kode_barang = 'ATK-002';


-- Nota Penjualan 2 (Pembeli Umum / NULL)
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan) VALUES
('PJ-2609-0143', '2026-09-24 11:00:00', 1, NULL, 10000.00);

INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT 2, id_barang, 2, harga_jual_barang FROM barang WHERE kode_barang = 'MKN-001';

UPDATE barang SET stok_barang = stok_barang - 2 WHERE kode_barang = 'MKN-001';


-- Transaksi Pembelian Stok dari Pemasok (Faktur Masuk - Sesuai kolom DDL p05)
INSERT INTO pembelian (id_pemasok, no_faktur_pembelian, tgl_pembelian, status_pembelian) VALUES
(1, 'FK-202609-001', '2026-09-20', 'diterima');

INSERT INTO detail_pembelian (id_pembelian, id_barang, qty_detail_pembelian, harga_beli_detail_pembelian)
SELECT 1, id_barang, 50, 3200.00 FROM barang WHERE kode_barang = 'ATK-001';

-- Update stok barang karena barang dari pemasok sudah diterima
UPDATE barang SET stok_barang = stok_barang + 50 WHERE kode_barang = 'ATK-001';