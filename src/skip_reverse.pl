:- dynamic(dir/1).

:- include(acak_dan_simpan_urutan.pl).
:- include(utilities.pl).
:- include(kartu.pl).

skip(Warna, skip):-
  kartu_valid(Warna, skip),
  urutan_pemain([Pemain|Sisa]),
  app(Sisa, [Pemain], UrutanBaru),
  retractall(urutan_pemain(_)),
  assertz(urutan_pemain(UrutanBaru)).
skip(Warna, _).

rev(Warna, reverse):-
  kartu_valid(Warna, reverse),
  urutan_pemain([Pemain|Sisa]),
  reverse_list(Sisa, Sisa1),
  retractall(urutan_pemain(_)),
  assertz([Pemain|Sisa1]).
rev(Warna, _).