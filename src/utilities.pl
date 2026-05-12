delete_element([_|Tail], 0, Tail).
delete_element([Head|Tail], Index, [Head|UpdatedTail]) :-
    Index > 0,
    NewIdx is Index - 1,
    delete_element(Tail, NewIdx, UpdatedTail).

get_index([Element|_], Element, 0).
get_index([_|Tail], Element, Index) :-
    get_index(Tail, Element, TailIndex),
    Index is TailIndex + 1.

get_element([Elem|_], 0, Elem).
get_element([_|T], Idx, Elem):-
    Idx > 0,
    NewIdx is Idx - 1,
    get_element(T, NewIdx, Elem).

isInList(Elem, [Elem|_]).
isInList(Elem, [_|T]) :-
    isInList(Elem, T).