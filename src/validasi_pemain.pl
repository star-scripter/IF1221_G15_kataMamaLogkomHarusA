:- dynamic(jumlah_pemain/1).
:- dynamic(nama_pemain/1).


inputBanyakPemain :-
    repeat,
    write('Masukkan jumlah pemain: '),
    read(Input),

    (
        (Input < 2; Input > 4) -> write('Mohon massukan angka antara 2-4'),nl,
        fail;
        (Input >= 2, Input =< 4) -> assertz(jumlah_pemain(Input)), !
    ),
    assertz(nama_pemain([])).


testAssertz :-
    jumlah_pemain(X),
    write('JUMLAH PEMAIN: '), write(X).

putNamaPemain :-
    repeat,
    nama_pemain(Players),
    write('Masukkan nama pemain: '),
    read(Input),
    jumlah_pemain(Num),
    (
        get_index(Players, Input, Y)->write('Pemain sudah ada, masukkan nama lain.'), nl, fail;
        append(Players, [Input], X1), retractall(nama_pemain(Players)), assertz(nama_pemain(X1)),
        (length(X1, L), L =:= Num)->!
    ).



get_index([_|Tail], Element, Index) :-
    get_index(Tail, Element, TailIndex),
    Index is TailIndex + 1.
get_index([Element|_], Element, 0).

get_element([Elem|_], 0, Elem).
get_element([_|T], Idx, Elem):-
    Idx > 0,
    NewIdx is Idx - 1,
    get_element(T, NewIdx, Elem).

