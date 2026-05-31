uni(N) :-
    ( 
        (urutan_pemain([Player|_]), tangan(Player, Hand), getLength(Hand, Len), Len =:= 2) -> uniHelper(N);
        write('Anda tidak dapat menyerukan UNI!'), nl,
        write('Anda ambil kartu...'), nl,
        ambilKartu
    ).

uniHelper(N):-
    urutan_pemain([Pemain|SisaUrutan]),
    tangan(Pemain, Tangan),
    Index is N - 1,
    (ambil_elemen(Index, Tangan, KartuDipilih, Sisa) ->
        buang_kartu([KartuAtas|_]),

        (kartu_tumpuk(KartuDipilih, KartuAtas) ->
            format('~w memainkan kartu: ', [Pemain]),
            cetak_nama_kartu(KartuDipilih), write('.'), nl,
            format('~w menyerukan UNI!', [Pemain]), nl, nl,
            
            retract(tangan(Pemain, _)),
            assertz(tangan(Pemain, Sisa)),

            KartuDipilih = kartu(W, _),
            update_warna_aktif(W),

            retract(buang_kartu(TumpukanLama)),
            assertz(buang_kartu([KartuDipilih|TumpukanLama])),

            assertz(status_uni(Pemain)),

            (KartuDipilih = kartu(hitam, wild_draw_four) ->
                (cekTipu(Sisa, KartuAtas) ->
                    assertz(playerTipu(Pemain, bohong))
                ;
                    assertz(playerTipu(Pemain, jujur))
                ),
                assertz(penalti_aktif(wild_draw_four)),
                pilih_warna,
                rotate_player
            ;
                (KartuDipilih = kartu(_, draw_two) ->
                    assertz(penalti_aktif(draw_two)),
                    rotate_player
                ;
                    efek(KartuDipilih)
                )
            )
        ;
            write('Kartu tidak valid! Silakan masukkan pilihan kartu kembali.'), nl, fail
        )
    ;
        write('Nomor urut kartu tidak ada di tangan!'), nl, fail
    ).