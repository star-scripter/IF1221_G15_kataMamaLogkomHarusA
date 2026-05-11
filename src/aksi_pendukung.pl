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
