:- module(usuarioController, [atualiza_monitor/1, listar_estudantes/0]).

:- use_module('Repository.pl').

atualiza_monitor(Matricula) :-
    fetch_usuario(Matricula, User),
    print(User),
    User.put(tipo, monitor),
    print(User).

listar_estudantes :-
    fetch_all_estudantes(R),
    \+ listar(R).

listar([X|Y]) :-
    write(X.matricula), write(". "), write(X.nome),
    (X.tipo = monitor -> writeln("- Monitor"); writeln("")),
    listar(Y).