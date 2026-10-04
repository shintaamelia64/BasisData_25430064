-- =================================================================
-- Modul 1: Lingkungan Kerja MariaDB & Git
-- Nama  : Shinta Amelia
-- NIM   : <NIM_Anda>
-- =================================================================

-- 1. Membuat Basis Data Praktikum (Kopma)
CREATE DATABASE IF NOT EXISTS kopma_<3_digit_terakhir_nim> 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Membuat Akun Pengguna Praktikum & Memberikan Hak Akses
CREATE USER IF NOT EXISTS 'mhs_<3_digit_terakhir_nim>'@'localhost' 
IDENTIFIED BY '<password_kerja_aman>';

GRANT ALL PRIVILEGES ON kopma_<3_digit_terakhir_nim>.* 
TO 'mhs_<3_digit_terakhir_nim>'@'localhost';

-- 3. Membuat Basis Data Proyek Mandiri
CREATE DATABASE IF NOT EXISTS <kode_tema>_<3_digit_terakhir_nim> 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'dev_<3_digit_terakhir_nim>'@'localhost' 
IDENTIFIED BY '<password_dev_aman>';

GRANT ALL PRIVILEGES ON <kode_tema>_<3_digit_terakhir_nim>.* 
TO 'dev_<3_digit_terakhir_nim>'@'localhost';

-- Terapkan perubahan hak akses
FLUSH PRIVILEGES; 