
kartu_tumpuk(kartu(hitam, _), kartu(hitam,_)):-!,fail.
kartu_tumpuk(kartu(hitam, _), _).
kartu_tumpuk(kartu(Warna,_),kartu(hitam,_)):-warna_aktif(Warna).
kartu_tumpuk(kartu(Warna,angka(_)),kartu(Warna,angka(_))).
kartu_tumpuk(kartu(_,angka(Angka)),kartu(_,angka(Angka))).
kartu_tumpuk(kartu(Warna, draw_two),kartu(Warna,angka(_))).
kartu_tumpuk(kartu(_, draw_two), kartu(_, draw_two)):- !, fail.
kartu_tumpuk(kartu(Warna, skip), kartu(Warna, angka(_))).
kartu_tumpuk(kartu(_, skip), kartu(_, skip)).
kartu_tumpuk(kartu(Warna, reverse), kartu(Warna, angka(_))).
kartu_tumpuk(kartu(_, reverse), kartu(_, reverse)).


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
        print(1), nl,
        assertz(tangan(Pemain, Sisa)),
        print(2), nl,

        % KartuDipilih = kartu(warna(W), _),
        % print(3), nl,
        % update_warna_aktif(W),
        % print(4), nl,

        retract(buang_kartu(TumpukanLama)),
        print(5), nl,
        assertz(buang_kartu([KartuDipilih|TumpukanLama])),
        print(6), nl,

        (KartuDipilih = kartu(hitam,wild_draw_four)->
            pilih_warna,
            print('cao'), nl,
            rotate_player
            ;
            (KartuDipilih = kartu(_,draw_two)->
                print('ni'), nl,
                rotate_player
                ;
                print('gga'), nl,
                efek(KartuDipilih),
                rotate_player
            )
        )
        ;
        write('Kartu tidak valid! Silakan masukkan pilihan kartu kembali.'), nl, fail
        )
    ;write('Nomor urut kartu tidak ada di tangan!'), nl, fail
    ),
    detectEndgame.




