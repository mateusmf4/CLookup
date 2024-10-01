:- module(usuarioController, [atualiza_monitor/1, listar_estudantes/0]).

:- use_module('Repository.pl').

atualiza_monitor(Matricula) :-
    fetchUsuario(Matricula, User),
    print(User),
    User.put(tipo, monitor),
    print(User).

listar_estudantes :-
    fetchAllUsuarios(estudante, R),
    \+ listar(R).

listar([X|Y]) :-
    write(X.matricula), write(". "), write(X.nome),
    (usuarioEhTipo(monitor, X) -> writeln("- Monitor"); writeln("")),
    listar(Y).