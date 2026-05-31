/* Lihat Command */
lihatCommand :-
    \+ game_start,
    write('Gamenya belum mulai!'), nl,
    !.
lihatCommand :-
    game_start,
    write('Aksi utama yang tersedia: '),nl,
    writeValid(1, N),
    nl,
    write('Aksi pendukung yang tersedia: '),nl,
    write('1. lihatCommand'),nl,
    write('2. lihatKartu'),nl,
    write('3. cekInfo'),nl.

writeAction(Status, Command, Nin, Nout):-
    checkValid(Status),
    !,
    format('~d. ~w~n', [Nin, Command]),
    Nout is Nin + 1.
writeAction(_, _, N, N).

writeValid(NStart, NEnd):-
    penalti_aktif(draw_two),
    !,
    writeAction(can_tangkap, tangkap, NStart, N1),
    writeAction(force_draw, ambilKartu, N1, NEnd).
writeValid(NStart, NEnd):-
    penalti_aktif(wild_draw_four),
    !,
    writeAction(can_tangkap, tangkap, NStart, N1),
    writeAction(can_tantang, tantang, N1, N2),
    writeAction(can_tantang, ambilKartu, N2, NEnd).
writeValid(NStart, NEnd):-
    writeAction(can_uni, uni, NStart, N1),
    writeAction(can_tangkap, tangkap, N1, N2),
    writeAction(can_draw, ambilKartu, N2, N3),
    writeAction(can_play, mainkanKartu, N3, NEnd).

checkValid(force_draw):-
    penalti_aktif(draw_two).
checkValid(can_tantang):-
    penalti_aktif(wild_draw_four).
checkValid(can_uni):-
    urutan_pemain([Player|_]),
    tangan(Player, Hand), 
    getLength(Hand, Len), 
    buang_kartu([KartuAtas|_]),
    checkForPlayableCards(Hand,KartuAtas),
    Len =:= 2.
checkValid(can_tangkap):-
    \+ status_uni(Player),
    tangan(Player,Hand),
    getLength(Hand,1).
checkValid(can_draw).
checkValid(can_play) :-
    urutan_pemain([Pemain|SisaUrutan]),
    tangan(Pemain, Tangan),
    buang_kartu([KartuAtas|_]),
    checkForPlayableCards(Tangan,KartuAtas).

checkForPlayableCards([Picked|Rest],Top):-
    kartu_tumpuk(Picked,Top),
    !.
checkForPlayableCards([_|Rest],Top) :-
    checkForPlayableCards(Rest,Top).

getPlayerHand(Hand) :-
    turn(Player),
    urutan_pemain(Order),
    get_element(Order, Player, Name),
    tangan(Name, Hand).
lihatKartu :-
    getPlayerHand(Hand),
    write('Berikut kartu yang anda miliki.'), nl,
    printHand(Hand, 1),
    !.

printHand([], _).
printHand([Head|Tail], Cur) :-
    format('~d. ', [Cur]), cetak_nama_kartu(Head), nl,
    Cur1 is Cur + 1,
    printHand(Tail, Cur1).

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
    tampil_warna_aktif,
    print_urutan, nl,
    urutan_pemain(Order),
    getLength(Order, Len),
    cekInfoHelper(Order, 1, Len),
    !.