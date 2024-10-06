:- module(sala_controller, [listar_salas/1, get_sala/2, reserva_conflitantes/3, se_reserva_conflita/2, sala_reservas_em_faixa/4, cancelar_reserva/3, reservar_sala/5]).

:- use_module(library(date)).
:- use_module('Repository.pl').
:- use_module('./Models/Usuario.pl').

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

%
cancelar_reserva(NumeroSala, ReservaParaCancelar, Resultado) :-
    repository:fetch_all_salas(Dados),
    atom_number(Key, NumeroSala),
    (   Dados.get(salas/Key, Sala)
    ->  (   member(ReservaParaCancelar, Sala.reservas)
        ->  delete(Sala.reservas, ReservaParaCancelar, NovasReservas),
            NewSala = sala{numSala: Sala.numSala, nomeSala: Sala.nomeSala, reservas: NovasReservas},
            repository:save_sala(NewSala),
            Resultado = right(NewSala)
        ;   Resultado = left('Reserva não existente.')
        )
    ;   Resultado = left('Sala não encontrada.')
    ).

reservar_sala(NumeroSala, Usuario, Inicio, Termino, Resultado) :-
    get_sala(NumeroSala, Sala),
    (   Sala = sala(_, _, Reservas)
    ->  NovaReserva = reserva(Usuario, Inicio, Termino),
        reserva_conflitantes(NovaReserva, Reservas, Conflitantes),
        findall(PriConflitante-ResConflitante, (member(ResConflitante, Conflitantes), fetch_usuario(ResConflitante.usuario, UserConflit), prioridadeUsuario(UserConflit, PriConflitante)), Conflitos),
        fetch_usuario(Usuario, U),
        prioridadeUsuario(U, MinhaPrioridade),
        (   forall((PriConflitante-ResConflitante, Conflitos), MinhaPrioridade > PriConflitante)
        ->  delete(Reservas, Conflitantes, ReservasAtualizadas),
            append([NovaReserva], ReservasAtualizadas, NovasReservas),
            NewSala = Sala{reservas: NovasReservas},
            repository:save_sala(NewSala),
            Resultado = right(NewSala)
        ;   Resultado = left('Sala não disponível para reserva.')
        )
    ;   Resultado = left('Sala não encontrada.')
    ).