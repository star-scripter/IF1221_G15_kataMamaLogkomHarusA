:-include('kartu.pl').
:-include('utilities.pl').

ambilKartu :-
    urutan_pemain([Pemain|SisaUrutan]),
    retract(deck_utama([KartuDitarik|SisaDeck])),
    assertz(deck_utama(SisaDeck)),
    
    (status_uni(Pemain) -> retract(status_uni(Pemain)); true),

    retract(tangan(Pemain, TanganLama)),
    app(TanganLama, [KartuDitarik], TanganBaru),
    assertz(tangan(Pemain, TanganBaru)),

    format('~w mendapatkan kartu: ', [Pemain]),
    cetak_nama_kartu(KartuDitarik), nl,

    rotate_player([Pemain|SisaUrutan]), !.
    

