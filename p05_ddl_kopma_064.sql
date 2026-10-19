-- =====================================================================
-- Nama      : Shinta Amelia
-- NPM       : 25430064
-- Topik     : DDL dan Penerapan Constraint Aturan Bisnis Koperasi (Kopma)
-- File      : p05_ddl_kopma_064.sql
-- =====================================================================

-- Pilih basis data proyek
USE kopma_064;

-- ---------------------------------------------------------------------
-- 1. PENGHAPUSAN TABEL (Urutan terbalik dari anak/detail ke induk)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS detail_pembelian;
DROP TABLE IF EXISTS pembelian;
DROP TABLE IF EXISTS detail_penjualan;
DROP TABLE IF EXISTS penjualan;
DROP TABLE IF EXISTS pemasok;
DROP TABLE IF EXISTS barang;
DROP TABLE IF EXISTS anggota;
DROP TABLE IF EXISTS petugas;

-- ---------------------------------------------------------------------
-- 2. PEMBUATAN TABEL INDUK (MASTER)
-- ---------------------------------------------------------------------

-- Tabel Petugas (Pihak yang melayani transaksi atau pengadaan)
CREATE TABLE petugas (
    id_petugas SMALLINT NOT NULL AUTO_INCREMENT,
    kode_petugas CHAR(3) NOT NULL, -- Topik: Kode unik petugas tercetak di nota
    nama_petugas VARCHAR(100) NOT NULL,
    peran_petugas ENUM('kasir', 'gudang', 'ketua') NOT NULL, -- Topik: Pembagian wewenang peran
    PRIMARY KEY (id_petugas),
    UNIQUE KEY uq_petugas_kode (kode_petugas)
) ENGINE=InnoDB;

-- Tabel Anggota (Mahasiswa yang terdaftar sebagai anggota koperasi)
CREATE TABLE anggota (
    id_anggota INT NOT NULL AUTO_INCREMENT,
    no_anggota VARCHAR(20) NOT NULL,
    nim_anggota CHAR(10) NOT NULL,
    nama_anggota VARCHAR(100) NOT NULL,
    prodi_anggota VARCHAR(50) NOT NULL,
    no_hp_anggota VARCHAR(15) NULL, -- Topik: Data pribadi (dilindungi UU PDP)
    status_anggota ENUM('aktif', 'nonaktif') NOT NULL DEFAULT 'aktif', -- Topik: AB-02 Hak diskon anggota aktif
    tgl_daftar_anggota DATE NOT NULL,
    jumlah_poin INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id_anggota),
    UNIQUE KEY uq_anggota_no (no_anggota),
    UNIQUE KEY uq_anggota_nim (nim_anggota) -- Topik: AB-05 NIM unik sebagai identitas alternatif
) ENGINE=InnoDB;

-- Tabel Barang (Katalog dan persediaan barang koperasi)
CREATE TABLE barang (
    id_barang INT NOT NULL AUTO_INCREMENT,
    kode_barang VARCHAR(10) NOT NULL,
    nama_barang VARCHAR(100) NOT NULL,
    kategori_barang ENUM('ATK', 'makanan', 'minuman', 'elektronik') NOT NULL,
    harga_jual_barang DECIMAL(12,2) NOT NULL,
    stok_barang INT NOT NULL DEFAULT 0,
    stok_min_barang INT NOT NULL DEFAULT 5, -- Topik: AB-06 Batas minimum pemesanan ulang (restock)
    PRIMARY KEY (id_barang),
    UNIQUE KEY uq_barang_kode (kode_barang),
    CONSTRAINT ck_barang_stok CHECK (stok_barang >= 0), -- Topik: AB-03 Server menjaga stok tidak boleh minus
    CONSTRAINT ck_barang_harga CHECK (harga_jual_barang >= 0)
) ENGINE=InnoDB;

-- Tabel Pemasok (Pihak penyuplai barang ke koperasi)
CREATE TABLE pemasok (
    id_pemasok INT NOT NULL AUTO_INCREMENT,
    nama_pemasok VARCHAR(100) NOT NULL,
    telepon_pemasok VARCHAR(15) NOT NULL,
    alamat_pemasok TEXT NOT NULL,
    PRIMARY KEY (id_pemasok)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 3. PEMBUATAN TABEL TRANSAKSI (KEPALA & DETAIL)
-- ---------------------------------------------------------------------

-- Tabel Penjualan (Kepala Transaksi / Nota Keluar)
CREATE TABLE penjualan (
    id_penjualan INT NOT NULL AUTO_INCREMENT,
    no_nota_penjualan CHAR(12) NOT NULL, -- Topik: Format PJ-YYMM-nnnn
    tgl_penjualan DATETIME NOT NULL,     -- Topik: KI-01 Pencatatan tanggal dan jam sibuk harian
    id_petugas SMALLINT NOT NULL,        -- Topik: Setiap nota wajib ada petugas kasirnya
    id_anggota INT NULL,                 -- Topik: Opsional (bisa pembeli umum / NULL)
    bayar_penjualan DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id_penjualan),
    UNIQUE KEY uq_penjualan_nota (no_nota_penjualan), -- Topik: AB-01 Nomor nota penjualan wajib unik
    CONSTRAINT fk_penjualan_petugas FOREIGN KEY (id_petugas) REFERENCES petugas (id_petugas),
    CONSTRAINT fk_penjualan_anggota FOREIGN KEY (id_anggota) REFERENCES anggota (id_anggota) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Tabel Detail Penjualan (Rincian barang per nota)
CREATE TABLE detail_penjualan (
    id_penjualan INT NOT NULL,
    id_barang INT NOT NULL,
    qty_detail_penjualan SMALLINT NOT NULL,
    harga_satuan_detail_penjualan DECIMAL(12,2) NOT NULL, -- Topik: AB-04 Salinan harga saat transaksi (歷史 / historis aman)
    PRIMARY KEY (id_penjualan, id_barang),
    CONSTRAINT fk_detail_penjualan FOREIGN KEY (id_penjualan) REFERENCES penjualan (id_penjualan) ON DELETE CASCADE,
    CONSTRAINT fk_detail_barang FOREIGN KEY (id_barang) REFERENCES barang (id_barang),
    CONSTRAINT ck_detail_qty CHECK (qty_detail_penjualan > 0)
) ENGINE=InnoDB;

-- Tabel Pembelian (Kepala Faktur Masuk dari Pemasok)
CREATE TABLE pembelian (
    id_pembelian INT NOT NULL AUTO_INCREMENT,
    id_pemasok INT NOT NULL,
    no_faktur_pembelian VARCHAR(50) NOT NULL,
    tgl_pembelian DATE NOT NULL,
    status_pembelian ENUM('pesan', 'diterima') NOT NULL DEFAULT 'pesan', -- Topik: Alur pengadaan bertahap
    PRIMARY KEY (id_pembelian),
    CONSTRAINT fk_pembelian_pemasok FOREIGN KEY (id_pemasok) REFERENCES pemasok (id_pemasok)
) ENGINE=InnoDB;

-- Tabel Detail Pembelian (Rincian barang per faktur masuk)
CREATE TABLE detail_pembelian (
    id_pembelian INT NOT NULL,
    id_barang INT NOT NULL,
    qty_detail_pembelian INT NOT NULL,
    harga_beli_detail_pembelian DECIMAL(12,2) NOT NULL, -- Topik: Harga modal untuk perhitungan laba
    PRIMARY KEY (id_pembelian, id_barang),
    CONSTRAINT fk_dp_pembelian FOREIGN KEY (id_pembelian) REFERENCES pembelian (id_pembelian) ON DELETE CASCADE,
    CONSTRAINT fk_dp_barang FOREIGN KEY (id_barang) REFERENCES barang (id_barang),
    CONSTRAINT ck_dp_qty CHECK (qty_detail_pembelian > 0)
) ENGINE=InnoDB;