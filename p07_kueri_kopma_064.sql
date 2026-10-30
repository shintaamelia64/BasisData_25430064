-- =================================================================
-- Nama  : Shinta Amelia
-- NPM   : 25430064
-- Kelas : C (S1 Ilmu Komputer)
-- Modul : 7 (SELECT dan Fungsi Skalar)
-- =================================================================

USE kopma_064; -- Sesuaikan dengan nama database kopma Anda

-- 1. KI-03: Barang di bawah stok minimum
SELECT kode_barang, nama_barang, stok_barang, stok_min_barang, 
       (stok_min_barang - stok_barang) AS kurang
FROM barang 
WHERE stok_barang < stok_min_barang 
ORDER BY kurang DESC;

-- 2. Penyaringan dengan IN (Barang kategori ATK atau Minuman)
-- (Sesuaikan kode kategori dengan data Anda)
SELECT kode_barang, nama_barang, kode_kategori 
FROM barang 
WHERE kode_kategori IN ('KTG-01', 'KTG-02');

-- 3. Penyaringan dengan BETWEEN (Nota pada rentang tanggal tertentu)
SELECT no_penjualan, tgl_penjualan, total_penjualan 
FROM penjualan 
WHERE tgl_penjualan BETWEEN '2026-09-01' AND '2026-09-30';

-- 4. Penyaringan dengan IS NULL (Anggota tanpa nomor HP)
SELECT no_anggota, nama_anggota, no_hp_anggota 
FROM anggota 
WHERE no_hp_anggota IS NULL;

-- 5. Penggunaan Fungsi Skalar (CONCAT, DATE_FORMAT, IFNULL, CASE)
SELECT CONCAT(nama_anggota, ' (', no_anggota, ')') AS anggota,
       DATE_FORMAT(tgl_daftar_anggota, '%d-%m-%Y') AS tgl_daftar,
       IFNULL(no_hp_anggota, '-') AS hp,
       CASE status_anggota WHEN 'aktif' THEN 'Diskon 5%'
            ELSE 'Tanpa diskon' END AS keterangan
FROM anggota
WHERE nama_anggota LIKE '%a%'
ORDER BY tgl_daftar_anggota DESC
LIMIT 5;

-- 6. Perhitungan lama keanggotaan dalam hari
SELECT nama_anggota, tgl_daftar_anggota,
       DATEDIFF(CURDATE(), tgl_daftar_anggota) AS lama_hari,
       CASE WHEN DATEDIFF(CURDATE(), tgl_daftar_anggota) < 180 THEN 'baru'
            ELSE 'lama' END AS status_keanggotaan
FROM anggota;

-- 7. Subtotal per baris detail nota (Contoh untuk nomor nota tertentu)
SELECT no_penjualan, kode_barang, qty_detail_penjualan, harga_satuan_detail_penjualan,
       (qty_detail_penjualan * harga_satuan_detail_penjualan) AS subtotal
FROM detail_penjualan
WHERE no_penjualan = 'PJ-2609-0142';