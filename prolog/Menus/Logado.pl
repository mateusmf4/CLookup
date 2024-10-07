:- module(logado, [menu_logado/1]).

:- use_module('Menus/Utils.pl').
:- use_module('Menus/Login.pl', [menuLogin/0]).
:- use_module('Menus/Cadastro.pl', [menuCadastro/0]).

:- use_module('Models/Sala.pl').
:- use_module('Models/Usuario.pl').

:- use_module('Controllers/UsuarioController.pl').
:- use_module('Controllers/SalaController.pl').

:- use_module('Repository.pl').
:- use_module('DateUtils.pl').
:- use_module(library(readutil)).

bem_vindo :-
    print_cor("&l"),
    writeln("╔═══════════════════════════════════════════════════════════╗"),
    writeln("║    ____                  __     ___           _           ║"),
    writeln("║   | __ )  ___ _ __ ___   | |   / (_)_ __   __| | ___      ║"),
    writeln("║   |  _ | / _ | '_ ` _ |   | | / /| | '_  |/  _`|/ _ |     ║"),
    writeln("║   | |_) |  __/ | | | | |   | V / | | | | ||(_| ||(_)|     ║"),
    writeln("║   |____/ |___|_| |_| |_|    |_/  |_|_| |_||__,_||___/     ║"),
    writeln("╚═══════════════════════════════════════════════════════════╝"),
    print_cor("&r").

texto_sala :-
    print_cor("&l"),
    writeln("╔═══════════════════════════════════════════════════════════╗"),
    writeln("║                ____        _                              ║"),
    writeln("║               / ___|  __ _| | __ _                        ║"),
    writeln("║               |___ | / _` | |/ _` |                       ║"),
    writeln("║                ___) | (_| | | (_| |                       ║"),
    writeln("║               |____/ |__,_|_||__,_|                       ║"),
    writeln("╚═══════════════════════════════════════════════════════════╝"),
    print_cor("&r").


% Apresenta o menu principal de um usuario logado, recebendo o usuario que está logado no sistema.
menu_logado(Usuario) :-
    clear_screen,

    bem_vindo, nl,

    TipoUsuario = Usuario.tipo,
    ( TipoUsuario = professor -> Extra = "[PROFESSOR] "
    ; TipoUsuario = monitor -> Extra = "[MONITOR] "
    ; Extra = ""
    ),
    print_cor("Bem-vindo ao sistema, &l~w&r~w\n\n", [Extra, Usuario.nome]),

    % Exibe opções baseadas no tipo de usuário
    (TipoUsuario \= professor ->
        print_menu_escolhas([
            ('Ver Reservas de Sala', logado:menu_listar_salas),
            ('Reservar Sala', logado:menu_reserva_sala(Usuario)),
            ('Cancelar Reserva', logado:cancelar_reserva(Usuario)),
            ('Sair', halt)
        ])
    ;
        print_menu_escolhas([
            ('Ver Reservas de Sala', logado:menu_listar_salas),
            ('Reservar Sala', logado:menu_reserva_sala(Usuario)),
            ('Cancelar Reserva', logado:cancelar_reserva(Usuario)),
            ('Tornar Estudante Monitor', logado:menu_monitor),
            ('Sair', halt)
        ])
    ),
    menu_logado(Usuario). % Chama recursivamente para manter o menu ativo.

escolher_sala(R) :-
    write('Salas disponíveis:\n\n'),
    listar_salas(Salas),

    forall(member(Sala, Salas), (
        format("~w. ~w\n", [Sala.numSala, Sala.nomeSala])
    )),

    writeln('\nDigite o número da sala: '),
    read_number(NumeroSala), get_sala(NumeroSala, _),
    R = NumeroSala.

% Menu que lista a sala e permite visualizar as reservas.
menu_listar_salas :-
    clear_screen,
    texto_sala,

    (escolher_sala(NumeroSala), get_sala(NumeroSala, Sala)) -> (
        % Calcula as faixas de tempo baseado no dia atual
        get_time(Timestamp), stamp_date_time(Timestamp, DateHoje, local),

        inicio_dia(DateHoje, InicioHoje),
        fim_dia(DateHoje, FimHoje),

        inicio_semana(DateHoje, InicioSemana),
        fim_semana(DateHoje, FimSemana),

        inicio_mes(DateHoje, InicioMes),
        fim_mes(DateHoje, FimMes),

        % Agora perguntar pro usuario
        writeln('\nDeseja ver as reservas de que período?\n'),
        print_menu_escolhas([
            ('Hoje', logado:menu_reservas_periodo(Sala, InicioHoje, FimHoje)),
            ('Semana', logado:menu_reservas_periodo(Sala, InicioSemana, FimSemana)),
            ('Mês', logado:menu_reservas_periodo(Sala, InicioMes, FimMes))
        ]),

        aguarde_enter
    )
    ; (
        writeln('Sala não encontrada.'),
        aguarde_enter
    ).

menu_reservas_periodo(Sala, Inicio, Fim) :-
    date_time_stamp(Inicio, InicioStamp),
    date_time_stamp(Fim, FimStamp),

    sala_reservas_em_faixa(Sala.reservas, InicioStamp, FimStamp, ReservasEmFaixa),

    print_cor("\n&l~w. ~w&r\n", [Sala.numSala, Sala.nomeSala]),
    forall(member(reserva(_, RInicio, RFim), ReservasEmFaixa), (
        stamp_date_time(RInicio, InicioDate, local),
        stamp_date_time(RFim, FimDate, local),

        date_time_value(date, InicioDate, InicioDia),
        date_time_value(date, FimDate, FimDia),
        (InicioDia = FimDia -> FormatFim = "%H:%M"; FormatFim = "%d/%m/%Y %H:%M"),

        format_time(atom(StringInicio), "%d/%m/%y %H:%M", InicioDate),
        format_time(atom(StringFim), FormatFim, FimDate),

        format(" - ~w até ~w\n", [StringInicio, StringFim])
    )),
    (ReservasEmFaixa = [] -> writeln("  Nenhuma reserva nesse período."); true).

menu_monitor :-
    clear_screen,
    writeln("Estudantes cadastrados:"),
    usuario_controller:listar_alunos(Usuarios),
    print_cor("&cMatr. Nome&r\n"),
    forall(member(Usuario, Usuarios), (
        (Usuario.tipo = monitor -> Sufixo = " - Monitor"; Sufixo = ""),
        print_cor("~w. ~w~w\n", [Usuario.matricula, Usuario.nome, Sufixo])
    )),
    writeln("\nInforme a matricula do aluno: "),
    read_number(M),
    (atualiza_monitor(M)
    -> writeln("Monitor adicionado!")
    ; writeln("Estudante não encontrado")),
    aguarde_enter.


% Menu para reservar uma sala específica em um horário
menu_reserva_sala(Usuario) :-
    clear_screen,
    
    escolher_sala(NumeroSala) -> (
    writeln("Digite a data da reserva (DD/MM/AAAA): "),
    read_line_to_string(user_input, DataString),
    split_string(DataString, "/", "", [DDString, MMString, AAAAString]),
    atom_number(DDString, Dia),
    atom_number(MMString, Mes),
    atom_number(AAAAString, Ano),

    writeln("Digite o horário de início (HH:MM): "),
    read_line_to_string(user_input, HorarioInicioString),
    split_string(HorarioInicioString, ":", "", [HInicioString, MInicioString]),
    atom_number(HInicioString, HoraInicio),
    atom_number(MInicioString, MinutoInicio),

    writeln("Digite o horário de fim (HH:MM): "),
    read_line_to_string(user_input, HorarioFimString),
    split_string(HorarioFimString, ":", "", [HFimString, MFimString]),
    atom_number(HFimString, HoraFim),
    atom_number(MFimString, MinutoFim),

    % Cria a data e hora para o início e fim da reserva
    date_to_datetime(date(Ano, Mes, Dia), time(HoraInicio, MinutoInicio, 0), InicioReserva),
    date_to_datetime(date(Ano, Mes, Dia), time(HoraFim, MinutoFim, 0), FimReserva),

    date_time_stamp(InicioReserva, Inicio),
    date_time_stamp(FimReserva, Fim),
    
    % Tenta reservar a sala usando a função do controlador de sala
    sala_controller:reservar_sala(NumeroSala, Usuario.matricula, Inicio, Fim, Resultado),
    (Resultado = left(Erro) ->
        format("Erro: ~w\n", [Erro]);
        writeln("Reserva feita com sucesso!")
    ),
    
    aguarde_enter
    ); (
        writeln('Sala não encontrada.'),
        aguarde_enter
    ).

% Menu para cancelar uma reserva
cancelar_reserva(Usuario) :-
    clear_screen,

    ((escolher_sala(NumeroSala), get_sala(NumeroSala, Sala)) ->
        Reservas = Sala.reservas,
        writeln("Reservas disponíveis para cancelamento:\n"),

        % Lista as reservas do usuário atual na sala
        findall(Reserva,
            (member(Reserva, Reservas), Reserva = reserva(Usuario.nome, _, _)),
            ReservasUsuario),

        (ReservasUsuario = [] ->
            writeln("Você não tem reservas nesta sala."),
            aguarde_enter
        ;
            % Exibe as reservas do usuário na sala
            forall(
                nth1(Index, ReservasUsuario, reserva(_, Inicio, Termino)),
                format("~w. Reserva de ~w a ~w\n", [Index, Inicio, Termino])
            ),

            writeln("\nDigite o número da reserva que deseja cancelar: "),
            read_number(NumeroReserva),

            nth1(NumeroReserva, ReservasUsuario, ReservaParaCancelar),

            % Chama a função de cancelamento da reserva
            cancelar_reserva(NumeroSala, ReservaParaCancelar, Resultado),
            (Resultado = right(_) ->
                writeln("Reserva cancelada com sucesso!");
                writeln("Erro: Não foi possível cancelar a reserva.")
            ),
            aguarde_enter
        )
    ;
        writeln("Sala não encontrada."),
        aguarde_enter
    ).
