-- ============================================================================
-- Berkas    : p09_agregasi_kopma_064.sql
-- Modul     : Modul 9 - Meringkas Data dengan Fungsi Agregat dan GROUP BY
-- Nama      : Shinta Amelia
-- NPM       : 25430064
-- Kelas     : C
-- Basis Data: kopma_064
-- ============================================================================

USE kopma_064;

-- Aktifkan mode ketat pengelompokan sesuai standar Modul 9
SET SESSION sql_mode = CONCAT(@@sql_mode, ', ONLY_FULL_GROUP_BY');

-- ----------------------------------------------------------------------------
-- D.1 Verifikasi Data Lanjutan (75 nota, 2026-09-02 s.d. 2026-10-31)
-- Hasil diharapkan: nota = 75, awal = 2026-09-02 ..., akhir = 2026-10-31 ...
-- ----------------------------------------------------------------------------
SELECT
    COUNT(*) AS nota,
    MIN(tgl_penjualan) AS awal,
    MAX(tgl_penjualan) AS akhir
FROM penjualan;

-- ----------------------------------------------------------------------------
-- D.2 Total Satu Nota
-- Hasil diharapkan: menampilkan nomor nota dan total nominal baris detail
-- ----------------------------------------------------------------------------
SELECT
    p.no_nota_penjualan,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS jumlah
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
WHERE p.no_nota_penjualan = 'PJ-2609-0001'
GROUP BY p.id_penjualan, p.no_nota_penjualan;

-- Contoh pengujian nota pada dokumen kebutuhan awal (PJ-2609-0142)
SELECT
    p.no_nota_penjualan,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS jumlah
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
WHERE p.no_nota_penjualan = 'PJ-2609-0142'
GROUP BY p.id_penjualan, p.no_nota_penjualan;

-- ----------------------------------------------------------------------------
-- D.3 [KI-01] Laporan Omzet Harian (Minggu Pertama September) + WITH ROLLUP
-- Hasil diharapkan: rincian per tanggal 2026-09-02 s.d. 2026-09-07 dan total
-- 10 nota, omzet 200000.00 pada baris ROLLUP (NULL)
-- ----------------------------------------------------------------------------
SELECT
    DATE(p.tgl_penjualan) AS tanggal,
    COUNT(DISTINCT p.id_penjualan) AS nota,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS omzet
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
WHERE p.tgl_penjualan >= '2026-09-01'
  AND p.tgl_penjualan < '2026-09-08'
GROUP BY DATE(p.tgl_penjualan) WITH ROLLUP;

-- D.3 [KI-01] Laporan Omzet Bulanan (September & Oktober 2026)
-- Hasil diharapkan: 2026-09 (39 nota, 691000.00) dan 2026-10 (36 nota, 507500.00)
SELECT
    DATE_FORMAT(p.tgl_penjualan, '%Y-%m') AS bulan,
    COUNT(DISTINCT p.id_penjualan) AS nota,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS omzet
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
GROUP BY DATE_FORMAT(p.tgl_penjualan, '%Y-%m')
ORDER BY bulan;

-- Perbandingan Titik Analisis 2 pada data September 2026
SELECT
    COUNT(*) AS jumlah_baris_join_detail,
    COUNT(DISTINCT p.id_penjualan) AS jumlah_nota_unik
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
WHERE p.tgl_penjualan >= '2026-09-01'
  AND p.tgl_penjualan < '2026-10-01';

-- ----------------------------------------------------------------------------
-- D.4 Menyaring Kelompok dengan HAVING
-- ----------------------------------------------------------------------------
-- Kasir yang melayani lebih dari 20 nota
SELECT
    pt.kode_petugas,
    pt.nama_petugas,
    COUNT(*) AS nota
FROM penjualan p
JOIN petugas pt ON pt.id_petugas = p.id_petugas
GROUP BY pt.id_petugas, pt.kode_petugas, pt.nama_petugas
HAVING COUNT(*) > 20;

-- Barang yang total qty terjualnya kurang dari 10
SELECT
    b.kode_barang,
    b.nama_barang,
    COALESCE(SUM(d.qty_detail_penjualan), 0) AS total_qty_terjual
FROM barang b
LEFT JOIN detail_penjualan d ON d.id_barang = b.id_barang
GROUP BY b.id_barang, b.kode_barang, b.nama_barang
HAVING COALESCE(SUM(d.qty_detail_penjualan), 0) < 10;

-- Titik Analisis 3: Rata-rata belanja per nota untuk anggota saja
-- Hasil diharapkan: rata-rata nominal per nota khusus transaksi anggota
SELECT
    a.no_anggota,
    a.nama_anggota,
    COUNT(DISTINCT p.id_penjualan) AS jumlah_nota,
    AVG(sub.total_nota) AS rata_rata_belanja_per_nota
FROM penjualan p
JOIN anggota a ON a.id_anggota = p.id_anggota
JOIN (
    SELECT
        id_penjualan,
        SUM(qty_detail_penjualan * harga_satuan_detail_penjualan) AS total_nota
    FROM detail_penjualan
    GROUP BY id_penjualan
) AS sub ON sub.id_penjualan = p.id_penjualan
WHERE p.id_anggota IS NOT NULL
GROUP BY a.id_anggota, a.no_anggota, a.nama_anggota;

-- ----------------------------------------------------------------------------
-- E.1 Diskon 5% Anggota Aktif (AB-02) & Kembalian > Rp4.000
-- Hasil diharapkan: daftar nota dengan selisih (bayar_penjualan - total_neto) > 4000
-- ----------------------------------------------------------------------------
SELECT
    p.no_nota_penjualan,
    COALESCE(a.nama_anggota, 'Umum') AS pembeli,
    COALESCE(a.status_anggota, '-') AS status_anggota,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS total_kotor,
    CASE
        WHEN a.id_anggota IS NOT NULL AND a.status_anggota = 'aktif'
            THEN SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) * 0.95
        ELSE SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan)
    END AS total_setelah_diskon,
    p.bayar_penjualan,
    p.bayar_penjualan - CASE
        WHEN a.id_anggota IS NOT NULL AND a.status_anggota = 'aktif'
            THEN SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) * 0.95
        ELSE SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan)
    END AS kembalian
FROM penjualan p
LEFT JOIN anggota a ON a.id_anggota = p.id_anggota
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
GROUP BY
    p.id_penjualan,
    p.no_nota_penjualan,
    a.id_anggota,
    a.nama_anggota,
    a.status_anggota,
    p.bayar_penjualan
HAVING kembalian > 4000;

-- ----------------------------------------------------------------------------
-- E.2 Omzet per Kategori Barang per Bulan dengan WITH ROLLUP
-- Hasil diharapkan: rincian bulan-kategori, subtotal per bulan, dan grand total
-- ----------------------------------------------------------------------------
SELECT
    DATE_FORMAT(p.tgl_penjualan, '%Y-%m') AS bulan,
    b.kategori_barang,
    SUM(d.qty_detail_penjualan * d.harga_satuan_detail_penjualan) AS omzet
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
JOIN barang b ON b.id_barang = d.id_barang
GROUP BY
    DATE_FORMAT(p.tgl_penjualan, '%Y-%m'),
    b.kategori_barang WITH ROLLUP;