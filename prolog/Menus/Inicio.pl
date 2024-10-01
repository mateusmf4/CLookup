:- module(inicio, [menuInicio/0]).

:- use_module('Menus/Utils.pl').
:- use_module('Menus/Login.pl', [menuLogin/0]).
:- use_module('Menus/Cadastro.pl', [menuCadastro/0]).

printBanner :- 
    print_cor("&l╔═══════════════════════════════════════════════════════════════════════════════╗\n"),
    print_cor("║                                                                               ║\n"),
    print_cor("║                 ______  __                 __               _______           ║\n"),
    print_cor("║               .' ___  |[  |               [  |  _          |_   __ |          ║\n"),
    print_cor("║             / .'   |_| | |  .--.    .--.  | | / ] __   _    | |__) |          ║\n"),
    print_cor("║             | |        | |/ .'`| |/ .'`| || '' < [  | | |   |  ___/           ║\n"),
    print_cor("║             | `.___.'| | || |__. || |__. || |`| | | |_/ |, _| |_              ║\n"),
    print_cor("║              `.____ .'[___]'.__.'  '.__.'[__|  |_]'.__.'_/|_____|             ║\n"),
    print_cor("║                                                                               ║\n"),
    print_cor("║       Menu:                                                                   ║\n"),
    print_cor("║          &r&b1. Login    &r&l                                                         ║\n"),
    print_cor("║          &r&b2. Cadastro &r&l                                                         ║\n"),
    print_cor("║          &r&b3. Sair     &r&l                                                         ║\n"),
    print_cor("║                                                                               ║\n"),
    print_cor("║                                                                               ║\n"),
    print_cor("║       Digite a opção:                                                         ║\n"),
    print_cor("╚═══════════════════════════════════════════════════════════════════════════════╝&r\n").

menuInicio :- 
    clear_screen,
    printBanner,
    read_number(I), 
    (I == 1 -> menuLogin; I == 2 -> menuCadastro; I == 3 -> sair; writeln("Erro: Opção invalida!")),
    menuInicio.

sair:- writeln("Até mais!"), halt(0).