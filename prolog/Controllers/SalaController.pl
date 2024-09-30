:- use_module(library(date)), use_module(models([usuario, sala, reserva])).

reserva_conflitantes(Reserva, Reservas, Conflitantes) :-
    findall(Reserva, (member(Reserva, Reservas), se_reserva_conflita(Reserva, Reserva)), Conflitantes).

se_reserva_conflita(Reserva1(_, _, Inicio1, Termino1), Reserva2(_, _, Inicio2, Termino2), Conflito) :-
    Conflito is (not (Termino1 =< Inicio2 or Inicio1 >= Termino2)).