# Building a Cohort Table with SQL: Customer Retention Analysis

## Apa itu cohort?
Cohort atau analisis cohort, yaitu metode analisis yang mengelompokkan data berdasarkan karakteristik tertentu dalam periode waktu tertentu. Misalnya pengelompokan berdasarkan tanggal klien registrasi atau tanggal pembelian pertama. Analisis ini sering digunakan untuk analisis retensi klien, yaitu untuk memahami bagaimana kelompok klien tertentu bertahan atau berperilaku seiring waktu, seperti berapa banyak user yang membeli 2x, 3x, 4x dstnya.

## Mengapa membuat tabel Cohort langsung dengan SQL?
Dengan query yang sudah kita buat, kita hanya perlu query ulang atau bahkan dapat diotomasi sehingga data yang tersaji hampir _real time_. Otomasi dapat dilakukan menggunakan tools visualisasi data seperti Metabase.

## Note
Contoh code ini berdasarkan PostgreSQL, perlu penyesuaian code jika digunakan pada database berbasis SQL lainnya.

# Query untuk Membuat Tabel Cohort
## 1. Siapkan Query Source
Buat CTE Source berisi query paid invoices, dengan detail minimal seperti client_id, invoice_id, paid_at. Pastikan query juga mencakup code untuk cleaning data dan tambahkan kolom number_purchase.
![image](https://github.com/user-attachments/assets/d3aade1d-fe15-4ae9-b8a5-33927d114372)

## 2. Buat CTE Cohort
CTE Cohort berisi kolom waktu cohort pada contoh satuan waktunya adalah bulan dan melakukan filter hanya mengambil klien baru pertama kali melakukan pembelian pada bulan tersebut.
![image](https://github.com/user-attachments/assets/b76ddf91-9ce5-4c57-b019-e2dfa58bc500)

 
## 3. Gabungkan CTE Source dengan CTE Cohort
Penggabungan ini untuk menghitung jumlah klien yang baru pertama kali melakukan pembelian pada bulan tersebut dan menghitung berapa banyak klien yang repeat order (number_purchase) 2x,3x,4x dstnya.
![image](https://github.com/user-attachments/assets/986ce79a-b23f-46b1-a2d0-93f82339a947)

## 4. Memunculkan Tabel Cohort
Tahap akhirnya adalah tinggal memanggil seluruh kolom dari hasil penggabungan (retention table).

![image](https://github.com/user-attachments/assets/edc18c04-9978-4abc-9016-d3e742d6dcad)

Berikut adalah contoh output Tabel Cohort

![image](https://github.com/user-attachments/assets/af979bb1-211d-4ca6-bf2c-3d11e04ad2ca)

