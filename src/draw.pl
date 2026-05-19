:-include('kartu.pl').
:-include('utilities.pl').

draw(Pemain):-
    retract(deck_utama([KartuDiambil|SisaDeck])),
    assertz(deck_utama(SisaDeck)),
    retract(tangan(Pemain, TanganLama)),
    app(TanganLama, [KartuDiambil], TanganBaru),
    assertz(tangan(Pemain, TanganBaru)).

efek(kartu(_, draw_two)):-
    urutan_pemain([PemainSekarang,PemainTarget|SisaUrutan]),
    draw(PemainTarget),
    draw(PemainTarget),
    rotate_player.

efek(kartu(hitam, wild_draw_four)):-
    urutan_pemain([PemainSekarang,PemainTarget|SisaUrutan]),
    draw(PemainTarget),
    draw(PemainTarget),
    draw(PemainTarget),
    draw(PemainTarget),
    pilih_warna.

efek(kartu(hitam,wild)):-
    pilih_warna.

efek(KartuNormal):-
    KartuNormal \= kartu(_,draw_two),
    urutan_pemain([PemainSekarang|SisaUrutan]).
    
pilih_warna:-
    write('Pilih warna kartu'),nl,
    write('- merah'),nl,
    write('- kuning'),nl,
    write('- biru'),nl,
    write('- hijau'),nl,
    read(Warna),
    (warna(Warna) ->
        retract(warna_aktif(_)),
        assertz(warna_aktif(Warna)) 
    ;
        write('Warna tidak valid! Pastikan huruf kecil semua dan diakhiri titik.'), nl,
        pilih_warna
    ).





    
