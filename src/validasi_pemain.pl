:- include('utilities.pl').

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
        get_index(Players, Input, _)->write('Pemain sudah ada, masukkan nama lain.'), nl, fail;
        append(Players, [Input], X1), retractall(nama_pemain(Players)), assertz(nama_pemain(X1)),
        (length(X1, L), L =:= Num)->!
    ).




