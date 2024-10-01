:- use_module(library(date)), use_module(models([usuario, sala, reserva])).
:- module(sala_controller, [listar_salas/1]).
:- module(repository, [fetch_sala/1, fetch_all_salas/1]).


reserva_conflitantes(Reserva, Reservas, Conflitantes) :-
    findall(Reserva, (member(Reserva, Reservas), se_reserva_conflita(Reserva, Reserva)), Conflitantes).

se_reserva_conflita(Reserva1(_, _, Inicio1, Termino1), Reserva2(_, _, Inicio2, Termino2), Conflito) :-
    Conflito is (not (Termino1 =< Inicio2 or Inicio1 >= Termino2)).

% Lista todas as salas cadastradas.
listar_salas(Salas) :-
    fetch_all_salas(Salas).

% Retorna uma sala baseado no número de sala.
get_sala(NumeroSala, Resultado) :-
    repository:fetch_sala(NumeroSala, MaybeSala),
    (MaybeSala = false -> 
        Resultado = erro('Sala não encontrada.');
        Resultado = sucesso(MaybeSala)).
