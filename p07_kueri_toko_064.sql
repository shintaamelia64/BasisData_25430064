-- =================================================================
-- Nama          : Shinta Amelia
-- NPM           : 25430064
-- Kelas         : C (S1 Ilmu Komputer)
-- Modul         : 7 (SELECT dan Fungsi Skalar)
-- Tema Proyek   : Toko Daring Shinta (toko_064)

-- =================================================================

USE toko_064;

-- -----------------------------------------------------------------
-- KI-01: Pencarian produk berdasarkan kategori menggunakan operator IN
-- Pertanyaan: Produk apa saja yang masuk dalam kategori Elektronik atau Pakaian?
-- Harapan: Menampilkan daftar produk elektronik dan pakaian beserta harganya.
-- -----------------------------------------------------------------
SELECT id_produk, nama_produk, id_kategori, harga_jual 
FROM produk 
WHERE id_kategori IN ('CAT-01', 'CAT-02');

-- -----------------------------------------------------------------
-- KI-02: Pencarian produk berdasarkan nama tertentu menggunakan LIKE
-- Pertanyaan: Produk apa saja yang memiliki kata 'Kemeja' pada nama produknya?
-- Harapan: Menampilkan daftar produk yang memuat kata 'Kemeja'.
-- -----------------------------------------------------------------
SELECT id_produk, nama_produk, harga_jual, stok 
FROM produk 
WHERE nama_produk LIKE '%Kemeja%';

-- -----------------------------------------------------------------
-- KI-03: Menampilkan produk dengan stok paling sedikit menggunakan ORDER BY dan LIMIT
-- Pertanyaan: Produk apa saja yang stoknya paling sedikit dan perlu diperbarui?
-- Harapan: Menampilkan 3 produk dengan jumlah stok paling rendah.
-- -----------------------------------------------------------------
SELECT nama_produk, stok 
FROM produk 
ORDER BY stok ASC 
LIMIT 3;

-- -----------------------------------------------------------------
-- KI-04: Mengubah nama produk menjadi huruf kapital menggunakan fungsi UPPER
-- Pertanyaan: Bagaimana format nama produk jika ditampilkan dalam huruf kapital seluruhnya?
-- Harapan: Menampilkan nama produk dalam huruf besar/kapital.
-- -----------------------------------------------------------------
SELECT UPPER(nama_produk) AS produk_kapital, harga_jual 
FROM produk;

-- -----------------------------------------------------------------
-- KI-05: Memformat tampilan harga produk menggunakan fungsi FORMAT
-- Pertanyaan: Bagaimana tampilan harga produk dengan format mata uang rupiah?
-- Harapan: Menampilkan harga produk yang terformat dengan pemisah ribuan.
-- -----------------------------------------------------------------
SELECT nama_produk, FORMAT(harga_jual, 0, 'id_ID') AS harga_rupiah 
FROM produk;

-- -----------------------------------------------------------------
-- KI-06: Penyaringan pesanan berdasarkan rentang tanggal menggunakan BETWEEN
-- Pertanyaan: Apa saja transaksi pesanan yang masuk pada bulan September 2026?
-- Harapan: Menampilkan daftar pesanan dari tanggal 1 hingga 30 September 2026.
-- -----------------------------------------------------------------
SELECT id_pesanan, tgl_pesanan, status_pesanan 
FROM pesanan 
WHERE tgl_pesanan BETWEEN '2026-09-01' AND '2026-09-30';

-- -----------------------------------------------------------------
-- KI-07: Memeriksa data pelanggan yang tidak memiliki nomor telepon menggunakan IS NULL
-- Pertanyaan: Siapa saja pelanggan yang belum mencantumkan nomor teleponnya?
-- Harapan: Menampilkan data pelanggan dengan nomor telepon bernilai NULL.
-- -----------------------------------------------------------------
SELECT id_pelanggan, nama_pelanggan, email_pelanggan 
FROM pelanggan 
WHERE no_hp IS NULL;

-- -----------------------------------------------------------------
-- KI-08: Klasifikasi tingkat diskon pelanggan menggunakan CASE
-- Pertanyaan: Bagaimana kategori diskon yang didapat berdasarkan status keanggotaan pelanggan?
-- Harapan: Menampilkan label informasi diskon untuk tiap pelanggan.
-- -----------------------------------------------------------------
SELECT nama_pelanggan, status_member,
       CASE status_member 
            WHEN 'VIP' THEN 'Diskon 15%'
            ELSE 'Diskon Standar 5%' 
       END AS info_diskon
FROM pelanggan;

-- -----------------------------------------------------------------
-- KI-09: Menghitung masa aktif akun pelanggan menggunakan DATEDIFF dan CURDATE
-- Pertanyaan: Sudah berapa hari akun pelanggan terdaftar di sistem?
-- Harapan: Menampilkan jumlah hari sejak tanggal pendaftaran akun pelanggan.
-- -----------------------------------------------------------------
SELECT nama_pelanggan, tgl_daftar,
       DATEDIFF(CURDATE(), tgl_daftar) AS umur_akun_hari
FROM pelanggan;

-- -----------------------------------------------------------------
-- KI-10: Menyaring data pembayaran berdasarkan beberapa metode pembayaran menggunakan IN
-- Pertanyaan: Transaksi pembayaran mana saja yang menggunakan metode Transfer Bank, QRIS, atau COD?
-- Harapan: Menampilkan daftar transaksi pembayaran via Transfer Bank, QRIS, dan COD.
-- -----------------------------------------------------------------
SELECT id_pembayaran, id_pesanan, metode_pembayaran, jumlah_bayar 
FROM pembayaran 
WHERE metode_pembayaran IN ('Transfer Bank', 'QRIS', 'COD');