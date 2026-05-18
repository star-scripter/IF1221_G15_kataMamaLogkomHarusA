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

cekInfo :-
    buang_kartu(Top),
    write('Kartu discard top: '), cetak_nama_kartu(Top),nl,
    nl.