:- dynamic(game_start/0).

:- include('kartu.pl').
:- include('validasi_pemain.pl').
:- include('aksi_pendukung.pl').
:- include('acak_dan_simpan_urutan.pl').

/* Ini buat testing aja, ganti aja pas mau full */
start_game :-
    assertz(game_start),
    write('Game mulai!'), nl,
    inputBanyakPemain,
    putNamaPemain,
    shuffle_urutan,
    shuffle_test.
