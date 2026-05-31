cekTipu([Kartu|_],KartuAtas):-
    Kartu \= kartu(hitam,wild_draw_four),
    kartu_tumpuk(Kartu,KartuAtas),!.

cekTipu([_|Sisa],KartuAtas):-
    cekTipu(Sisa,KartuAtas).


tantang:-
    \+ game_start,
    write('Gamenya belum mulai!'), nl,
    !.

tantang:-
    penalti_aktif(wild_draw_four),
    urutan_pemain([PlayerCuriga|_]),
    playerTipu(Tersangka, Status),
    write('Tantangan dilakukan!'),nl,
    format('Memeriksa kartu ~w',[Tersangka]),nl,

    (Status = bohong ->
    format('Tantangan berhasil. ~w mendapatkan 4 kartu acak.~n',[Tersangka]),
        draw(Tersangka),
        draw(Tersangka),
        draw(Tersangka),
        draw(Tersangka),
        rotate_player
    
    ;
        format('Tantangan gagal. ~w mendapatkan 6 kartu acak.~n',[PlayerCuriga]),
        draw(PlayerCuriga),
        draw(PlayerCuriga),
        draw(PlayerCuriga),
        draw(PlayerCuriga),
        draw(PlayerCuriga),
        draw(PlayerCuriga),
        rotate_player
    ),
    retract(penalti_aktif(wild_draw_four)),
    retract(playerTipu(_,_)),!.