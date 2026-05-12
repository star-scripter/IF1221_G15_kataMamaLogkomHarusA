:- dynamic(game_start/0).

:- include('kartu.pl').
:- include('validasi_pemain.pl').
:- include('aksi_pendukung.pl').

/* Ini buat testing aja, ganti aja pas mau full */
start_game :-
    assertz(game_start),
    write('Game mulai!'), nl.
