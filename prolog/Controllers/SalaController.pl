:- module(sala_controller, [listar_salas/1, get_sala/2, findall/3, reserva_conflitantes/3, se_reserva_conflita/2, sala_reservas_em_faixa/4]).

:- use_module(library(date)).
:- use_module('Repository.pl').

%
reserva_conflitantes(NovaReserva, Reservas, Conflitantes) :-
    findall(R, (member(R, Reservas), se_reserva_conflita(NovaReserva, R)), Conflitantes).

%
se_reserva_conflita(Reserva1, Reserva2) :-
    Reserva1 = reserva(_, Inicio1, Termino1),
    Reserva2 = reserva(_, Inicio2, Termino2),
    not((Termino1 =< Inicio2; Inicio1 >= Termino2)).

% Lista todas as salas cadastradas.
listar_salas(Salas) :-
    fetch_all_salas(Salas).

% Retorna uma sala baseado no número de sala.
get_sala(NumeroSala, Resultado) :- repository:fetch_sala(NumeroSala, Resultado).

%
sala_reservas_em_faixa(Sala, Inicio, Termino, ReservasEmFaixa) :-
    findall(Reserva, (member(Reserva, Sala), se_reserva_conflita(Reserva, reserva(_, Inicio, Termino))), Reservas),
    predsort(compare(inicio), Reservas, ReservasEmFaixa).

compare(inicio, reserva(_, I1, _), reserva(_, I2, _), Order) :-
    (   I1 @< I2 -> Order = '<'
    ;   I1 == I2 -> Order = '='
    ;   Order = '>'
    ).