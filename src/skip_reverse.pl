:- include('globals.pl').
:- include('utilities.pl').
:- include('kartu.pl').

efek(kartu(_, skip)):-
  urutan_pemain([Pemain|Sisa]),
  app(Sisa, [Pemain], UrutanBaru),
  retractall(urutan_pemain(_)),
  assertz(urutan_pemain(UrutanBaru)).

efek(kartu(_, reverse)):-
  urutan_pemain([Pemain|Sisa]),
  reverse_list(Sisa, Sisa1),
  retractall(urutan_pemain(_)),
  assertz([Pemain|Sisa1]).