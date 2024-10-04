:- module(login, [menuLogin/0]).
:- use_module('Menus/Logado.pl', [menuLogado/0]).
:- use_module('Menus/Utils.pl').
:- use_module('Repository.pl').

login :- 
    writeln("╔══════════════════════════════════════════════════════════╗"), 
    writeln("║                _                _                        ║"),
    writeln("║               | |    ___   __ _(_)_ __                   ║"),
    writeln("║               | |   / _ | / _` | | '_ |                  ║"),
    writeln("║               | |__| (_) | (_| | | | | |                 ║"),
    writeln("║               |_____║___/ ║__, |_|_| |_|                 ║"),
    writeln("║                           |___/                          ║"),
    writeln("╚══════════════════════════════════════════════════════════╝").

menuLogin :-
    clearScreen,
    login,
    writeln("Digite sua matrícula: "),
    readStr(M),
    (fetchUsuario(M, U) -> menuLogado(U);  erro("Não existe usuário com essa matrícula!")).