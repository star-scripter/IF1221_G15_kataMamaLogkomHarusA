:- include('kartu.pl').
:- include('aksi_pendukung.pl').
:- include('utilities.pl').
:- include('acak_dan_simpan_urutan.pl').

kartu_tumpuk(kartu(Warna,angka(_)),kartu(Warna,angka(_))).
kartu_tumpuk(kartu(_,angka(Angka)),kartu(_,angka(Angka))).

mainkanKartu(N):-
    urutan_pemain([Pemain|SisaUrutan]),
    tangan(Pemain, Tangan),
    Index is N - 1,
    (ambil_elemen(Index,Tangan, KartuDipilih, Sisa)->
        buang_kartu([KartuAtas|_]),

        (kartu_tumpuk(KartuDipilih,KartuAtas)->
        format('~w memainkan kartu: ', [Pemain]),
        cetak_nama_kartu(KartuDipilih), write('.'), nl,
        
        retract(tangan(Pemain, _)),
        assertz(tangan(Pemain, Sisa)),

        retract(buang_kartu(TumpukanLama)),
        assertz(buang_kartu([KartuDipilih|TumpukanLama])),

        rotate_player([Pemain|SisaUrutan]);
        write('Kartu tidak valid! Silakan masukkan pilihan kartu kembali.'), nl, fail
        )
    ;write('Nomor urut kartu tidak ada di tangan!'), nl, fail
    ).

% helper print



