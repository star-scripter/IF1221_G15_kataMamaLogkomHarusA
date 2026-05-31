
kartu_tumpuk(kartu(_, draw_two), kartu(_, draw_two)) :- !, fail.
kartu_tumpuk(kartu(hitam, _), kartu(hitam,_)) :- !, fail.
kartu_tumpuk(kartu(hitam, _), _).
kartu_tumpuk(kartu(Warna, _), kartu(hitam, _)) :- warna_aktif(Warna).
kartu_tumpuk(kartu(Warna, _), kartu(Warna, _)).
kartu_tumpuk(kartu(_, Jenis), kartu(_, Jenis)).

mainkanKartu(N):-
    \+ game_start,
    write('Gamenya belum mulai!'), nl,
    !.

mainkanKartu(N):-
    urutan_pemain([Pemain|_]),
    penalti_aktif(wild_draw_four),
    format('Pemain ~w harus mengambil kartu atau menantang pemain sebelumnya',[Pemain]).
    
mainkanKartu(N):-
    \+ penalti_aktif(wild_draw_four),
    \+ penalti_aktif(draw_two),
    game_start,
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

        KartuDipilih = kartu(W, _),
        update_warna_aktif(W),

        retract(buang_kartu(TumpukanLama)),
        assertz(buang_kartu([KartuDipilih|TumpukanLama])),

        (KartuDipilih = kartu(hitam,wild_draw_four)->
            assertz(penalti_aktif(wild_draw_four)),
            pilih_warna,
            rotate_player
            ;
                (KartuDipilih = kartu(_,draw_two)->
                assertz(penalti_aktif(draw_two)),
                rotate_player
                ;
                efek(KartuDipilih)

                )

        )
        ;
        write('Kartu tidak valid! Silakan masukkan pilihan kartu kembali.'), nl, fail
        )
    ;write('Nomor urut kartu tidak ada di tangan!'), nl, fail
    ),
    detectEndgame.




