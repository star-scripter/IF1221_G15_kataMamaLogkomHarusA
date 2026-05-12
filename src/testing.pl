test_bagi_kartu :-
    retractall(tangan(_, _)),
    retractall(deck_utama(_)),
    retractall(buang_kartu(_)),

    ListPemain = [hugo, raymond],
    write('Test dengan dua pemain: '), write(ListPemain), nl,

    deck_generate(DeckAwal),
    length(DeckAwal, LenDeck),
    write('Deck awal memiliki '), write(LenDeck), write(' kartu.'), nl,

    bagi_ke_semua_pemain(ListPemain, DeckAwal, SisaDeck),
    write('Berhasil bagi kartu ke hugo dan raymond.'), nl,

    discard_pile(SisaDeck, KartuAwal, SisaDeckSetelahBuang),
    assertz(buang_kartu([KartuAwal])),
    assertz(deck_utama(SisaDeckSetelahBuang)),

    nl, write('Kartu awal di tengah: '), write(KartuAwal), nl,
    length(SisaDeckSetelahBuang, LenSisaDeck),
    write('Sisa deck setelah buang kartu awal memiliki '), write(LenSisaDeck), write(' kartu.'), nl,

    tangan(hugo, TanganHugo),
    tangan(raymond, TanganRaymond),

    length(TanganHugo, LenHugo),
    length(TanganRaymond, LenRaymond),

    write('Hugo memiliki '), write(LenHugo), write(' kartu.'), nl,
    write('Raymond memiliki '), write(LenRaymond), write(' kartu.'), nl,

    write("Kartu Hugo: "), write(TanganHugo), nl,
    write("Kartu Raymond: "), write(TanganRaymond), nl.

