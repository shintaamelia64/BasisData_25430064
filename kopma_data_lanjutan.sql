-- ==========================================================
-- Data Lanjutan Basis Data: kopma_064 (Modul 9)
-- ==========================================================

USE kopma_064;

-- 1. Tambahan data petugas (jika belum ada)
INSERT IGNORE INTO petugas (id_petugas, kode_petugas, nama_petugas, peran_petugas) VALUES
(1, 'K01', 'Rina Sari', 'kasir'),
(2, 'K02', 'Dimas Pratama', 'kasir'),
(3, 'G01', 'Budi Santoso', 'gudang');

-- 2. Tambahan data anggota (jika belum ada)
INSERT IGNORE INTO anggota (id_anggota, no_anggota, nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota) VALUES
(1, 'AGT001', '25430001', 'Aulia Rahma', 'S1 Ilmu Komputer', '081234560001', 'aktif', '2025-09-01'),
(2, 'AGT002', '25430015', 'Fajar Nugroho', 'S1 Ilmu Komputer', '081234560002', 'aktif', '2025-09-05');

-- 3. Tambahan data barang (kategori sesuai ENUM: 'ATK', 'makanan', 'minuman')
INSERT IGNORE INTO barang (id_barang, kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang) VALUES
(5, 'ATK-005', 'Buku Catatan A5', 'ATK', 8000.00, 40, 10),
(6, 'MKN-001', 'Roti Coklat Kopma', 'makanan', 5000.00, 30, 5),
(7, 'MNM-001', 'Air Mineral 600ml', 'minuman', 3500.00, 50, 10);

-- 4. Tambahan transaksi penjualan (no_nota_penjualan <= 12 karakter, tanggal 24-27 Sept 2026)
INSERT IGNORE INTO penjualan (id_penjualan, no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan) VALUES
(4, 'PJ26090144', '2026-09-25 09:20:00', 1, 1, 25000.00),
(5, 'PJ26090145', '2026-09-25 13:45:00', 1, 2, 12000.00),
(6, 'PJ26090146', '2026-09-26 10:10:00', 2, 1, 18500.00),
(7, 'PJ26090148', '2026-09-27 11:30:00', 2, NULL, 10500.00);

-- 5. Tambahan rincian detail penjualan
INSERT IGNORE INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan) VALUES
(4, 1, 3, 4000.00),
(4, 5, 1, 8000.00),
(5, 1, 3, 4000.00),
(6, 6, 3, 5000.00),
(6, 7, 1, 3500.00),
(7, 7, 3, 3500.00);