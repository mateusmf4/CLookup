:- module(date_utils, [inicio_dia/2, fim_dia/2, inicio_semana/2, fim_semana/2, inicio_mes/2, fim_mes/2, date_to_datetime/3]).

% Converte uma data para um datetime, usando fuso horario local, com o horario dado.
date_to_datetime(date(Y, Mes, D), time(H, Min, S), DateTime) :-
    get_time(Timestamp),
    stamp_date_time(Timestamp, DateTimeLocal, local),
    DateTimeLocal = date(_, _, _, _, _, _, Off, TZ, DST),
    DateTime = date(Y, Mes, D, H, Min, S, Off, TZ, DST), !.

% Modifica o horario de um datetime.
date_to_datetime(date(Y, Mes, D, _, _, _, Off, TZ, DST), time(H, Min, S), date(Y, Mes, D, H, Min, S, Off, TZ, DST)) :- !.

% Retorna o datetime do inicio do dia
inicio_dia(DateTime, R) :- date_to_datetime(DateTime, time(0, 0, 0), R).
% Retorna o datetime do fim do dia
fim_dia(DateTime, R) :- date_to_datetime(DateTime, time(23, 59, 59), R).

% Subtrai `DiasAtras` da Data
dias_atras(Data, DiasAtras, NovaData) :-
    date_time_stamp(Data, Timestamp),
    SegundosAtras is DiasAtras * 86400, % 1 dia = 86400 segundos
    NovoTimestamp is Timestamp - SegundosAtras,
    stamp_date_time(NovoTimestamp, NovaData, local).

% Adiciona `DiasParaFrente` na Data
dias_frente(Data, DiasParaFrente, NovaData) :-
    date_time_stamp(Data, Timestamp),
    SegundosParaFrente is DiasParaFrente * 86400, % 1 dia = 86400 segundos
    NovoTimestamp is Timestamp + SegundosParaFrente,
    stamp_date_time(NovoTimestamp, NovaData, local).

% Encontra o início da semana (domingo como primeiro dia).
inicio_semana(Data, InicioSemana) :-
    date_time_value(date, Data, D),
    day_of_the_week(D, DiaSemana),
    DiasAtras is DiaSemana mod 7,
    dias_atras(Data, DiasAtras, I),
    date_to_datetime(I, time(0, 0, 0), InicioSemana).

% Encontra o fim da semana (sábado como último dia).
fim_semana(Data, FimSemana) :-
    date_time_value(date, Data, D),
    day_of_the_week(D, DiaSemana),
    DiasParaFrente is 6 - (DiaSemana mod 7),
    dias_frente(Data, DiasParaFrente, I),
    date_to_datetime(I, time(23, 59, 59), FimSemana).

% Calcula se o ano é bissexto
ano_bissexto(Ano) :-
    % Deve ser multiplo de 4
    Ano mod 4 =:= 0,
    % Se o ano é divisivel por 100, deve ser divisivel por 400
    (Ano mod 100 =:= 0 -> Ano mod 400 =:= 0; true).

% Calcula o ultimo dia do mês, levando em conta ano bissexto para fevereiro.
ultimo_dia_mes(Ano, Mes, UltimoDia) :-
    (Mes = 2 -> (
        % Se o mês é fevereiro, temos que calcular se o ano é bissexto
        (ano_bissexto(Ano) -> UltimoDia = 29
        ; UltimoDia = 28)
    ); member(Mes, [4, 6, 9, 11]) -> 
        UltimoDia = 30
    ; UltimoDia = 31).

% Calcula a primeira data do mês
inicio_mes(Data, InicioMes) :-
    date_time_value(month, Data, Mes),
    date_time_value(year, Data, Ano),
    date_to_datetime(date(Ano, Mes, 1), time(0, 0, 0), InicioMes).

% Calcula a ultima data do mês
fim_mes(Data, FimMes) :-
    date_time_value(month, Data, Mes),
    date_time_value(year, Data, Ano),
    ultimo_dia_mes(Ano, Mes, UltimoDia),
    date_to_datetime(date(Ano, Mes, UltimoDia), time(23, 59, 59), FimMes).