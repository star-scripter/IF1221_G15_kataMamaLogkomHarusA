/* Lihat Command */
lihatCommand :-
    \+ game_start,
    write('Gamenya belum mulai!'), nl,
    !.
lihatCommand :-
    game_start,
    write('Aksi utama yang tersedia: '),nl,
    write('1. ambilKartu'),nl,
    write('2. tantang'),nl,
    nl,
    write('Aksi pendukung yang tersedia: '),nl,
    write('1. lihatCommand'),nl,
    write('2. lihatKartu'),nl,
    write('3. cekInfo'),nl.

getPlayerHand(Hand) :-
    turn(Player),
    urutan_pemain(Order),
    get_element(Order, Player, Name),
    tangan(Name, Hand).
lihatKartu :-
    getPlayerHand(Hand),
    write('Berikut kartu yang anda miliki.'), nl,
    printHand(Hand),
    !.

printHand([]).
printHand([Head|Tail]) :-
    cetak_nama_kartu(Head), nl,
    printHand(Tail).

printPlayerCardInfo(Player, Info, N) :-
    format('Nama pemain ~d: ~w', [N, Player]), nl,
    format('Jumlah kartu: ~d', [Info]), nl,
    nl.

cekInfoHelper([], _, _) :-
    nl.
cekInfoHelper([H|T], Start, End) :-
    Start =< End,
    tangan(H, Hand),
    getLength(Hand, Len),
    printPlayerCardInfo(H, Len, Start),
    S1 is Start + 1,
    cekInfoHelper(T, S1, End).

cekInfo :-
    buang_kartu(Pile),
    get_element(Pile, 0, Top),
    write('Kartu discard top: '), cetak_nama_kartu(Top),nl,
    print_urutan, nl,
    urutan_pemain(Order),
    getLength(Order, Len),
    cekInfoHelper(Order, 1, Len),
    !.