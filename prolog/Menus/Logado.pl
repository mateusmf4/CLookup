:- module(logado, [menu_logado/1]).

:- use_module('Menus/Utils.pl').
:- use_module('Menus/Login.pl', [menuLogin/0]).
:- use_module('Menus/Cadastro.pl', [menuCadastro/0]).

:- use_module('Models/Sala.pl').
:- use_module('Models/Usuario.pl').

:- use_module('Repository.pl').
:- use_module(library(date)).
:- use_module(library(readutil)).

bem_vindo :- 
    writeln("╔═══════════════════════════════════════════════════════════╗"), 
    writeln("║    ____                  __     ___           _           ║"),
    writeln("║   | __ )  ___ _ __ ___   | |   / (_)_ __   __| | ___      ║"),
    writeln("║   |  _ | / _ | '_ ` _ |   | | / /| | '_  |/  _`|/ _ |     ║"),
    writeln("║   | |_) |  __/ | | | | |   | V / | | | | ||(_| ||(_)|     ║"),
    writeln("║   |____/ |___|_| |_| |_|    |_/  |_|_| |_||__,_||___/     ║"),
    writeln("╚═══════════════════════════════════════════════════════════╝").

texto_sala :-
    writeln("╔═══════════════════════════════════════════════════════════╗"), 
    writeln("║                ____        _                              ║"),
    writeln("║               / ___|  __ _| | __ _                        ║"),
    writeln("║               |___ | / _` | |/ _` |                       ║"),
    writeln("║                ___) | (_| | | (_| |                       ║"),
    writeln("║               |____/ |__,_|_||__,_|                       ║"),
    writeln("╚═══════════════════════════════════════════════════════════╝").


% Apresenta o menu principal de um usuario logado, recebendo o usuario que está logado no sistema.
menu_logado(Usuario) :-
    clearScreen,

    TipoUsuario = Usuario.tipo,
    (TipoUsuario = professor ->
        Extra = "[PROFESSOR] "
    ; (TipoUsuario = monitor -> 
        Extra = "[MONITOR] "
        ; Extra = ""
    )
    ),
    printCor("Bem-vindo ao sistema, &l~w&r~w\n\n", [Extra, Usuario.nome]),

    % Obtém a prioridade do usuário
    prioridadeUsuario(Usuario, Prioridade),
    format('Sua prioridade é: ~d~n', [Prioridade]),

    % Exibe opções baseadas no tipo de usuário
    (TipoUsuario \= professor ->
        print_menu_escolhas([
            ('Ver Reservas de Sala', logado:menu_ver_sala),
            ('Reservar Sala', logado:reservar_sala(Usuario)),
            ('Cancelar Reserva', logado:cancelar_reserva(Usuario)),
            ('Sair', halt)
        ])
    ;
        print_menu_escolhas([
            ('Ver Reservas de Sala', logado:menu_ver_sala),
            ('Reservar Sala', logado:reservar_sala(Usuario)),
            ('Cancelar Reserva', logado:cancelar_reserva(Usuario)),
            ('Tornar Estudante Monitor', logado:menu_monitor),
            ('Sair', halt)
        ])
    ),
    menu_logado(Usuario). % Chama recursivamente para manter o menu ativo.

menu_ver_sala :-
    clearScreen,

    write('Salas disponíveis:\n'),
    listar_salas(Salas),
    write('Digite o número da sala: '),
    read(NumeroSala),
    obter_sala(NumeroSala, Sala),
    (   Sala \= []
    ->  obter_periodo(Inicio, Fim),
        reservas_sala(Sala, Inicio, Fim, Reservas),
        listar_salas(Sala, Reservas)
    ;   write('Sala não encontrada.'), nl
    ),
    aguarde_enter.

% Função para cancelar uma reserva específica
% Remove uma reserva da sala pelo número da sala, horário de início e término.
cancelarReservaSala(NumSala, HorarioInicio, HorarioFim) :-
    % Carrega a sala correspondente
    fetchSala(NumSala, Sala),
    
    % Verifica se a sala foi encontrada
    ( Sala == false ->
        write('Erro: Sala não encontrada!'), nl
    ;
        % Filtra as reservas, removendo a reserva com o intervalo especificado
        exclude(igualReserva(HorarioInicio, HorarioFim), Sala.reservas, NovasReservas),
        
        % Atualiza a sala com a nova lista de reservas
        NovaSala = Sala.put(reservas, NovasReservas),
        
        % Salva a sala atualizada no banco de dados
        saveSala(NovaSala)
    ).

% Predicado auxiliar para comparar as reservas com base no horário de início e fim.
igualReserva(HorarioInicio, HorarioFim, Reserva) :-
    Reserva.inicio == HorarioInicio,
    Reserva.fim == HorarioFim.

obter_hora_atual(Hora) :-
    get_time(Timestamp),
    stamp_date_time(Timestamp, DataHora, 'local'),
    Hora = DataHora.

obter_sala(Numero, Sala) :-
    sala(Sala),
    sala_numero(Sala, Numero),
    !.
obter_sala(_, []).

% Predicado para obter o período desejado
obter_periodo(Inicio, Fim) :-
    write('Deseja ver as reservas de que período?'), nl,
    write('1. Hoje'), nl,
    write('2. Semana'), nl,
    write('3. Mês'), nl,
    read(Opcao),
    periodo(Opcao, Inicio, Fim).

% Define o período com base na opção
periodo(1, Inicio, Fim) :-
    data_atual(Data),
    Inicio = Data,
    Fim = Data.
periodo(2, Inicio, Fim) :-
    data_atual(Data),
    inicio_semana(Data, Inicio),
    fim_semana(Data, Fim).
periodo(3, Inicio, Fim) :-
    data_atual(Data),
    inicio_mes(Data, Inicio),
    fim_mes(Data, Fim).

% Verifica se duas datas são no mesmo dia.
mesmo_dia(Inicio, Termino, true) :-
    date_time_value(date, Inicio, DataInicio),
    date_time_value(date, Termino, DataTermino),
    DataInicio = DataTermino.
mesmo_dia(_, _, false).

data_atual(Data) :-
    get_time(Agora),
    stamp_date_time(Agora, DataTime, local),
    date_time_value(date, DataTime, Data).

% Encontra o início da semana (domingo como primeiro dia).
inicio_semana(Data, InicioSemana) :-
    date_time_value(day_of_the_week, Data, DiaSemana),
    DiasAtras is DiaSemana - 1,
    dias_atras(Data, DiasAtras, InicioSemana).

% Encontra o fim da semana (sábado como último dia).
fim_semana(Data, FimSemana) :-
    date_time_value(day_of_the_week, Data, DiaSemana),
    DiasParaFrente is 7 - DiaSemana,
    dias_frente(Data, DiasParaFrente, FimSemana).

dias_atras(Data, DiasAtras, NovaData) :-
    date_time_stamp(Data, Timestamp),
    SegundosAtras is DiasAtras * 86400, % 1 dia = 86400 segundos
    NovoTimestamp is Timestamp - SegundosAtras,
    stamp_date_time(NovoTimestamp, NovaData, 'UTC').

dias_frente(Data, DiasParaFrente, NovaData) :-
    date_time_stamp(Data, Timestamp),
    SegundosParaFrente is DiasParaFrente * 86400, % 1 dia = 86400 segundos
    NovoTimestamp is Timestamp + SegundosParaFrente,
    stamp_date_time(NovoTimestamp, NovaData, 'UTC').

ultimo_dia_mes(Ano, Mes, UltimoDia) :-
(Mes = 2 ->
    (Ano mod 4 =:= 0 -> UltimoDia = 29 ; UltimoDia = 28)
; member(Mes, [4, 6, 9, 11]) -> 
    UltimoDia = 30
; UltimoDia = 31).

inicio_mes(Data, InicioMes) :-
    date_time_value(month, Data, Mes),
    date_time_value(year, Data, Ano),
    InicioMes = date(Ano, Mes, 1).

fim_mes(Data, FimMes) :-
    date_time_value(month, Data, Mes),
    date_time_value(year, Data, Ano),
    ultimo_dia_mes(Ano, Mes, UltimoDia),
    FimMes = date(Ano, Mes, UltimoDia).
