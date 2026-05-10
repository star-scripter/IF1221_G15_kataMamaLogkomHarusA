# Dokumentasi Kartu.pl
File `kartu.pl` digunakan untuk membuat mekanisme kartu di game UNI ini.

## Fakta
- `warna(Warna).`: Mendefinisikan warna dasar dalam permainan ini:
  - 4 fakta warna: merah, kuning, hijau, biru.

- `angka(Angka).`: Mendefinisikan angka yang valid untuk kartu angka:
  - 10 fakta angka dari nomor 0 hingga 9.

## Rule

### Rule 1: `kartu_valid`
Menentukan syarat kombinasi kartu sah dalam deck. Antara:
  - Kartu angka dengan warna
  - Kartu aksi dengan warna
  - Kartu spesial dengan khusus warna hitam
- Cara kerja:
  - Kartu hitam (wild dan wild_draw_four) ditulis sebagai fakta, karena tidak bisa berupa warna lain.
  - Kartu angka dan kartu aksi menggunakan variabel bebas (Warna dan Angka) agar Prolog bisa backtracking dan menyilang semua kemungkinan warna dengan angka/aksi-nya.

### Rule 2: `acak_deck`
Algoritma custom shuffle untuk mengacak urutan list.
- Cara kerja:
  - Prolog hitung total kartu yang ada di list dengan fungsi `length`.
  - Sebuah angka acak dibangkitkan dengan fungsi `random` dari 0 hingga batas panjang list, disimpan ke `IndeksAcak`.
  - Fungsi memanggil fungsi lain, `ambil_elemen`, dijelaskan di [Rule 3](#rule-3-ambil_elemen), untuk akses elemen kartu di indeks acak itu.
  - Secara rekursif, deck sisa yang belum diacak akan dimasukkan kembali ke fungsi `acak_deck`, hingga semua sudah tidak ada yang bisa diacak lagi (list kosong).

### Rule 3: `ambil_elemen`
Algoritma khusus untuk mengakses elemen pada list menggunakan rekursi.
- Cara kerja:
  - Base case: `ambil_elemen(0, [H|T], H, T).`; Jika indeks dicari adalah 0, langsung ambil elemen paling depan (`H`), sisanya adalah `T`.
  - Recursive case: Kurangi terus indeksnya sampai ketemu 0. Kalau belum nol, intinya pass saja; abaikan nilai headnya.

### Rule 4: `deck_generate`
- Cara kerja:
  - Program backtracking menggunakan predikat built-in `findall` untuk mencari semua kemungkinan kartu valid yang ada.
  - Kemudian, deck yang sudah dibentuk dengan rapi diacak dengan memanggil fungsi `acak_deck`.

### Rule 5: `discard_pile`
- Cara kerja:
  - Ambil kartu pertama sambil memeriksa apakah kartu pertama itu angka atau tidak, dengan menggunakan `[kartu(Warna, angka(Angka)) | SisaDeck]`. 
  - Jika benar kartu teratas itu kartu angka, maka langsung ditetapkan sebagai kartu awal di meja, dan `SisaDeck` bisa langsung distack dan dimainkan.