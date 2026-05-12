:- include('utilities.pl').

:- include('validasi_pemain.pl').

:- dynamic(urutan_pemain/1).

shuffle_urutan:-
    retractall(urutan_pemain(_)),
    nama_pemain(Players),
    jumlah_pemain(Num),
    assertz(urutan_pemain([])),

    repeat,
    urutan_pemain(Shuffled),
    random(0, Num, I),
    get_element(Players, I, Selected),
    (
        isInList(Selected, Shuffled) -> fail;
        append(Shuffled, [Selected], NewShuffled),
        retractall(urutan_pemain(_)),
        assertz(urutan_pemain(NewShuffled))
    ),
    urutan_pemain(Current),
    length(Current, L),
    L =:= Num,
    !.

print_urutan :-
    urutan_pemain(Pemain),
    write('Urutan Pemain: '), write(Pemain).    

/*
shuffle_test:-
    urutan_pemain(Shuffled),
    jumlah_pemain(Num),
    Idx is Num,
    repeat,
    ( 
        get_element(Shuffled, Idx, Elem),
        write(Elem), nl, NexIdx is Idx-1, Idx is NexIdx,
        (Idx =:= 0) ->!
    ).
*/