# Dokumen Kebutuhan Data:  Toko Daring Shinta

## 1. Latar Belakang dan Aktivitas Organisasi
Organisasi fiktif ini bernama **Toko Daring Shinta ** dengan NIM **25430064**[cite: 1, 43]. Organisasi ini bergerak di bidang perdagangan elektronik yang menyediakan layanan jual beli produk secara online untuk memudahkan pelanggan memilih katalog, mengelola keranjang belanja, memproses pesanan, pembayaran, hingga pengiriman barang ke seluruh wilayah[cite: 24].

## 2. Aktor dan Proses Bisnis (Tabel PB)
| Kode | Proses Bisnis | Aktor | Pemicu |
|---|---|---|---|
| PB-01 | Mendaftarkan Pelanggan | Admin / Sistem | Pengguna ingin mendaftar akun baru |
| PB-02 | Mengelola Katalog Produk | Admin Gudang | Penambahan atau pembaruan stok dan barang |
| PB-03 | Melakukan Pemesanan | Pelanggan | Pelanggan checkout keranjang belanja |
| PB-04 | Memverifikasi Pembayaran | Bagian Keuangan | Pelanggan mengunggah bukti transfer/bayar |
| PB-05 | Pengiriman Pesanan | Bagian Pengiriman | Pembayaran telah terverifikasi lunas |

## 3. Dokumen Sumber yang Dianalisis
- **Halaman Pesanan / Nota Digital**: Memuat nomor pesanan, tanggal, data pelanggan, daftar produk yang dibeli, kuantitas, harga satuan, biaya ongkir, dan total pembayaran[cite: 57].

## 4. Entitas Kandidat dan Elemen Data
1. **Pelanggan**: `id_pelanggan`, `email_pelanggan`, `nama_pelanggan`, `no_hp_pelanggan`, `alamat_pelanggan`[cite: 24].
2. **Produk**: `id_produk`, `kode_produk`, `nama_produk`, `kategori`, `harga_produk`, `stok_produk`[cite: 24].
3. **Pesanan**: `id_pesanan`, `no_pesanan`, `tgl_pesanan`, `id_pelanggan`, `status_pesanan`[cite: 24].
4. **Detail Pesanan**: `id_pesanan`, `id_produk`, `qty_pesanan`, `harga_saat_beli`[cite: 19].
5. **Pembayaran**: `id_pembayaran`, `id_pesanan`, `tgl_bayar`, `metode_bayar`, `jumlah_bayar`, `status_bayar`[cite: 24].
6. **Pengiriman**: `id_pengiriman`, `id_pesanan`, `kurir`, `no_resi`, `biaya_ongkir`, `status_kirim`[cite: 24].

## 5. Aturan Bisnis (Tabel AB)
- **AB-01**: Setiap pesanan wajib memiliki nomor pesanan unik dan minimal 1 item produk (maksimal item per transaksi sesuai parameter $P+2 = 4$ item)[cite: 20, 57].
- **AB-02**: Stok produk tidak boleh bernilai negatif; pesanan ditolak otomatis jika kuantitas melebihi stok tersedia[cite: 20].
- **AB-03**: Harga jual produk pada detail pesanan disimpan permanen saat transaksi dilakukan meskipun harga produk berubah di kemudian hari[cite: 20].

## 6. Kebutuhan Informasi (Tabel KI)
- **KI-01**: Laporan omzet dan jumlah pesanan harian serta bulanan.
- **KI-02**: Daftar 5 produk terlaris berdasarkan kuantitas penjualan per bulan.
- **KI-03**: Laporan produk dengan stok di bawah batas minimum.
- **KI-04**: Daftar 10 pelanggan dengan total nominal belanja terbesar.
- **KI-05**: Laporan status pengiriman pesanan yang belum selesai.

## 7. Matriks CRUD
| Proses Bisnis | Pelanggan | Produk | Pesanan | Detail Pesanan | Pembayaran | Pengiriman |
|---|---|---|---|---|---|---|
| PB-01 Daftar | C | | | | | |
| PB-02 Katalog | | C, U | | | | |
| PB-03 Pesan | R | R, U | C | C | | |
| PB-04 Bayar | | | U | | C | |
| PB-05 Kirim | | | U | | | C |

## 8. Kamus Data Awal
| Elemen Data | Arti | Contoh Nilai | Aturan / Format | Penanggung Jawab |
|---|---|---|---|---|
| `no_pesanan` | Nomor unik transaksi | ORD-202610-001 | Unik, string terformat | Admin Toko |
| `stok_produk` | Jumlah barang tersedia | 45 | Bilangan bulat $\ge 0$ | Admin Gudang |
| `no_hp_pelanggan`| Nomor kontak pribadi | 08123456789 | Data pribadi, akses terbatas | Pimpinan |

## 9. Kebutuhan Non-Fungsional & Parameter P
- **Volume Transaksi**: Perkiraan $\pm 50$ pesanan per hari (berdasarkan parameter $P=2$)[cite: 57].
- **Retensi Data**: Riwayat transaksi disimpan minimal selama 5 tahun[cite: 21].
- **Privasi Data**: Nomor telepon dan alamat pelanggan dikategorikan sebagai data pribadi yang hanya dapat diakses oleh pihak berwenang sesuai UU PDP[cite: 21, 22].

## 10. Isu Kualitas Data yang Diantisipasi
- Potensi kesalahan penulisan format nomor telepon dan perbedaan variasi penulisan nama produk pada data masukan awal[cite: 103].