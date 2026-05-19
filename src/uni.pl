uni(N) :-
    ( 
        (turn(X), urutan_pemain(Order), get_element(Order, X, Player), tangan(Player, Hand), getLength(Hand, Len), Len =:= 2) -> uniHelper(N) -> 
        format('~w menyerukan UNI', [Player]), nl;
        write('Anda tidak dapat menyerukan UNI!'), nl,
        write('Anda ambil kartu...'), nl,
        ambilKartu
    ).

uniHelper(N):-
    urutan_pemain([Pemain|SisaUrutan]),
    tangan(Pemain, Tangan),
    Index is N - 1,
    (ambil_elemen(Index,Tangan, KartuDipilih, Sisa)->
        buang_kartu([KartuAtas|_]),

        (kartu_tumpuk(KartuDipilih,KartuAtas)->
        format('~w memainkan kartu: ', [Pemain]),
        cetak_nama_kartu(KartuDipilih), write('.'), nl,
        
        retract(tangan(Pemain, _)),
        assertz(tangan(Pemain, Sisa)),

        retract(buang_kartu(TumpukanLama)),
        assertz(buang_kartu([KartuDipilih|TumpukanLama])),

        temporarySkip([Pemain|SisaUrutan]);
        write('Kartu tidak valid! Silakan masukkan pilihan kartu kembali.'), nl, fail
        )
    ;write('Nomor urut kartu tidak ada di tangan!'), nl, fail
    ).

temporarySkip([Pemain|Sisa]) :-
    app(Sisa, [Pemain], UrutanBaru),
    retract(urutan_pemain(_)),
    assertz(urutan_pemain(UrutanBaru)),
    UrutanBaru = [Next|Sisa2],
    app(Sisa2, [Next], UrutanBaru1),
    retract(urutan_pemain(_)),
    assertz(urutan_pemain(UrutanBaru1)),
    UrutanBaru1 = [Next1|_],   
    format('Giliran ~w.~n', [Next1]).