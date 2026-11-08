-- ============================================================================
-- Berkas    : install_uts_064.sql
-- NAMA     : Shinta Amelia (NPM: 25430064)
-- DESKRIPSI: Skrip Pemasangan Bersih Basis Data Toko Daring Shinta (UTS)
-- ============================================================================

-- 1. Buat Basis Data Bersih
DROP DATABASE IF EXISTS toko_064;
CREATE DATABASE toko_064 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE toko_064;

-- 2. Panggil Struktur DDL (Modul 5) dengan Path Lengkap
SOURCE D:/basisdata_25430064/p05_ddl_064.sql;

-- 3. Panggil Pengisian Data Sampel (Modul 6) dengan Path Lengkap
SOURCE D:/basisdata_25430064/p06_data_064.sql;

-- 4. Verifikasi Hasil Instalasi & Total Baris
SELECT 'INSTALASI BERSIH UTS BERHASIL!' AS status;
SELECT TABLE_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'toko_064';
SELECT COUNT(*) AS total_detail_pesanan FROM detail_pesanan;