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

rotate_player([Pemain|Sisa]) :-
    app(Sisa, [Pemain], UrutanBaru),
    retract(urutan_pemain(_)),
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