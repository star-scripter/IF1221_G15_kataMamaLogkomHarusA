:- include('globals.pl').

% 1. predikat bantu buat convert kartu ke teks, dan sebaliknya
kartu_ke_teks(kartu(Warna, angka(Angka)), Warna-Angka) :- !.
kartu_ke_teks(kartu(Warna, Jenis), Warna-Jenis).

teks_ke_kartu(Warna-Angka, kartu(Warna, angka(Angka))) :- number(Angka), !. 
teks_ke_kartu(Warna-Jenis, kartu(Warna, Jenis)).

list_kartu_ke_teks([], []).
list_kartu_ke_teks([K|KRest], [T|TRest]) :-
    kartu_ke_teks(K, T),
    list_kartu_ke_teks(KRest, TRest).

list_teks_ke_kartu([], []).
list_teks_ke_kartu([T|TRest], [K|KRest]) :-
    teks_ke_kartu(T, K),
    list_teks_ke_kartu(TRest, KRest).

% 2. predikat bantu buat nulis isi list

tulis_list_pemain(Stream, List) :-
    write(Stream, '['),
    tulis_isi_pemain(Stream, List),
    write(Stream, ']').

tulis_isi_pemain(_, []).
tulis_isi_pemain(Stream, [H]) :-
    !,
    writeq(Stream, H).
tulis_isi_pemain(Stream, [H|T]) :-
    writeq(Stream, H),
    write(Stream, ','),
    tulis_isi_pemain(Stream, T).

% 2. predikat bantu buat nulis isi list

tulis_list_teks(Stream, List) :-
    write(Stream, '['),
    tulis_isi_list(Stream, List),
    write(Stream, ']').

tulis_isi_list(_, []).
tulis_isi_list(Stream, [H]) :-
    !,
    write(Stream, H).
tulis_isi_list(Stream, [H|T]) :-
    write(Stream, H),
    write(Stream, ','),
    tulis_isi_list(Stream, T).

% 3. predikat bantu buat 
tulis_kartu_pemain(_, []).
tulis_kartu_pemain(Stream, [Pemain|Rest]) :-
    tangan(Pemain, Tangan),
    list_kartu_ke_teks(Tangan, TanganTeks),
    write(Stream, 'kartu('),
    writeq(Stream, Pemain),
    write(Stream, '):'),
    tulis_list_teks(Stream, TanganTeks),
    write(Stream, '.'), nl(Stream),
    tulis_kartu_pemain(Stream, Rest).

% 4. predikat bantu lainnya
giliran_sekarang(Pemain) :- urutan_pemain([Pemain|_]).
kumpul_status_uni(List) :- getFindall(P, status_uni(P), List).
arah_sekarang(Arah) :- (arah_permainan(Arah) -> true ; Arah = kanan).

% 5. saveGame

saveGame :-
    final_score(_, _, _, _),
    !,
    write('Gagal menyimpan: Permainan sudah selesai!'), nl.

saveGame :-
    \+ game_start,
    !,
    write('Gamenya belum mulai! Tidak ada yang bisa disimpan.'), nl.

saveGame :-
    /* Tidak boleh dipanggil saat penalti wild_draw_four aktif */
    penalti_aktif(wild_draw_four),
    !,
    write('Tidak bisa menyimpan saat pemain harus memilih tantang atau ambilKartu.'), nl.

saveGame :-
    write('Masukkan nama file penyimpanan: '),
    read(NamaFile),
    manualConcat([NamaFile, '.txt'], NamaFileLengkap),
    open(NamaFileLengkap, write, Stream),
    saveGame_tulis(Stream),
    close(Stream),
    format('Status permainan berhasil disimpan ke ~w.~n', [NamaFileLengkap]),

    bersihkan_state, 
    write('Permainan selesai disimpan dan telah diakhiri. Silakan mulai ulang atau load game.'), nl.

saveGame_tulis(Stream) :-

    /* 1. urutan pemain */
    urutan_pemain(Urutan),
    write(Stream, 'urutan_pemain:'),
    tulis_list_pemain(Stream, Urutan),
    write(Stream, '.'), nl(Stream),

    /* 2. giliran */
    giliran_sekarang(Giliran),
    write(Stream, 'giliran:'),
    writeq(Stream, Giliran),
    write(Stream, '.'), nl(Stream),

    /* 3. discard_top */
    buang_kartu([KartuAtas|_]),
    kartu_ke_teks(KartuAtas, DiscardTeks),
    write(Stream, 'discard_top:'),
    write(Stream, DiscardTeks),
    write(Stream, '.'), nl(Stream),

    /* 4. warna_aktif */
    warna_aktif(WarnaAktif),
    write(Stream, 'warna_aktif:'),
    write(Stream, WarnaAktif),
    write(Stream, '.'), nl(Stream),

    /* 5. arah_permainan */
    arah_sekarang(Arah),
    write(Stream, 'arah_permainan:'),
    write(Stream, Arah),
    write(Stream, '.'), nl(Stream),

    /* 6. status_UNI */
    kumpul_status_uni(UniList),
    write(Stream, 'status_UNI:'),
    tulis_list_pemain(Stream, UniList),
    write(Stream, '.'), nl(Stream),

    /* 7. kartu tiap pemain */
    urutan_pemain(UrutanPemain),
    tulis_kartu_pemain(Stream, UrutanPemain).

loadGame :-
    game_start,
    !,
    write('Gagal memuat: loadGame hanya bisa dipanggil sebelum permainan dimulai!'), nl.

loadGame :-
    write('Masukkan nama file yang akan dimuat: '),
    read(NamaFile),
    manualConcat([NamaFile, '.txt'], NamaFileLengkap),
    (file_exists(NamaFileLengkap) ->
        bersihkan_state,
        baca_file(NamaFileLengkap, Baris),
        proses_semua_baris(Baris),

        assertz(game_start),
        assertz(turn(0)),
        
        pulihkan_deck_utama,
        
        format('Status permainan berhasil dimuat dari ~w.~n', [NamaFileLengkap]),
        urutan_pemain([GiliranPemain|_]),
        format('Melanjutkan giliran ~w.~n', [GiliranPemain])
    ;
        format('File ~w tidak ditemukan!~n', [NamaFileLengkap])
    ).

bersihkan_state :-
    retractall(game_start),
    retractall(urutan_pemain(_)),
    retractall(tangan(_, _)),
    retractall(buang_kartu(_)),
    retractall(warna_aktif(_)),
    retractall(status_uni(_)),
    retractall(penalti_aktif(_)),
    retractall(deck_utama(_)),
    retractall(jumlah_pemain(_)),
    retractall(nama_pemain(_)),
    retractall(turn(_)),
    (retractall(arah_permainan(_)) -> true ; true).

baca_file(NamaFile, Baris) :-
    open(NamaFile, read, Stream),
    baca_semua_baris(Stream, Baris),
    close(Stream).

baca_semua_baris(Stream, []) :- at_end_of_stream(Stream), !.
baca_semua_baris(Stream, [Baris|Rest]) :-
    read_term(Stream, Baris, []),
    baca_semua_baris(Stream, Rest).

proses_semua_baris([]).
proses_semua_baris([Baris|Rest]) :-
    (proses_baris(Baris) -> true ; true),
    proses_semua_baris(Rest).

proses_baris(urutan_pemain:Urutan) :-
    !,
    assertz(urutan_pemain(Urutan)),
    length(Urutan, Num),
    assertz(jumlah_pemain(Num)),
    assertz(nama_pemain(Urutan)).

proses_baris(giliran:Giliran) :-
    !,
    urutan_pemain(Urutan),
    rotateUntil(Giliran, Urutan, UrutanBaru),
    retractall(urutan_pemain(_)),
    assertz(urutan_pemain(UrutanBaru)).

proses_baris(discard_top:DiscardTeks) :-
    !,
    teks_ke_kartu(DiscardTeks, Kartu),
    assertz(buang_kartu([Kartu])).

proses_baris(warna_aktif:Warna) :-
    !,
    assertz(warna_aktif(Warna)).

proses_baris(arah_permainan:Arah) :-
    !,
    (retractall(arah_permainan(_)) -> true ; true),
    assertz(arah_permainan(Arah)).

proses_baris(status_UNI:UniList) :-
    !,
    assertz_status_uni(UniList).

proses_baris(kartu(Pemain):TanganTeks) :-
    !,
    list_teks_ke_kartu(TanganTeks, Tangan),
    assertz(tangan(Pemain, Tangan)).

proses_baris(_).

assertz_status_uni([]).
assertz_status_uni([P|Rest]) :-
    assertz(status_uni(P)),
    assertz_status_uni(Rest).

pulihkan_deck_utama :-
    getFindall(kartu(Warna, Jenis), kartu_valid(Warna, Jenis), FullDeck),
    getFindall(K, (tangan(_, Hand), isInList(K, Hand)), KartuDiTangan),
    buang_kartu([TopCard|_]),
    app(KartuDiTangan, [TopCard], KartuTerpakai),
    kurangi_list(FullDeck, KartuTerpakai, SisaDeck),
    acak_deck(SisaDeck, SisaDeckAcak),
    assertz(deck_utama(SisaDeckAcak)).

kurangi_list(Deck, [], Deck).
kurangi_list(Deck, [H|T], Sisa) :-
    hapus_satu(H, Deck, DeckBaru),
    !, 
    kurangi_list(DeckBaru, T, Sisa).
kurangi_list(Deck, [_|T], Sisa) :- 
    kurangi_list(Deck, T, Sisa).

hapus_satu(X, [X|T], T) :- !.
hapus_satu(X, [H|T], [H|TRes]) :- 
    hapus_satu(X, T, TRes).