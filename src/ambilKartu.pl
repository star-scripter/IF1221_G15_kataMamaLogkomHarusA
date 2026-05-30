ambilKartu :-
    urutan_pemain([Pemain|SisaUrutan]),
    buang_kartu([KartuAtas|_]),
    (penalti_aktif(wild_draw_four)->
        urutan_pemain([PemainSekarang,PemainTarget|SisaUrutan]),
        draw(PemainTarget),
        draw(PemainTarget),
        draw(PemainTarget),
        draw(PemainTarget),
        retract(penalti_aktif(wild_draw_four))
        ;
 
        retract(deck_utama([KartuDitarik|SisaDeck])),
        assertz(deck_utama(SisaDeck)),
        
        retract(tangan(Pemain, TanganLama)),
        app(TanganLama, [KartuDitarik], TanganBaru),
        assertz(tangan(Pemain, TanganBaru)),

        format('~w mendapatkan kartu: ', [Pemain]),
        cetak_nama_kartu(KartuDitarik), nl
        
    ),
    (status_uni(Pemain) -> retract(status_uni(Pemain)); true),
    rotate_player.
    
    

