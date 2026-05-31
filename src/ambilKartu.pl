ambilKartu :-
    \+ game_start,
    write('Gamenya belum mulai!'), nl,
    !.
ambilKartu :-
    game_start,
    urutan_pemain([Pemain|SisaUrutan]),
    buang_kartu([KartuAtas|_]),
    (penalti_aktif(wild_draw_four)->
        efek(kartu(hitam,wild_draw_four))
        
        ;
        (penalti_aktif(draw_two)->
        efek(kartu(_,draw_two))
        ;
        retract(deck_utama([KartuDitarik|SisaDeck])),
        assertz(deck_utama(SisaDeck)),
        
        retract(tangan(Pemain, TanganLama)),
        app(TanganLama, [KartuDitarik], TanganBaru),
        assertz(tangan(Pemain, TanganBaru)),

        format('~w mendapatkan kartu: ', [Pemain]),
        cetak_nama_kartu(KartuDitarik), nl
        )
        
    ),
    (status_uni(Pemain) -> retract(status_uni(Pemain)); true),
    rotate_player.
    
    

