:- dynamic(game_start/0).
:- dynamic(deck_utama/1).
:- dynamic(tangan/2).
:- dynamic(buang_kartu/1).

:- include('kartu.pl').
:- include('validasi_pemain.pl').
:- include('aksi_pendukung.pl').
:- include('acak_dan_simpan_urutan.pl').
:- include('testing.pl').

/* Ini buat testing aja, ganti aja pas mau full */
start_game :-

    % start game 
    assertz(game_start),

    % input jumlah pemain dan nama pemain
    inputBanyakPemain,
    putNamaPemain,
    nama_pemain(Players),

    % generate deck yg teracak
    deck_generate(DeckAwal),

    % bagikan kartu ke semua pemain (masing-masing 7 kartu, ngurangin DeckAwal dan sisanya jadi deck utama di SisaDeck)
    bagi_ke_semua_pemain(Players, DeckAwal, SisaDeck),

    % ambil kartu pertama dari deck utama untuk jadi kartu awal di tengah, sisanya tetap di deck utama (SisaDeckSetelahBuang)
    discard_pile(SisaDeck, KartuAwal, SisaDeckSetelahBuang),

    % simpan kartu awal ke memori buang_kartu, ini jadi deck yang ada di tengah
    assertz(buang_kartu([KartuAwal])),

    % simpan sisa deck setelah buang kartu pertama ke memori deck_utama, bisa dipakai untuk fungsi ambilKartu nanti
    assertz(deck_utama(SisaDeckSetelahBuang)),
    
    nl, write('Game dimulai! 7 kartu telah dibagikan.'), nl,
    write('Kartu di tengah saat ini: '), write(KartuAwal), nl.

% helper predicate untuk bagi kartu ke pemain
bagi_kartu(0, Deck, Deck, []).
bagi_kartu(N, [Kartu|SisaDeckTemp], SisaDeck, [Kartu|TanganPemain]) :-
    N > 0,
    N1 is N - 1,
    bagi_kartu(N1, SisaDeckTemp, SisaDeck, TanganPemain).

% bagi kartu ke semua pemain pakai rekursi
% Kalau pemain sudah habis, berarti semua pemain sudah dapat kartu, jadi deck yang tersisa tetap sama (Deck) dan tidak ada kartu yang dibagikan (Deck)
bagi_ke_semua_pemain([], Deck, Deck).

% Kalau masih ada pemain, bagi kartu ke pemain pertama (Pemain) dengan memanggil bagi_kartu, lalu simpan tangan pemain tersebut di memori dengan assertz(tangan(Pemain, TanganPemain)). 
% Setelah itu, lanjutin proses bagi kartu ke pemain berikutnya (SisaPemain) dengan deck yang sudah dikurangin kartu yang dibagikan (SisaDeckTemp).
bagi_ke_semua_pemain([Pemain|SisaPemain], Deck, SisaDeck) :-
    bagi_kartu(7, Deck, SisaDeckTemp, TanganPemain),
    assertz(tangan(Pemain, TanganPemain)),
    bagi_ke_semua_pemain(SisaPemain, SisaDeckTemp, SisaDeck).

