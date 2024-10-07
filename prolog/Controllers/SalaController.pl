:- module(sala_controller, [listar_salas/1, get_sala/2, reserva_conflitantes/3, se_reserva_conflita/2, sala_reservas_em_faixa/4, cancelar_reserva/3, reservar_sala/5]).

:- use_module(library(date)).
:- use_module('Repository.pl').
:- use_module('./Models/Usuario.pl').

% verifica se há reservas conflitantes com uma nova reserva nova. Recebe a reserva nova e a lista de reservas existentes e retorna a lista de reservas conflitantes.
reserva_conflitantes(NovaReserva, Reservas, Conflitantes) :-
    findall(R, (member(R, Reservas), se_reserva_conflita(NovaReserva, R)), Conflitantes).

% verifica se duas reservas são conflitantes, recebe duas reservas e retorna verdadeiro se as reservas forem conflitantes, se nao, e falso
se_reserva_conflita(Reserva1, Reserva2) :-
    Reserva1 = reserva(_, Inicio1, Termino1),
    Reserva2 = reserva(_, Inicio2, Termino2),
    not((Termino1 =< Inicio2; Inicio1 >= Termino2)).

% Lista todas as salas cadastradas.
listar_salas(Salas) :-
    fetch_all_salas(Salas).

% Retorna uma sala baseado no número de sala.
get_sala(NumeroSala, Resultado) :- repository:fetch_sala(NumeroSala, Resultado).

% retorna as reservas de uma sala que estão dentro de uma faixa de datas específicas, assim, recebe a sala, a data de início e a data de término e retorna uma lista de reservas que estão dentro da faixa de datas.
sala_reservas_em_faixa(Reservas, Inicio, Termino, ReservasEmFaixa) :-
    findall(Reserva, (member(Reserva, Reservas), se_reserva_conflita(Reserva, reserva(_, Inicio, Termino))), ReservasC),
    predsort(compare_reserva, ReservasC, ReservasEmFaixa).

% ordena as reservas por data de início de cada uma das duas reservas
compare_reserva(Order, reserva(_, I1, _), reserva(_, I2, _)) :-
    (   I1 @< I2 -> Order = '<'
    ;   I1 == I2 -> Order = '='
    ;   Order = '>'
    ).

% cancela uma reserva em uma sala, recebendo o número de sala, a reserva a ser cancelada e o resultado, se for cancelada com sucesso, ela retorna a sala atualizada.
cancelar_reserva(NumeroSala, ReservaParaCancelar, Resultado) :-
    (   get_sala(NumeroSala, Sala)
    ->  (   member(ReservaParaCancelar, Sala.reservas)
        ->  delete(Sala.reservas, ReservaParaCancelar, NovasReservas),
            NewSala = sala{numSala: Sala.numSala, nomeSala: Sala.nomeSala, reservas: NovasReservas},
            repository:save_sala(NewSala),
            Resultado = right(NewSala)
        ;   Resultado = left('Reserva não existente.')
        )
    ;   Resultado = left('Sala não encontrada.')
    ).

% reserva uma sala para um usuário específico em uma faixa de datas específica com base na sua prioridade. Recebe o número de sala, o usuário, a data de início e a data de término e retorna a sala atualizada com a reserva adicionada se a reserva foi realizada, se tiverem conflitos com outras reservas, ela retorna um erro.
reservar_sala(NumeroSala, Matricula, Inicio, Termino, Resultado) :-
    get_sala(NumeroSala, Sala),
    (   Reservas = Sala.reservas
    ->  NovaReserva = reserva(Matricula, Inicio, Termino),
        reserva_conflitantes(NovaReserva, Reservas, Conflitantes),
        findall((PriConflitante, ResConflitante), (
            member(ResConflitante, Conflitantes),
            ResConflitante = reserva(MatriculaRes, _, _),
            fetch_usuario(MatriculaRes, UserConflit),
            prioridade_usuario(UserConflit, PriConflitante)
        ), Conflitos),
        fetch_usuario(Matricula, U),
        prioridade_usuario(U, MinhaPrioridade),
        (   forall(member((PriConflitante, ResConflitante), Conflitos), MinhaPrioridade > PriConflitante)
        ->  subtract(Reservas, Conflitantes, ReservasAtualizadas),
            append([NovaReserva], ReservasAtualizadas, NovasReservas),
            NewSala = Sala.put(_{reservas: NovasReservas}),
            repository:save_sala(NewSala),
            Resultado = right(NewSala)
        ;   Resultado = left('Sala não disponível para reserva.')
        )
    ;   Resultado = left('Sala não encontrada.')
    ).