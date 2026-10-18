# Dokumen Normalisasi dan Skema Relasional: Koperasi Mahasiswa Sejahtera (Kopma)

**Nama:** Shinta Amelia  
**NIM:** 25430064  
**Kelas:** C  
**Tema Studi Kasus:** Koperasi Mahasiswa (Kopma)  

---

## 1. Titik Awal: Bentuk Tak Beraturan (*Unnormalized Form* / UNF)
Bentuk UNF merepresentasikan seluruh data mentah dari dokumen sumber transaksi (Nota Penjualan Kopma) yang mencakup data anggota, petugas kasir, rincian barang yang dibeli (termasuk fitur poin loyalitas), serta data pembelian dari pemasok.

**KOPMA_UNF** (
  `no_nota_penjualan`, `tgl_penjualan`, `kode_petugas`, `nama_petugas`, `peran_petugas`, 
  `no_anggota`, `nim_anggota`, `nama_anggota`, `prodi_anggota`, `no_hp_anggota`, `status_anggota`, `tgl_daftar_anggota`, `jumlah_poin`, 
  { `kode_barang`, `nama_barang`, `kategori_barang`, `qty_detail_penjualan`, `harga_satuan_detail_penjualan`, `poin_didapat`, `poin_digunakan` }, 
  `bayar_penjualan`, 
  `no_faktur_pembelian`, `tgl_pembelian`, `nama_pemasok`, `telepon_pemasok`, `alamat_pemasok`, `status_pembelian`, `qty_detail_pembelian`, `harga_beli_detail_pembelian`
)

---

## 2. Bentuk Normal Pertama (*First Normal Form* / 1NF)
**Syarat 1NF:** Seluruh sel bernilai atomik (tidak ada grup berulang atau multi-nilai).  
**Tindakan:** Memisahkan kelompok berulang item barang pada penjualan menjadi baris-baris tersendiri. Kunci primer menjadi bersifat komposit.

**KOPMA_1NF** (
  <u>`no_nota_penjualan`</u>, <u>`kode_barang`</u>, `tgl_penjualan`, `kode_petugas`, `nama_petugas`, `peran_petugas`, `no_anggota`, `nim_anggota`, `nama_anggota`, `prodi_anggota`, `no_hp_anggota`, `status_anggota`, `tgl_daftar_anggota`, `jumlah_poin`, `nama_barang`, `kategori_barang`, `qty_detail_penjualan`, `harga_satuan_detail_penjualan`, `poin_didapat`, `poin_digunakan`, `bayar_penjualan`, `no_faktur_pembelian`, `tgl_pembelian`, `nama_pemasok`, `telepon_pemasok`, `alamat_pemasok`, `status_pembelian`, `qty_detail_pembelian`, `harga_beli_detail_pembelian`
)

* **Kunci Primer Komposit:** (`no_nota_penjualan`, `kode_barang`)

---

## 3. Daftar Dependensi Fungsional (*Functional Dependencies* / FD)
Ketergantungan fungsional diturunkan langsung dari Aturan Bisnis (AB) Kopma:

* **FD1:** `no_nota_penjualan` $\rightarrow$ `tgl_penjualan`, `kode_petugas`, `no_anggota`, `bayar_penjualan` (AB-01)
* **FD2:** `kode_petugas` $\rightarrow$ `nama_petugas`, `peran_petugas`
* **FD3:** `no_anggota` $\rightarrow$ `nim_anggota`, `nama_anggota`, `prodi_anggota`, `no_hp_anggota`, `status_anggota`, `tgl_daftar_anggota`, `jumlah_poin` (AB-05)
* **FD4:** `kode_barang` $\rightarrow$ `nama_barang`, `kategori_barang`, `harga_jual_barang`, `stok_barang`, `stok_min_barang`
* **FD5:** (`no_nota_penjualan`, `kode_barang`) $\rightarrow$ `qty_detail_penjualan`, `harga_satuan_detail_penjualan`, `poin_didapat`, `poin_digunakan` (AB-04)
* **FD6:** `no_faktur_pembelian` $\rightarrow$ `tgl_pembelian`, `nama_pemasok`, `telepon_pemasok`, `alamat_pemasok`, `status_pembelian` (AB-06)
* **FD7:** (`no_faktur_pembelian`, `kode_barang`) $\rightarrow$ `qty_detail_pembelian`, `harga_beli_detail_pembelian`

---

## 4. Bentuk Normal Kedua (*Second Normal Form* / 2NF)
**Syarat 2NF:** Memenuhi 1NF dan **tidak memiliki ketergantungan parsial** (atribut non-kunci bergantung penuh pada seluruh bagian kunci primer komposit).  
**Tindakan:** Memecah atribut-atribut yang hanya bergantung pada sebagian kunci komposit ke dalam entitas mandiri (`petugas`, `anggota`, `barang`, `pemasok`, `penjualan`, `detail_penjualan`, `pembelian`, `detail_pembelian`).

---

## 5. Bentuk Normal Ketiga (*Third Normal Form* / 3NF) & BCNF
**Syarat 3NF:** Memenuhi 2NF dan **tidak memiliki ketergantungan transitif** (atribut non-kunci tidak bergantung pada atribut non-kunci lainnya).  

Menerapkan standar **Kunci Pengganti (*Surrogate Key* / `id_*`)** sebagai *Primary Key* dan menjadikan kode alami sebagai *Unique Key* sesuai skema kanonik Kopma:

### Skema Relasional Final (3NF / BCNF):

1. **`petugas`**
   * **PK:** `id_petugas`
   * **UQ:** `kode_petugas`
   * **Atribut:** `nama_petugas`, `peran_petugas`

2. **`anggota`**
   * **PK:** `id_anggota`
   * **UQ:** `no_anggota`, `nim_anggota`
   * **Atribut:** `nama_anggota`, `prodi_anggota`, `no_hp_anggota`, `status_anggota`, `tgl_daftar_anggota`, `jumlah_poin`

3. **`barang`**
   * **PK:** `id_barang`
   * **UQ:** `kode_barang`
   * **Atribut:** `nama_barang`, `kategori_barang`, `harga_jual_barang`, `stok_barang`, `stok_min_barang`

4. **`pemasok`**
   * **PK:** `id_pemasok`
   * **Atribut:** `nama_pemasok`, `telepon_pemasok`, `alamat_pemasok`

5. **`penjualan`**
   * **PK:** `id_penjualan`
   * **UQ:** `no_nota_penjualan`
   * **FK1:** `id_petugas` $\rightarrow$ `petugas`(`id_petugas`)
   * **FK2:** `id_anggota` $\rightarrow$ `anggota`(`id_anggota`) *(Boleh NULL untuk pembeli umum)*
   * **Atribut:** `tgl_penjualan`, `bayar_penjualan`

6. **`detail_penjualan`**
   * **PK Komposit:** (`id_penjualan`, `id_barang`)
   * **FK1:** `id_penjualan` $\rightarrow$ `penjualan`(`id_penjualan`)
   * **FK2:** `id_barang` $\rightarrow$ `barang`(`id_barang`)
   * **Atribut:** `qty_detail_penjualan`, `harga_satuan_detail_penjualan`, `poin_didapat`, `poin_digunakan`

7. **`pembelian`**
   * **PK:** `id_pembelian`
   * **FK:** `id_pemasok` $\rightarrow$ `pemasok`(`id_pemasok`)
   * **Atribut:** `no_faktur_pembelian`, `tgl_pembelian`, `status_pembelian`

8. **`detail_pembelian`**
   * **PK Komposit:** (`id_pembelian`, `id_barang`)
   * **FK1:** `id_pembelian` $\rightarrow$ `pembelian`(`id_pembelian`)
   * **FK2:** `id_barang` $\rightarrow$ `barang`(`id_barang`)
   * **Atribut:** `qty_detail_pembelian`, `harga_beli_detail_pembelian`

---

## 6. Keputusan Nilai Turunan (*Derived Values*)
* **Subtotal per Baris:** `qty_detail_penjualan * harga_satuan_detail_penjualan`
* **Jumlah Total Nota & Kembalian:** Dihitung dari keseluruhan total baris dikurangi diskon/potongan poin.
* **Keputusan:** Nilai turunan seperti subtotal dan total harga **TIDAK DISIMPAN** di dalam tabel operasional.
* **Alasan:** Mencegah terjadinya anomali dan inkonsistensi data historis. Nilai-nilai ini dikalkulasikan secara langsung saat laporan dibutuhkan menggunakan fungsi agregat SQL (`SUM`).

---

## 7. Hasil Pemeriksaan BCNF
Seluruh tabel di atas telah memenuhi ketentuan BCNF karena setiap penentu (*determinant*) pada fungsional dependensi merupakan *candidate key*. Struktur data bersih dari anomali pembaruan, penyisipan, maupun penghapusan.

---

## 8. Latihan dan Modifikasi (Bagian E)

### 1. Normalisasi Pencatatan Multi-Nomor Telepon Pemasok
* **Masalah:** Jika sebuah entitas pemasok memiliki lebih dari satu nomor telepon, menyimpan atribut `telepon_pemasok` secara langsung di dalam tabel `pemasok` akan melanggar aturan atomisitas 1NF (terdapat multi-nilai/grup berulang pada satu kolom).
* **Solusi Normalisasi:** Memisahkan nomor telepon pemasok ke dalam tabel relasional tersendiri yang berelasi *One-to-Many* (1 pemasok memiliki banyak nomor telepon).

* **Skema Relasional Baru:**
  * **`pemasok`** (
      <u>`id_pemasok`</u>, `nama_pemasok`, `alamat_pemasok`
    )
  * **`telepon_pemasok`** (
      <u>`id_pemasok`*</u>, <u>`no_telepon`</u>
    )
    *(Kunci primer komposit pada tabel `telepon_pemasok` adalah gabungan `id_pemasok` dan `no_telepon`, memastikan tidak ada duplikasi nomor telepon untuk pemasok yang sama).*

---

### 2. Contoh Pelanggaran 3NF dan Simulasi Anomali Ubah (*Update Anomaly*)
* **Kasus Pelanggaran:** Jika kolom `nama_anggota` disimpan langsung di dalam tabel `penjualan` (bergantung pada `id_anggota` yang merupakan atribut non-kunci di tabel penjualan), maka terjadi **ketergantungan transitif** yang melanggar Bentuk Normal Ketiga (3NF).

* **Contoh Ilustrasi Data yang Melanggar 3NF (Tabel `penjualan`):**

| no_nota | tanggal_jam | no_anggota | nama_anggota | total_bayar |
| :--- | :--- | :--- | :--- | :--- |
| PJ-2609-0142 | 2026-10-18 08:30 | A-012 | Shinta Amelia | 50000 |
| PJ-2609-0155 | 2026-10-18 10:15 | A-012 | Shinta Amelia | 25000 |
| PJ-2609-0189 | 2026-10-18 14:00 | A-012 | Shinta Amelia | 42000 |

* **Anomali Ubah (*Update Anomaly*):**  
  Jika anggota dengan `no_anggota = 'A-012'` merubah penulisan nama profilnya di sistem, kueri harus memperbarui banyak baris transaksi lama secara berulang. Jika ada satu baris yang terlewat, data nama anggota menjadi tidak konsisten (*inconsistent data*)[cite: 7].

* **Kueri Ubah (UPDATE) yang Memperlihatkan Anomali:**
  ```sql
  -- Kueri ini berisiko menyebabkan inkonsistensi jika ada transaksi yang terlewat
  UPDATE Penjualan
  SET nama_anggota = 'Shinta Amelia Putri'
  WHERE no_anggota = 'A-012';