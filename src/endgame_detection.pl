:- dynamic(final_score/4). 
/*nama, TotalPoints, jumlah kartu, urutanmain*/

detectEndgame :-
    urutan_pemain(Urutan),
    isInList(Player, Urutan),
    tangan(Player, Hand),
    getLength(Hand, 0), !,
    
    format('Permainan selesai! ~w telah menghabiskan semua Kartunya', [Player]), nl,
    nl,
    write('Berikut perhitungan poin sisa kartu.'), nl,
    
    retractall(final_score(_, _, _, _)),
    
    processAllPlayers(Urutan, 1),
    nl,
    
    gatherWinners(Urutan, []).

detectEndgame. % ini untuk bugfix td -jovan yg pasang

parseCardPoints(kartu(_, angka(0)), 1) :- !.
parseCardPoints(kartu(_, angka(X)), X) :- !.
parseCardPoints(kartu(_, skip), 10) :- !.
parseCardPoints(kartu(_, reverse), 10) :- !.
parseCardPoints(kartu(_, draw_two), 10) :- !.
parseCardPoints(kartu(warna(hitam), _), 20) :- !.

processAllPlayers([], _).
processAllPlayers([Player|Rest], Index) :-
    tangan(Player, Hand),
    getLength(Hand, TotalCards),
    format('~w: ', [Player]),
    (
        TotalCards =:= 0 -> write('kartu habis = 0 poin'), nl, assertz(final_score(Player, 0, 0, Index));
        countAndPrintCards(Hand, TotalPoints),
        format(' = ~d poin', [TotalPoints]), nl,
        assertz(final_score(Player, TotalPoints, TotalCards, Index))
    ),
    NextIndex is Index + 1,
    processAllPlayers(Rest, NextIndex).

countAndPrintCards(Hand, TotalPoints) :-
    printAllNames(Hand),
    write(' = '),
    printAllPoints(Hand, TotalPoints).

printAllNames([Card]) :- !,
    cetak_nama_kartu(Card).
printAllNames([Card|Rest]) :-
    cetak_nama_kartu(Card), write(' + '),
    printAllNames(Rest).

printAllPoints([Card], Poin) :- !,
    parseCardPoints(Card, Poin),
    format('~d', [Poin]).
printAllPoints([Card|Rest], TotalPoints) :-
    parseCardPoints(Card, Poin),
    format('~d + ', [Poin]),
    printAllPoints(Rest, RestPoin),
    TotalPoints is Poin + RestPoin.

gatherWinners([], ListTerurut) :-
    write('Urutan pemenang:'), nl,
    printWinners(ListTerurut, 1),
    ListTerurut = [score(Juara, _, _, _)|_],
    nl, format('Selamat, ~w menjadi pemenang!', [Juara]), nl.
gatherWinners([Player|Rest], Akumulator) :-
    final_score(Player, Poin, SisaKartu, UrutanMain),
    insertSort(score(Player, Poin, SisaKartu, UrutanMain), Akumulator, NewAkumulator),
    gatherWinners(Rest, NewAkumulator).

orderHelper(score(_, P1, _, _), score(_, P2, _, _)) :- P1 < P2, !.
orderHelper(score(_, P1, K1, _), score(_, P2, K2, _)) :- P1 =:= P2, K1 < K2, !.
orderHelper(score(_, P1, K1, I1), score(_, P2, K2, I2)) :- P1 =:= P2, K1 =:= K2, I1 < I2.

insertSort(X, [], [X]) :- !.
insertSort(X, [H|T], [X,H|T]) :-
    orderHelper(X, H), !.
insertSort(X, [H|T], [H|NewT]) :-
    insertSort(X, T, NewT).

printWinners([], _).
printWinners([score(P, S, _, _)|Rest], Rank) :-
    format('~d. ~w (~d poin)', [Rank, P, S]), nl,
    NextRank is Rank + 1,
    printWinners(Rest, NextRank).