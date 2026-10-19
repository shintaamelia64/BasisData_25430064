# Dokumen Kebutuhan Data - Koperasi Mahasiswa Sejahtera (Kopma)

## 1. Latar belakang dan aktivitas organisasi
Koperasi Mahasiswa Sejahtera (Kopma) merupakan unit usaha di lingkungan kampus yang melayani penjualan berbagai kebutuhan mahasiswa seperti alat tulis, makanan ringan, dan minuman. Aktivitas utama organisasi meliputi penjualan tunai kepada pembeli (anggota maupun umum), pencatatan pendaftaran keanggotaan, pengelolaan stok barang gudang, pemesanan stok ke pemasok, serta penyusunan laporan periodik bagi pengurus.

## 2. Aktor dan proses bisnis (tabel PB-xx)
| Kode | Proses Bisnis | Aktor | Pemicu |
|---|---|---|---|
| PB-01 | Mendaftarkan anggota | Kasir (atas permintaan mahasiswa) | Mahasiswa ingin menjadi anggota |
| PB-02 | Mencatat penjualan | Kasir | Pembeli membayar di kasir |
| PB-03 | Memesan barang ke pemasok | Petugas gudang | Stok barang di bawah batas minimum |
| PB-04 | Menerima barang dari pemasok | Petugas gudang | Barang datang bersama faktur |
| PB-05 | Menyusun laporan bulanan | Ketua koperasi | Memasuki awal bulan |

## 3. Dokumen sumber yang dianalisis
- Formulir pendaftaran anggota (memuat NIM, nama, prodi, no HP).
- Nota penjualan (memuat nomor nota, tanggal/jam, kasir, anggota, daftar barang, qty, dan harga).
- Faktur pembelian dari pemasok.
- Buku catatan stok fisik gudang.

## 4. Entitas kandidat dan elemen data
- **Anggota**: id_anggota, no_anggota, nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota, **jumlah_poin** *(tambahan fitur poin loyalitas)*.
- **Barang**: id_barang, kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang.
- **Petugas**: id_petugas, kode_petugas, nama_petugas, peran_petugas.
- **Pemasok**: id_pemasok, nama_pemasok, telepon_pemasok, alamat_pemasok.
- **Penjualan**: id_penjualan, no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan.
- **Detail Penjualan**: id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan, **poin_didapat**, **poin_digunakan** *(tambahan fitur poin loyalitas)*.
- **Pembelian & Detail Pembelian**: id_pembelian, no_faktur_pembelian, tgl_pembelian, id_pemasok, status_pembelian, qty_detail_pembelian, harga_beli_detail_pembelian.

## 5. Aturan bisnis (tabel AB-xx)
- **AB-01**: Setiap nota memiliki nomor unik dan minimal satu baris barang.
- **AB-02**: Penjualan boleh tanpa anggota (pembeli umum); jika ada, anggota harus berstatus aktif untuk memperoleh diskon 5%.
- **AB-03**: Stok barang tidak boleh negatif; penjualan ditolak bila qty melebihi stok tersedia.
- **AB-04**: Harga jual yang dipakai pada nota disimpan per baris dan tidak berubah meski harga barang kemudian naik.
- **AB-05**: NIM anggota unik; pencarian anggota dapat dilakukan lewat nomor anggota atau NIM.
- **AB-06**: Pesanan pembelian dibuat bila stok kurang dari batas minimum barang tersebut.
- **AB-07**: Setiap kelipatan belanja Rp10.000 pada transaksi anggota bernilai 1 poin loyalitas.
- **AB-08**: Poin loyalitas hanya dapat diperoleh jika anggota menunjukkan identitas/nomor anggota saat bertransaksi.
- **AB-09**: Anggota dapat menukarkan poin loyalitas jika jumlahnya sudah mencapai minimal 50 poin.
- **AB-10**: Setiap penukaran 50 poin akan memberikan potongan harga sebesar Rp5.000 pada transaksi berikutnya.

## 6. Kebutuhan informasi (tabel KI-xx)
- **KI-01**: Omzet dan jumlah nota per hari dan per bulan.
- **KI-02**: Lima barang terlaris per bulan berdasarkan qty.
- **KI-03**: Barang dengan stok di bawah batas minimum.
- **KI-04**: Sepuluh anggota dengan belanja terbesar per bulan.
- **KI-05**: Laporan saldo/jumlah poin loyalitas tiap anggota secara *real-time*.
- **KI-06**: Laporan riwayat perolehan poin dan riwayat penukaran poin per periode.

## 7. Matriks CRUD
| Proses Bisnis | Anggota | Barang | Penjualan | Detail Penjualan | Pemasok | Pembelian | Poin |
|---|---|---|---|---|---|---|---|
| PB-01 Daftar anggota | C | | | | | | C |
| PB-02 Catat penjualan | R | R, U | C | C | | | C, U |
| PB-03 Pesan ke pemasok | | R | | | R | C | |
| PB-04 Terima barang | | U | | | U | U | |
| PB-05 Laporan bulanan | R | R | R | R | | R | R |

## 8. Kamus data awal (dengan penanggung jawab)
| Elemen Data | Arti | Contoh Nilai | Aturan / Format | Penanggung Jawab |
|---|---|---|---|---|
| no_anggota | Nomor anggota koperasi | A-0457 | Unik, format A-4 digit | Ketua |
| nim_anggota | NIM anggota | 25430064 | Unik, 10 digit | Ketua |
| no_nota_penjualan | Nomor nota penjualan | PJ-2609-0142 | Unik per nota | Kasir |
| stok_barang | Jumlah barang tersedia | 35 | Bilangan bulat $\ge 0$ (AB-03) | Petugas Gudang |
| jumlah_poin | Saldo poin loyalitas anggota | 55 | Bilangan bulat $\ge 0$ | Ketua |

## 9. Kebutuhan non-fungsional data (volume, retensi, privasi)
- **Volume & Retensi**: Perkiraan $\pm150$ nota per hari; data transaksi disimpan minimal selama 5 tahun.
- **Privasi & Keamanan (Perbaikan Soal 2a)**: *"Sistem harus mengenkripsi kata sandi (password) anggota menggunakan algoritma hashing di dalam database, serta membatasi hak akses halaman profil hanya kepada anggota yang bersangkutan dan administrator."*
- **Kinerja Pencarian (Perbaikan Soal 2b)**: *"Sistem harus mampu menampilkan hasil pencarian data barang berdasarkan nama atau kode barang dalam waktu maksimal 2 detik setelah tombol cari ditekan."*
- **Keakuratan Laporan (Perbaikan Soal 2c)**: *"Sistem harus menyajikan laporan jumlah stok barang secara real-time yang otomatis dikurangi setiap kali transaksi penjualan berhasil divalidasi oleh kasir tanpa selisih perhitungan fisik."*

## 10. Isu kualitas data yang diantisipasi
- Perbedaan penulisan nama anggota atau ejaan pemasok pada saat input manual.
- Duplikasi data pendaftaran anggota melalui formulir online.
- Potensi selisih stok fisik gudang akibat kesalahan pencatatan manual sebelum sistem terkomputerisasi.