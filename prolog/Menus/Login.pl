:- module(login, [menuLogin/0]).
:- use_module('Menus/Logado.pl', [menuLogado/0]).
:- use_module('Menus/Utils.pl').
<<<<<<< HEAD
=======
:- use_module('Menus/Logado.pl').

>>>>>>> a3c736837e066cc627cfed3556bfcd3b9503ba34
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
    (fetchUsuario(M, U) -> menuLogado(U);  erro("Não existe usuário com essa matrícula!"), aguarde_enter).
