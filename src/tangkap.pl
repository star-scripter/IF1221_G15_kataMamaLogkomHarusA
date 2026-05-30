tangkap(Player) :-
    tangan(Player, Hand), 
    getLength(Hand, 1),
    \+ status_uni(Player), !,
    format('~w tertangkap tidak menyerukan UNI.', [Player]), nl,
    format('~w mendapatkan 2 kartu penalti.', [Player]), nl,

    urutan_pemain(Current),

    rotateUntil(Player, Current, Rotation),
    retract(urutan_pemain(_)),
    assertz(urutan_pemain(Rotation)),

    accPenalty,
    accPenalty,
    retract(urutan_pemain(_)),
    assertz(urutan_pemain(Current)),
    rotate_player. 
tangkap(Player) :-
    status_uni(Player),
    urutan_pemain([H|_]),
    format('~w sudah menyerukan UNI!!.', [Player]), nl,
    format('~w mendapatkan 1 kartu penalti', [H]), nl,
    ambilKartu.
tangkap(_) :-
    write('Perintah tidak valid!'), nl.

rotateUntil(_,[],[]).
rotateUntil(Head,[Head|_],[Head|_]).
rotateUntil(Player, [Head|Tail], Result) :-
    Head \= Player,
    app(Tail, [Head], Result1),
    rotateUntil(Player, Result1, Result).

/* ganti dengan func draw ntar */
accPenalty :-
    urutan_pemain([Pemain|SisaUrutan]),
    retract(deck_utama([KartuDitarik|SisaDeck])),
    assertz(deck_utama(SisaDeck)),

    retract(tangan(Pemain, TanganLama)),
    app(TanganLama, [KartuDitarik], TanganBaru),
    assertz(tangan(Pemain, TanganBaru)),

    format('~w mendapatkan kartu: ', [Pemain]),
    cetak_nama_kartu(KartuDitarik), nl.