:- include('utilities.pl').

:- dynamic(jumlah_pemain/1).
:- dynamic(nama_pemain/1).


inputBanyakPemain :-
    repeat,
    write('Masukkan jumlah pemain: '),
    read(Input),

    (
        (Input < 2; Input > 4) -> write('Mohon masukkan angka antara 2 - 4.'),nl,
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
    length(Players, L)
    write('Masukkan nama pemain '), write(L+1) , write(': '),
    read(Input),
    jumlah_pemain(Num),
    (
        (   
            repeat,
            isInList(Input, Players)->write('Nama sudah digunakan. Masukkan nama lain: '), read(Input), fail;
            !,
        )
        append(Players, [Input], X1), retractall(nama_pemain(Players)), assertz(nama_pemain(X1)),
        (length(X1, L1), L1 =:= Num)->!
    ).




