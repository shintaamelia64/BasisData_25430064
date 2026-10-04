-- Modul 1: Lingkungan Kerja MariaDB dan Git
-- NIM: 064

CREATE DATABASE IF NOT EXISTS kopma_064 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'mhs_064'@'localhost' IDENTIFIED BY 'PasswordKerja';

GRANT ALL PRIVILEGES ON kopma_064.* TO 'mhs_064'@'localhost';

FLUSH PRIVILEGES;


CREATE USER IF NOT EXISTS 'tamu_064'@'localhost' IDENTIFIED BY 'PasswordKerja';

GRANT ALL PRIVILEGES ON kopma_064.* TO 'tamu_064'@'localhost';

FLUSH PRIVILEGES;