:- dynamic(temp_result/1).

delete_element([_|Tail], 0, Tail).
delete_element([Head|Tail], Index, [Head|UpdatedTail]) :-
    Index > 0,
    NewIdx is Index - 1,
    delete_element(Tail, NewIdx, UpdatedTail).

get_index([Element|_], Element, 0).
get_index([_|Tail], Element, Index) :-
    get_index(Tail, Element, TailIndex),
    Index is TailIndex + 1.

get_element([Elem|_], 0, Elem).
get_element([_|T], Idx, Elem):-
    Idx > 0,
    NewIdx is Idx - 1,
    get_element(T, NewIdx, Elem).

isInList(Elem, [Elem|_]).
isInList(Elem, [_|T]) :-
    isInList(Elem, T).

rotate_player:-
    urutan_pemain([Pemain|Sisa]),
    app(Sisa, [Pemain], UrutanBaru),
    retractall(urutan_pemain(_)),
    assertz(urutan_pemain(UrutanBaru)),
    UrutanBaru = [Next|_],
    format('Giliran ~w.~n', [Next]).

reverse_list([], Acc, Acc).
reverse_list([H|T], Acc, Rev):-
  reverse_list(T, [H|Acc], Rev).

cetak_nama_kartu(kartu(Warna, angka(Angka))) :- !, format('~w-~d', [Warna, Angka]).
cetak_nama_kartu(kartu(Warna, Jenis)) :- format('~w-~w', [Warna, Jenis]).

app([], L, L).
app([H|T], L2, [H|Res]) :-
    app(T, L2, Res).

getLength([], 0).
getLength([H|T], N) :-
    getLength(T,N1),
    N is N1 + 1.

getFindall(Template, Goal, ResultList) :-
    retractall(temp_result(_)),
    (   call(Goal),
        assertz(temp_result(Template)),
        fail
    ;   true
    ),
    collect_results(ResultList).

collect_results([H|T]) :-
    retract(temp_result(H)),
    !,
    collect_results(T).
collect_results([]).

manualConcat(List, Result) :- 
    manualConcat(List, '', Result).

manualConcat([], _, '').

manualConcat([H], _, HAtom) :-
    !,
    ubah_ke_atom(H, HAtom).

manualConcat([H|T], Separator, Result) :-
    ubah_ke_atom(H, HAtom),
    manualConcat(T, Separator, TailResult),
    atom_concat(HAtom, Separator, Temp),
    atom_concat(Temp, TailResult, Result).

ubah_ke_atom(Val, Atom) :-
    (number(Val) -> atom_number(Val, Atom) ; Atom = Val).

cek_deck_habis :-
    deck_utama([]), !,
    buang_kartu([KartuAtas | SisaBuangan]),

    (SisaBuangan == [] ->
        write("Tidak ada kartu lagi yang dapat diacak!"), nl
    ;
        acak_deck(SisaBuangan, DeckBaru),
        retractall(deck_utama(_)),
        assertz(deck_utama(DeckBaru)),
        retractall(buang_kartu(_)),
        assertz(buang_kartu([KartuAtas])),
        write("Deck utama sudah habis. Mengacak ulang tumpukan buangan menjadi deck baru.")

    ).

cek_deck_habis.