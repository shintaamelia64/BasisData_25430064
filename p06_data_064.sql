-- ============================================================
-- Berkas      : p06_data_064.sql
-- Modul       : Modul 6 - DML dan Pengujian Basis Data (Toko Daring Shinta)
-- NPM         : 25430064
-- Nama        : Shinta Amelia
-- Deskripsi   : Skrip pengisian data sampel (Berbasis Parameter P = 2)
-- ============================================================

USE toko_064;

-- A. Mengisi Data Master: Kategori Produk
INSERT INTO kategori (id_kategori, nama_kategori) VALUES
(1, 'Elektronik'),
(2, 'Pakaian'),
(3, 'Peralatan Rumah Tangga'),
(4, 'Buku & Alat Tulis'),
(5, 'Makanan & Minuman');

-- B. Mengisi Data Master: Produk (Minimal 5 baris)
INSERT INTO produk (kode_produk, nama_produk, id_kategori, harga_jual, stok_produk, stok_min_produk) VALUES
('ELK-001', 'Flashdisk 32GB', 1, 75000.00, 50, 10),
('ELK-002', 'Mouse Wireless', 1, 120000.00, 30, 5),
('PCK-001', 'Kemeja Flanel Pria', 2, 150000.00, 25, 5),
('PRT-001', 'Blender Miyako', 3, 250000.00, 15, 3),
('BAT-001', 'Buku Tulis A5 (isi 10)', 4, 35000.00, 100, 20),
('MKM-001', 'Kopi Susu Literan', 5, 45000.00, 40, 10);

-- C. Mengisi Data Master: Pelanggan (Minimal 5 baris)
INSERT INTO pelanggan (no_pelanggan, nama_pelanggan, email_pelanggan, telepon_pelanggan, alamat_pelanggan, tgl_daftar) VALUES
('PLG-0001', 'Budi Santoso', 'budi.santoso@email.com', '081234567890', 'Jl. Sudirman No. 12, Metro', '2026-09-01'),
('PLG-0002', 'Siti Rahma', 'siti.rahma@email.com', '085678901234', 'Jl. Ahmad Yani No. 45, Metro', '2026-09-05'),
('PLG-0003', 'Ahmad Fauzi', 'ahmad.fauzi@email.com', '087812345678', 'Jl. Ki Hajar Dewantara No. 8, Metro', '2026-09-10'),
('PLG-0004', 'Dewi Lestari', 'dewi.lestari@email.com', '081987654321', 'Jl. Cendrawasih No. 3, Bandar Lampung', '2026-09-15'),
('PLG-0005', 'Eko Prasetyo', 'eko.prasetyo@email.com', '081321436587', 'Jl. Kartini No. 20, Bandar Lampung', '2026-09-20');

-- D. Mengisi Data Transaksi & Pesanan (Minimal 20 baris pesanan sesuai ketentuan 10 x P = 20)
-- Nota 1
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0001', '2026-10-01 10:30:00', 1, 195000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (1, 'selesai', 'Kirim cepat');
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (1, 1, 1, 75000.00), (1, 2, 1, 120000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 1;
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 2;

-- Nota 2
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0002', '2026-10-02 11:15:00', 2, 150000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (2, 'selesai', 'Jangan dibanting');
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (2, 3, 1, 150000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 3;

-- Nota 3
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0003', '2026-10-03 14:00:00', 3, 250000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (3, 'dikirim', 'Pakai bubble wrap');
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (3, 4, 1, 250000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 4;

-- Nota 4
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0004', '2026-10-04 09:20:00', 4, 70000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (4, 'dibayar', 'Terima kasih');
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (4, 5, 2, 35000.00);
UPDATE produk SET stok_produk = stok_produk - 2 WHERE id_produk = 5;

-- Nota 5
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0005', '2026-10-05 15:45:00', 5, 90000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (5, 'selesai', 'Dingin ya');
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (5, 6, 2, 45000.00);
UPDATE produk SET stok_produk = stok_produk - 2 WHERE id_produk = 6;

-- Nota 6
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0006', '2026-10-06 10:00:00', 1, 75000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (6, 'selesai', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (6, 1, 1, 75000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 1;

-- Nota 7
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0007', '2026-10-07 13:10:00', 2, 120000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (7, 'selesai', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (7, 2, 1, 120000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 2;

-- Nota 8
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0008', '2026-10-08 16:25:00', 3, 150000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (8, 'dikirim', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (8, 3, 1, 150000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 3;

-- Nota 9
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0009', '2026-10-09 08:50:00', 4, 35000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (9, 'dibayar', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (9, 5, 1, 35000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 5;

-- Nota 10
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0010', '2026-10-10 12:00:00', 5, 45000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (10, 'selesai', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (10, 6, 1, 45000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 6;

-- Nota 11
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0011', '2026-10-11 14:30:00', 1, 240000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (11, 'selesai', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (11, 2, 2, 120000.00);
UPDATE produk SET stok_produk = stok_produk - 2 WHERE id_produk = 2;

-- Nota 12
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0012', '2026-10-12 15:00:00', 2, 70000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (12, 'selesai', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (12, 5, 2, 35000.00);
UPDATE produk SET stok_produk = stok_produk - 2 WHERE id_produk = 5;

-- Nota 13
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0013', '2026-10-13 11:20:00', 3, 75000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (13, 'dibayar', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (13, 1, 1, 75000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 1;

-- Nota 14
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0014', '2026-10-14 09:15:00', 4, 250000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (14, 'selesai', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (14, 4, 1, 250000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 4;

-- Nota 15
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0015', '2026-10-15 13:40:00', 5, 150000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (15, 'dikirim', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (15, 3, 1, 150000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 3;

-- Nota 16
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0016', '2026-10-16 10:50:00', 1, 90000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (16, 'selesai', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (16, 6, 2, 45000.00);
UPDATE produk SET stok_produk = stok_produk - 2 WHERE id_produk = 6;

-- Nota 17
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0017', '2026-10-17 14:00:00', 2, 120000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (17, 'selesai', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (17, 2, 1, 120000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 2;

-- Nota 18
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0018', '2026-10-18 16:10:00', 3, 75000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (18, 'dibayar', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (18, 1, 1, 75000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 1;

-- Nota 19
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0019', '2026-10-19 11:00:00', 4, 35000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (19, 'selesai', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (19, 5, 1, 35000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 5;

-- Nota 20
INSERT INTO transaksi (no_transaksi, tgl_transaksi, id_pelanggan, total_transaksi) VALUES ('TRX-2610-0020', '2026-10-20 15:30:00', 5, 150000.00);
INSERT INTO pesanan (id_transaksi, status_pesanan, catatan_pesanan) VALUES (20, 'selesai', NULL);
INSERT INTO detail_pesanan (id_pesanan, id_produk, qty_pesanan, harga_satuan) VALUES (20, 3, 1, 150000.00);
UPDATE produk SET stok_produk = stok_produk - 1 WHERE id_produk = 3;