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
    jumlah_pemain(Num), 
    repeat,
    nama_pemain(Players),
    length(Players, L),
    (
        (L=:=Num) -> !;
        write('Masukkan nama pemain '), Cur is L+1, write(Cur) , write(': '),
        read(Input),
        misInput(Input, Name, Players),
        fail
    ).

simpan(Input):-
    nama_pemain(Players),
    append(Players, [Input], X1), retractall(nama_pemain(_)), assertz(nama_pemain(X1)).

misInput(Input, Name, Players):-
    (
        isInList(Input, Players)-> write('Nama sudah digunakan. Masukkan nama lain: '), read(Name), misInput(Name, _, Players), !;
        simpan(Input)
    ).