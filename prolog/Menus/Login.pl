:- module(login, [menuLogin/0]).
:- use_module('Menus/Logado.pl', [menuLogado/0]).
:- use_module('Menus/Utils.pl').
:- use_module('Menus/Logado.pl').

:- use_module('Repository.pl').

login :- 
    print_cor("&l╔══════════════════════════════════════════════════════════╗\n"), 
    print_cor("║                _                _                        ║\n"),
    print_cor("║               | |    ___   __ _(_)_ __                   ║\n"),
    print_cor("║               | |   / _ | / _` | | '_ |                  ║\n"),
    print_cor("║               | |__| (_) | (_| | | | | |                 ║\n"),
    print_cor("║               |_____║___/ ║__, |_|_| |_|                 ║\n"),
    print_cor("║                           |___/                          ║\n"),
    print_cor("╚══════════════════════════════════════════════════════════╝&r\n").

menuLogin :-
    clear_screen,
    login,
    writeln("Digite sua matrícula: "),
    readStr(M),
    (fetch_usuario(M, U) -> menuLogado(U);  erro("Não existe usuário com essa matrícula!"), aguarde_enter).
