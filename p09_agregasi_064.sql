-- ============================================================================
-- Berkas    : p09_agregasi_064.sql
-- Modul     : Modul 9 - Tugas Mandiri / Milestone Proyek Toko Daring
-- Nama      : Shinta Amelia
-- NPM       : 25430064
-- Kelas     : C
-- Tema      : Toko Daring (Toko Daring Shinta)
-- Basis Data: toko_064
-- ============================================================================

USE toko_064;

-- Wajib mengaktifkan ONLY_FULL_GROUP_BY
SET SESSION sql_mode = CONCAT(@@sql_mode, ', ONLY_FULL_GROUP_BY');

-- ----------------------------------------------------------------------------
-- Laporan 1 [KI-01]: Omzet dan Jumlah Pesanan Bulanan dengan WITH ROLLUP
-- (Memakai WITH ROLLUP untuk subtotal per bulan & grand total seluruh periode)
-- ----------------------------------------------------------------------------
SELECT
    DATE_FORMAT(t.tgl_transaksi, '%Y-%m') AS bulan_transaksi,
    COUNT(DISTINCT t.id_transaksi) AS jumlah_pesanan,
    SUM(dp.qty_pesanan * dp.harga_satuan) AS total_omzet
FROM transaksi t
JOIN pesanan ps ON ps.id_transaksi = t.id_transaksi
JOIN detail_pesanan dp ON dp.id_pesanan = ps.id_pesanan
WHERE ps.status_pesanan <> 'batal'
GROUP BY DATE_FORMAT(t.tgl_transaksi, '%Y-%m') WITH ROLLUP;

-- ----------------------------------------------------------------------------
-- Laporan 2 [KI-02]: Produk Terlaris Berdasarkan Kuantitas per Kategori
-- (Memakai HAVING untuk menyaring produk dengan total terjual minimal 5 unit)
-- ----------------------------------------------------------------------------
SELECT
    k.nama_kategori,
    pr.kode_produk,
    pr.nama_produk,
    SUM(dp.qty_pesanan) AS total_qty_terjual,
    SUM(dp.qty_pesanan * dp.harga_satuan) AS total_nilai_penjualan
FROM detail_pesanan dp
JOIN pesanan ps ON ps.id_pesanan = dp.id_pesanan
JOIN produk pr ON pr.id_produk = dp.id_produk
JOIN kategori k ON k.id_kategori = pr.id_kategori
WHERE ps.status_pesanan IN ('dibayar', 'dikirim', 'selesai')
GROUP BY k.id_kategori, k.nama_kategori, pr.id_produk, pr.kode_produk, pr.nama_produk
HAVING SUM(dp.qty_pesanan) >= 5
ORDER BY total_qty_terjual DESC;

-- ----------------------------------------------------------------------------
-- Laporan 3 [KI-03]: Ringkasan Stok dan Harga Produk per Kategori
-- (Menggunakan MIN, MAX, AVG, dan COUNT untuk memantau kondisi stok katalog)
-- ----------------------------------------------------------------------------
SELECT
    k.nama_kategori,
    COUNT(pr.id_produk) AS jumlah_produk,
    MIN(pr.stok_produk) AS stok_terendah,
    MAX(pr.stok_produk) AS stok_tertinggi,
    ROUND(AVG(pr.harga_jual), 2) AS rata_rata_harga_jual
FROM kategori k
JOIN produk pr ON pr.id_kategori = k.id_kategori
GROUP BY k.id_kategori, k.nama_kategori
ORDER BY k.nama_kategori;

-- ----------------------------------------------------------------------------
-- Laporan 4 [KI-04]: Rekap Total Belanja per Pelanggan
-- (Memakai HAVING untuk menyaring pelanggan dengan total belanja > 0)
-- ----------------------------------------------------------------------------
SELECT
    pl.no_pelanggan,
    pl.nama_pelanggan,
    COUNT(DISTINCT t.id_transaksi) AS jumlah_transaksi,
    SUM(dp.qty_pesanan * dp.harga_satuan) AS total_belanja
FROM pelanggan pl
JOIN transaksi t ON t.id_pelanggan = pl.id_pelanggan
JOIN pesanan ps ON ps.id_transaksi = t.id_transaksi
JOIN detail_pesanan dp ON dp.id_pesanan = ps.id_pesanan
WHERE ps.status_pesanan <> 'batal'
GROUP BY pl.id_pelanggan, pl.no_pelanggan, pl.nama_pelanggan
HAVING SUM(dp.qty_pesanan * dp.harga_satuan) > 0
ORDER BY total_belanja DESC;

-- ----------------------------------------------------------------------------
-- Laporan 5 [KI-05]: Ringkasan Status Pengiriman Pesanan
-- (Meringkas jumlah pengiriman dan total biaya ongkir per status pengiriman)
-- ----------------------------------------------------------------------------
SELECT
    pg.status_pengiriman,
    COUNT(pg.id_pengiriman) AS jumlah_pengiriman,
    SUM(pg.biaya_ongkir) AS total_biaya_ongkir,
    COUNT(pg.no_resi) AS jumlah_punya_resi
FROM pengiriman pg
GROUP BY pg.status_pengiriman
ORDER BY pg.status_pengiriman;