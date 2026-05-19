:- dynamic(game_start/0).
:- dynamic(deck_utama/1).
:- dynamic(tangan/2).
:- dynamic(buang_kartu/1).
:- dynamic(turn/1).
:- dynamic(status_uni/1).


:- include('kartu.pl').
:- include('validasi_pemain.pl').
:- include('aksi_pendukung.pl').
:- include('acak_dan_simpan_urutan.pl').
:- include('testing.pl').
:- include('mainkanKartu.pl').
:- include('ambilKartu.pl').
:- include('warna_aktif.pl').
:- include('uni.pl').
:- include('tangkap.pl').
:-include('endgame_detection.pl').

startGame :-
    assertz(game_start),

    inputBanyakPemain, nl,
    putNamaPemain, nl,
    shuffle_urutan,
    nama_pemain(Players),
    assertz(turn(0)),
    print_urutan,

    deck_generate(DeckAwal),

    bagi_ke_semua_pemain(Players, DeckAwal, SisaDeck),

    discard_pile(SisaDeck, KartuAwal, SisaDeckSetelahBuang),

    assertz(buang_kartu([KartuAwal])),
    init_warna_aktif(KartuAwal),

    assertz(deck_utama(SisaDeckSetelahBuang)),
    
    nl, write('Game dimulai! 7 kartu telah dibagikan.'), nl,
    nl, write('Kartu di tengah saat ini: '), cetak_nama_kartu(KartuAwal), nl,
    print_giliran.

bagi_kartu(0, Deck, Deck, []).
bagi_kartu(N, [Kartu|SisaDeckTemp], SisaDeck, [Kartu|TanganPemain]) :-
    N > 0,
    N1 is N - 1,
    bagi_kartu(N1, SisaDeckTemp, SisaDeck, TanganPemain).

bagi_ke_semua_pemain([], Deck, Deck).
bagi_ke_semua_pemain([Pemain|SisaPemain], Deck, SisaDeck) :-
    bagi_kartu(7, Deck, SisaDeckTemp, TanganPemain),
    assertz(tangan(Pemain, TanganPemain)),
    bagi_ke_semua_pemain(SisaPemain, SisaDeckTemp, SisaDeck).

print_giliran:-
    turn(X), urutan_pemain(Z), get_element(Z, X, Y),
    write('Giliran '), write(Y), write('.'), nl.