:-include('kartu.pl').
:-include('utilities.pl').

draw(Pemain):-
    retract(deck_utama([KartuDiambil|SisaDeck])),
    assertz(deck_utama(SisaDeck)),
    retract(tangan(Pemain, TanganLama)),
    app(TanganLama, [KartuDitarik], TanganBaru),
    assertz(tangan(Pemain, TanganBaru)),

draw2(_,draw_two):-
    urutan_pemain([PemainSekarang,PemainTarget|Tangan]),
    draw(PemainTarget),
    draw(PemainTarget),
    app(SisaUrutan, [PemainSekarang, PemainTarget], UrutanBaru)
    retract(urutan_pemain(_)),
    assertz(urutan_pemain(UrutanBaru)),
    UrutanBaru = [Next|_],
    format('Giliran ~w.~n', [Next]).

    
