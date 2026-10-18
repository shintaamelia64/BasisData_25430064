# Dokumen Normalisasi dan Skema Relasional: Toko Daring Shinta

**Nama:** Shinta Amelia  
**NIM:** 25430064  
**Kelas:** Ilmu Komputer  
**Tema Proyek:** Toko Daring Shinta

---

## 1. Titik Awal: Bentuk Tak Beraturan (*Unnormalized Form* / UNF)
Bentuk UNF direpresentasikan berdasarkan dokumen sumber Nota Digital / Halaman Pesanan. Pada bentuk ini, masih terdapat grup berulang (*repeating group*) untuk item produk yang dibeli dalam satu nomor pesanan, serta atribut pelanggan, pembayaran, dan pengiriman yang menyatu.

**NOTA_UNF** (
  `no_pesanan`, `tgl_pesanan`, `id_pelanggan`, `email_pelanggan`, `nama_pelanggan`, `no_hp_pelanggan`, `alamat_pelanggan`, 
  { `kode_produk`, `nama_produk`, `kategori`, `qty_pesanan`, `harga_saat_beli` }, 
  `metode_bayar`, `tgl_bayar`, `jumlah_bayar`, `status_bayar`, 
  `kurir`, `no_resi`, `biaya_ongkir`, `status_kirim`, `status_pesanan`
)

---

## 2. Bentuk Normal Pertama (*First Normal Form* / 1NF)
**Syarat 1NF:** Seluruh sel bernilai atomik (tidak ada grup berulang atau multi-nilai).  
**Tindakan:** Grup berulang produk dikeluarkan menjadi baris-baris tersendiri. Kunci primer menjadi bersifat komposit (gabungan `no_pesanan` dan `kode_produk`).

**NOTA_1NF** (
  <u>`no_pesanan`</u>, <u>`kode_produk`</u>, `tgl_pesanan`, `id_pelanggan`, `email_pelanggan`, `nama_pelanggan`, `no_hp_pelanggan`, `alamat_pelanggan`, `nama_produk`, `kategori`, `qty_pesanan`, `harga_saat_beli`, `metode_bayar`, `tgl_bayar`, `jumlah_bayar`, `status_bayar`, `kurir`, `no_resi`, `biaya_ongkir`, `status_kirim`, `status_pesanan`
)

* **Kunci Primer Komposit:** (`no_pesanan`, `kode_produk`)

---

## 3. Daftar Dependensi Fungsional (*Functional Dependencies* / FD)
Ketergantungan fungsional berikut diturunkan dari Aturan Bisnis (AB) Toko Daring Shinta:

* **FD1:** `no_pesanan` $\rightarrow$ `tgl_pesanan`, `id_pelanggan`, `status_pesanan` (Satu pesanan memiliki satu tanggal, satu pelanggan, dan satu status)
* **FD2:** `id_pelanggan` $\rightarrow$ `email_pelanggan`, `nama_pelanggan`, `no_hp_pelanggan`, `alamat_pelanggan`
* **FD3:** `kode_produk` $\rightarrow$ `nama_produk`, `kategori`, `harga_produk`, `stok_produk`
* **FD4:** (`no_pesanan`, `kode_produk`) $\rightarrow$ `qty_pesanan`, `harga_saat_beli` (AB-03: harga jual saat transaksi disimpan permanen per detail pesanan)
* **FD5:** `no_pesanan` $\rightarrow$ `tgl_bayar`, `metode_bayar`, `jumlah_bayar`, `status_bayar`
* **FD6:** `no_pesanan` $\rightarrow$ `kurir`, `no_resi`, `biaya_ongkir`, `status_kirim`

---

## 4. Bentuk Normal Kedua (*Second Normal Form* / 2NF)
**Syarat 2NF:** Memenuhi 1NF dan **tidak memiliki ketergantungan parsial** (semua atribut non-kunci harus bergantung pada seluruh bagian kunci komposit, bukan sebagian saja).  

**Analisis:**  
* `nama_produk` dan `kategori` hanya bergantung pada `kode_produk` (sebagian kunci komposit).  
* Atribut pesanan dan pelanggan hanya bergantung pada `no_pesanan`.  

**Tindakan:** Memecah relasi 1NF menjadi entitas-entitas independen:

* **PESANAN** (<u>`no_pesanan`</u>, `tgl_pesanan`, `id_pelanggan`, `status_pesanan`)
* **PELANGGAN** (<u>`id_pelanggan`</u>, `email_pelanggan`, `nama_pelanggan`, `no_hp_pelanggan`, `alamat_pelanggan`)
* **PRODUK** (<u>`kode_produk`</u>, `nama_produk`, `kategori`, `harga_produk`, `stok_produk`)
* **DETAIL_PESANAN** (<u>`no_pesanan`*</u>, <u>`kode_produk`*</u>, `qty_pesanan`, `harga_saat_beli`)
* **PEMBAYARAN** (<u>`id_pembayaran`</u>, `no_pesanan`*, `tgl_bayar`, `metode_bayar`, `jumlah_bayar`, `status_bayar`)
* **PENGIRIMAN** (<u>`id_pengiriman`</u>, `no_pesanan`*, `kurir`, `no_resi`, `biaya_ongkir`, `status_kirim`)

---

## 5. Bentuk Normal Ketiga (*Third Normal Form* / 3NF) & BCNF
**Syarat 3NF:** Memenuhi 2NF dan **tidak memiliki ketergantungan transitif** (atribut non-kunci tidak bergantung pada atribut non-kunci lainnya).  

**Penerapan Kunci Pengganti (*Surrogate Key*):**  
Untuk mempermudah pengindeksan dan integrasi basis data fisik, kunci pengganti `id_<nama_tabel>` digunakan sebagai Kunci Primer (PK), sedangkan kode alami seperti `no_pesanan` dan `kode_produk` dijadikan Kunci Unik (*Unique Key*).

### Skema Relasional Final (3NF / BCNF):

1. **`pelanggan`**
   * **PK:** `id_pelanggan`
   * **Atribut:** `email_pelanggan`, `nama_pelanggan`, `no_hp_pelanggan`, `alamat_pelanggan`
   * **Keterangan:** Mengisolasi data pribadi pelanggan.

2. **`produk`**
   * **PK:** `id_produk`
   * **UQ:** `kode_produk`
   * **Atribut:** `nama_produk`, `kategori`, `harga_produk`, `stok_produk`

3. **`pesanan`**
   * **PK:** `id_pesanan`
   * **UQ:** `no_pesanan`
   * **FK:** `id_pelanggan` $\rightarrow$ `pelanggan`(`id_pelanggan`)
   * **Atribut:** `tgl_pesanan`, `status_pesanan`

4. **`detail_pesanan`**
   * **PK Komposit:** (`id_pesanan`, `id_produk`)
   * **FK1:** `id_pesanan` $\rightarrow$ `pesanan`(`id_pesanan`)
   * **FK2:** `id_produk` $\rightarrow$ `produk`(`id_produk`)
   * **Atribut:** `qty_pesanan`, `harga_saat_beli`

5. **`pembayaran`**
   * **PK:** `id_pembayaran`
   * **FK:** `id_pesanan` $\rightarrow$ `pesanan`(`id_pesanan`)
   * **Atribut:** `tgl_bayar`, `metode_bayar`, `jumlah_bayar`, `status_bayar`

6. **`pengiriman`**
   * **PK:** `id_pengiriman`
   * **FK:** `id_pesanan` $\rightarrow$ `pesanan`(`id_pesanan`)
   * **Atribut:** `kurir`, `no_resi`, `biaya_ongkir`, `status_kirim`

---

## 6. Keputusan Nilai Turunan (*Derived Values*)
* **Subtotal Item:** `subtotal = qty_pesanan * harga_saat_beli`  
* **Total Pembayaran:** `total = SUM(subtotal) + biaya_ongkir`  
* **Keputusan:** Nilai subtotal dan total **TIDAK DISIMPAN** dalam tabel operasional/transaksional.  
* **Alasan:** Menyimpan nilai turunan berisiko menimbulkan inkonsistensi data jika terjadi perubahan baris detail. Nilai subtotal dan total akan dihitung secara langsung (*real-time*) menggunakan kueri agregasi SQL (`SUM` dan operasi aritmatika) pada laporan/penyajian data.

---

## 7. Hasil Pemeriksaan BCNF
Seluruh entitas yang dihasilkan pada tahap 3NF telah memenuhi kriteria BCNF karena setiap penentu (*determinant*) pada ketergantungan fungsional merupakan kunci kandidat (*candidate key*). Struktur ini dipastikan aman dan bebas dari anomali ubah, sisip, maupun hapus.