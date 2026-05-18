:- dynamic(warna_aktif/1).

init_warna_aktif(kartu(Warna, _)) :-
    assertz(warna_aktif(Warna)).

get_warna_aktif(Warna) :-
    warna_aktif(Warna).

update_warna_aktif(WarnaBaru) :-
    retract(warna_aktif(_)),
    assertz(warna_aktif(WarnaBaru)).

is_valid_by_color(kartu(Warna, _)) :-
    warna_aktif(WarnaAktif),
    Warna = WarnaAktif.

is_wild_card(kartu(hitam, wild)).
is_wild_card(kartu(hitam, wild_draw_four)).

is_valid_card_to_play(Kartu) :-
    (is_valid_by_color(Kartu) ; is_wild_card(Kartu)).

tampil_warna_aktif :-
    warna_aktif(Warna),
    format('Warna aktif saat ini: ~w~n', [Warna]).
