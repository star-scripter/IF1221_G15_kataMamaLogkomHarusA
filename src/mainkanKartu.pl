
kartu_tumpuk(kartu(hitam, _), kartu(hitam,_)):-!,fail.
kartu_tumpuk(kartu(hitam, _), _).
kartu_tumpuk(kartu(Warna,angka(_)),kartu(Warna,angka(_))).
kartu_tumpuk(kartu(_,angka(Angka)),kartu(_,angka(Angka))).
kartu_tumpuk(kartu(_, draw_two), kartu(_, draw_two)):- !, fail.
% kartu_tumpuk(kartu(warna_aktif(WarnaSekarang),_),kartu(Warna,angka(_))).

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
        efek(KartuDipilih),
        rotate_player;
        write('Kartu tidak valid! Silakan masukkan pilihan kartu kembali.'), nl, fail
        )
    ;write('Nomor urut kartu tidak ada di tangan!'), nl, fail
    ).

% helper print



