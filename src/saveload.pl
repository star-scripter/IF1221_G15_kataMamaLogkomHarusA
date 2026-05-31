:- include('globals.pl').

% 1. predikat bantu buat convert kartu ke teks, dan sebaliknya
kartu_ke_teks(kartu(Warna, angka(Angka)), Teks) :-
    !,
    atomic_list_concat([Warna, Angka], '-', Teks).

kartu_ke_teks(kartu(Warna, Jenis), Teks) :- atomic_list_concat([Warna, Jenis], '-', Teks).

teks_ke_kartu(Teks, kartu(Warna, angka(Angka))) :-
    atomic_list_concat([Warna, AngkaAtom], '-', Teks),
    atom_number(AngkaAtom, Angka),
    !.

teks_ke_kartu(Teks, kartu(Warna, Jenis)) :-
    atomic_list_concat([Warna, Jenis], '-', Teks).

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
kumpul_status_uni(List) :- findall(P, status_uni(P), List).
arah_sekarang(Arah) :- (arah_permainan(Arah) -> true ; Arah = kanan).

% 5. 
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
    atomic_list_concat([NamaFile, '.txt'], NamaFileLengkap),
    open(NamaFileLengkap, write, Stream),
    saveGame_tulis(Stream),
    close(Stream),
    format('Status permainan berhasil disimpan ke ~w.~n', [NamaFileLengkap]).

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

