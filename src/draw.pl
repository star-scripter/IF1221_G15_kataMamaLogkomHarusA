:-include('kartu.pl').
:-include('utilities.pl').

draw(Pemain):-
    retract(deck_utama([KartuDiambil|SisaDeck])),
    assertz(deck_utama(SisaDeck)),
    retract(tangan(Pemain, TanganLama)),
    app(TanganLama, [KartuDiambil], TanganBaru),
    cetak_nama_kartu(KartuDiambil), nl,
    assertz(tangan(Pemain, TanganBaru)).

efek(kartu(_, draw_two)):-
    urutan_pemain([PemainTarget|_]),
    draw(PemainTarget),
    draw(PemainTarget),
    retract(penalti_aktif(draw_two)).

efek(kartu(hitam, wild_draw_four)):-
    urutan_pemain([PemainTarget|_]),
    draw(PemainTarget),
    draw(PemainTarget),
    draw(PemainTarget),
    draw(PemainTarget),
    retract(penalti_aktif(wild_draw_four)).

efek(kartu(hitam,wild)):-
    pilih_warna,
    rotate_player.

efek(kartu(_, skip)):-
  urutan_pemain([Pemain|Sisa]),
  app(Sisa, [Pemain], UrutanBaru),
  format('Giliran ~w dilewatkan. ~n', [Pemain]),
  UrutanBaru = [Pemain1|Sisa1],
  app(Sisa1, [Pemain1], UrutanBaru1),
  retractall(urutan_pemain(_)),
  assertz(urutan_pemain(UrutanBaru1)),
  UrutanBaru1 = [Next|_],
  format('Giliran ~w.~n', [Next]).

efek(kartu(_, reverse)):-
  urutan_pemain([Pemain|Sisa]),
  reverse_list(Sisa, [], Sisa1),
  app(Sisa1, [Pemain], UrutanBaru),
  retractall(urutan_pemain(_)),
  assertz(urutan_pemain(UrutanBaru)),
  UrutanBaru = [Next|_],
  print_urutan,nl,
  format('Giliran ~w.~n', [Next]).

efek(kartu(_,angka(_))):-
    rotate_player.
    
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





    
