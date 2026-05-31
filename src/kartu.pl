
/* Kumpulan Fakta */
warna(merah).
warna(biru).
warna(kuning).
warna(hijau).

angka(0).
angka(1).
angka(2).
angka(3).
angka(4).
angka(5).
angka(6).
angka(7).
angka(8).
angka(9).

/* Kumpulan Aturan */
kartu_valid(hitam, wild).
kartu_valid(hitam, wild_draw_four).

kartu_valid(Warna, angka(Angka)) :-
    warna(Warna),
    angka(Angka).

kartu_valid(Warna, skip) :-
    warna(Warna).

kartu_valid(Warna, reverse) :-
    warna(Warna).

kartu_valid(Warna, draw_two) :-
    warna(Warna).

acak_deck([], []) :- !.
acak_deck(List, [Kartu|Acak]) :-
    length(List, Len),
    random(0, Len, IndeksAcak),
    ambil_elemen(IndeksAcak, List, Kartu, SisaList),
    acak_deck(SisaList, Acak).

ambil_elemen(0, [H|T], H, T).
ambil_elemen(N, [H|T], Elemen, [H|Sisa]) :-
    N > 0,
    N1 is N - 1,
    ambil_elemen(N1, T, Elemen, Sisa).

deck_generate(DeckAcak) :-
    findall(kartu(Warna, Jenis), kartu_valid(Warna, Jenis), Deck),
    acak_deck(Deck, DeckAcak).

% discard_pile([kartu(Warna, angka(Angka)) | SisaDeck], kartu(Warna, angka(Angka)), SisaDeck).
% ini yg td blm di-fix

discard_pile(Deck, KartuAwal, SisaDeck) :-
    length(Deck, Len),
    discard_pile_safe(Deck, KartuAwal, SisaDeck, Len).

discard_pile_safe([kartu(Warna, angka(Angka)) | SisaDeck], kartu(Warna, angka(Angka)), SisaDeck, _) :- !.

discard_pile_safe([KartuSpesial | SisaDeck], KartuAwal, SisaDeckSetelahBuang, Counter) :-
    Counter > 0,
    NewCounter is Counter - 1,
    app(SisaDeck, [KartuSpesial], DeckBaru),
    discard_pile_safe(DeckBaru, KartuAwal, SisaDeckSetelahBuang, NewCounter).

discard_pile_safe([Kartu | SisaDeck], Kartu, SisaDeck, 0) :- !.
