:- use_module(library(date)).
:- module(modelReserva, [newReserva/4, parse_date_time/2]).

parse_date_time(String, DateTime) :-
    parse_time(String, '%d/%m/%Y %H:%M', DateTime).

newReserva(Matricula, Inicio, Termino, R) :-
    parse_date_time(Inicio, InicioDateTime),
    parse_date_time(Termino, TerminoDateTime),
    stamp_date_time(InicioDateTime, 'UTC', InicioStamp),
    stamp_date_time(TerminoDateTime, 'UTC', TerminoStamp),
    R = reserva(Matricula, InicioStamp, TerminoStamp).