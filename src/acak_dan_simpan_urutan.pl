:- include('utilities.pl').
:- include('globals.pl').


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
        app(Shuffled, [Selected], NewShuffled),
        retractall(urutan_pemain(_)),
        assertz(urutan_pemain(NewShuffled))
    ),
    urutan_pemain(Current),
    getLength(Current, L),
    L =:= Num,
    !.

print_urutan :-
    urutan_pemain(Pemain),
    write('Urutan Pemain: '), 
    print_urutan(Pemain).
print_urutan([H]):-
    write(H), write('.'), nl.
print_urutan([H|T]):-
    write(H), write(' - '),
    print_urutan(T).

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