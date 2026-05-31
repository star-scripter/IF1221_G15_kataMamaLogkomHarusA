# Tugas Besar IF1221 - Logika Komputasional

```
__/\\\________/\\\__/\\\\\_____/\\\__/\\\\\\\\\\\_        
 _\/\\\_______\/\\\_\/\\\\\\___\/\\\_\/////\\\///__       
  _\/\\\_______\/\\\_\/\\\/\\\__\/\\\_____\/\\\_____      
   _\/\\\_______\/\\\_\/\\\//\\\_\/\\\_____\/\\\_____     
    _\/\\\_______\/\\\_\/\\\\//\\\\/\\\_____\/\\\_____    
     _\/\\\_______\/\\\_\/\\\_\//\\\/\\\_____\/\\\_____   
      _\//\\\______/\\\__\/\\\__\//\\\\\\_____\/\\\_____  
       __\///\\\\\\\\\/___\/\\\___\//\\\\\__/\\\\\\\\\\\_ 
        ____\/////////_____\///_____\/////__\///////////__                      
                              
```
## Gambaran Singkat Proyek
Proyek ini merupakan simulasi permainan kartu UNO yang dikembangkan menggunakan paradigma pemrograman deklaratif dengan bahasa pemrograman Prolog. Game sederhana ini mampu mendukung permainan 2-4 pemain secara lokal di dalam terminal dengan aturan umum UNO.

## Cara Menjalankan Program
> **Note:** Pastikan Git dan GNU Prolog sudah diinstal agar dapat mengakses dan menjalankan program ini.

1. Clone repository ini ke lokal melalui terminal: 

```
git clone https://github.com/star-scripter/IF1221_G15_kataMamaLogkomHarusA.git
```

2. Masuk ke dalam direktori source code `/src`: 

```
cd .\IF1221_G15_kataMamaLogkomHarusA\src
```

3. Buka GNU Prolog: 

```
gprolog
```

4. Muat file utama program ini:

```
| ?- [main].
```

5. Mulai permainan. Gunakan `startGame` untuk memulai permainan baru, atau `loadGame` untuk memuat permainan yang sebelumnya sudah disimpan.

## Struktur Repository
```text
IF1221_G15_kataMamaLogkomHarusA
├── docs
│   ├── Milestone1_G15.pdf
│   └── Milestone2_G15.pdf
├── src
│   ├── acak_dan_simpan_urutan.pl
│   ├── aksi_pendukung.pl
│   ├── ambilKartu.pl
│   ├── draw.pl
│   ├── endgame_detection.pl
│   ├── globals.pl
│   ├── kartu.pl
│   ├── main.pl
│   ├── mainkanKartu.pl
│   ├── saveload.pl
│   ├── tangkap.pl
│   ├── testing.pl
│   ├── text.txt
│   ├── uni.pl
│   ├── utilities.pl
│   ├── validasi_pemain.pl
│   └── warna_aktif.pl
└── README.md
```

## Anggota Kelompok
Kelompok 15: kataMamaLogkomHarusA
- Jovan Nathanael - 13525087
- Raymond Edson Sabajan - 13525126
- Hugo Daniel Johansen Napitupulu - 13525049
- Matthew Allen Reynaldo - 13525001

---

