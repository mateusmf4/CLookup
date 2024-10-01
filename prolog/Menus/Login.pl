:- module(login, [menuLogin/0]).

:- use_module('Menus/Utils.pl').
:- use_module('Menus/Logado.pl').

:- use_module('Repository.pl').

login :- 
    printCor("&l╔══════════════════════════════════════════════════════════╗\n"), 
    printCor("║                _                _                        ║\n"),
    printCor("║               | |    ___   __ _(_)_ __                   ║\n"),
    printCor("║               | |   / _ | / _` | | '_ |                  ║\n"),
    printCor("║               | |__| (_) | (_| | | | | |                 ║\n"),
    printCor("║               |_____║___/ ║__, |_|_| |_|                 ║\n"),
    printCor("║                           |___/                          ║\n"),
    printCor("╚══════════════════════════════════════════════════════════╝&r\n").

menuLogin :-
    clearScreen,
    login,
    writeln("Digite sua matrícula: "),
    readNumber(M),
    (fetchUsuario(M, U) -> menu_logado(U); writeln("Não existe usuário com essa matrícula!"), aguarde_enter).