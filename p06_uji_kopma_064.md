# Skenario Uji Basis Data - Koperasi Mahasiswa (kopma_064)
**Nama:** Shinta Amelia  
**NPM:** 25430064  
**Modul:** Modul 6 (DML dan Pengujian Basis Data Kopma)  

Tabel skenario uji positif dan negatif berikut disusun untuk membuktikan bahwa server MariaDB menegakkan constraint aturan bisnis (AB-xx) yang sudah dirancang pada DDL Modul 5[cite: 81, 83]:

| Kode Uji | Jenis Uji | Masukan / Perintah SQL | Hasil yang Diharapkan | Hasil Nyata (Layar) | Status | Constraint / Aturan Bisnis |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **UJ-01** | Positif | Insert nota penjualan baru dengan anggota aktif | Transaksi berhasil dicatat | Query OK, 1 row affected | **LULUS** | AB-02 (Sesuai aturan)[cite: 83, 153] |
| **UJ-02** | Positif | Insert nota penjualan untuk pembeli umum (`id_anggota = NULL`) | Transaksi berhasil dicatat | Query OK, 1 row affected | **LULUS** | AB-02 (Pembeli umum diizinkan)[cite: 83, 153] |
| **UJ-03** | Negatif | Update stok barang menjadi bernilai minus (`stok_barang = -5`) | Ditolak server | ERROR 4025 (23000): CONSTRAINT `ck_barang_stok` failed | **LULUS** | AB-03 (`ck_barang_stok`)[cite: 71, 83, 153] |
| **UJ-04** | Negatif | Insert nomor nota penjualan yang sudah ada (`PJ-2609-0142`) | Ditolak server | ERROR 1062 (23000): Duplicate entry 'PJ-2609-0142' for key 'uq_penjualan_nota' | **LULUS** | AB-01 (`uq_penjualan_nota`)[cite: 71, 83, 153] |
| **UJ-05** | Negatif | Insert detail penjualan dengan jumlah nol (`qty_detail_penjualan = 0`) | Ditolak server | ERROR 4025 (23000): CONSTRAINT `ck_detail_qty` failed | **LULUS** | `ck_detail_qty`[cite: 71, 83, 153] |
| **UJ-06** | Negatif | Insert anggota baru dengan NIM yang sudah terdaftar | Ditolak server | ERROR 1062 (23000): Duplicate entry for key 'uq_anggota_nim' | **LULUS** | AB-05 (`uq_anggota_nim`)[cite: 71, 83, 153] |
| **UJ-07** | Negatif | Insert penjualan dengan `id_petugas` yang tidak ada (misal: 99) | Ditolak server | ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails | **LULUS** | `fk_penjualan_petugas`[cite: 71, 83, 153] |
| **UJ-08** | Negatif | Menjalankan `UPDATE barang SET harga_jual_barang = 5000` tanpa `WHERE` saat mode aman aktif | Ditolak server | ERROR 1175 (HY000): You are using safe update mode... | **LULUS** | `sql_safe_updates`[cite: 80, 81, 83] |
| **UJ-09** | Positif | Menjalankan `DELETE` pada nota penjualan yang memiliki detail | Nota terhapus, detail otomatis ikut terhapus | Query OK, 1 row affected | **LULUS** | `ON DELETE CASCADE` pada `fk_detail_penjualan`[cite: 83, 153] |
| **UJ-10** | Gagal* | Membeli barang melebihi stok yang tersedia (misal stok 6, dibeli 10) | Diterima server (stok menjadi minus jika tidak diperiksa sebelum update) | Query OK, 1 row affected | **GAGAL** | *Utang desain: constraint `CHECK` di tabel barang tidak dapat mencegah transaksi ini; akan dilunasi pada Modul 14[cite: 83]. |

> **Catatan Uji Gagal (Utang Desain):** UJ-10 menunjukkan bahwa constraint `CHECK` pada tabel barang hanya memeriksa status nilai kolom di tabelnya sendiri, bukan membandingkan masukan `qty` transaksi dengan ketersediaan stok[cite: 83]. Logika pemeriksaan ini akan dilunasi menggunakan blok transaksi bisnis (`START TRANSACTION`) pada Modul 14[cite: 83, 124, 125].