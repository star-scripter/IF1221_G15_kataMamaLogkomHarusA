:- include('validasi_pemain.pl').

:- dynamic(urutan_pemain/1).

shuffle_urutan:-
    nama_pemain(Players),
    jumlah_pemain(Num),
    assertz(urutan_pemain([])),
    repeat,
    urutan_pemain(Shuffled),
    (
        (random(1, Num+1, I), get_element(Players, I-1, Y), get_index(Shuffled, Y, Idx))->fail;
        append(Shuffled, [Y], NewShuffled),
        retractall(urutan_pemain(Shuffled)),
        assertz(urutan_pemain(NewShuffled)),
        (length(NewShuffled, L), L=:=Num) -> !
    ).

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