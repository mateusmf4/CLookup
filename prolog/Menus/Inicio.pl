:- module(inicio, [menuInicio/0]).

:- use_module('Menus/Utils.pl').
:- use_module('Menus/Login.pl', [menuLogin/0]).
:- use_module('Menus/Cadastro.pl', [menuCadastro/0]).

printBanner :- 
    printCor("&l╔═══════════════════════════════════════════════════════════════════════════════╗\n"),
    printCor("║                                                                               ║\n"),
    printCor("║                 ______  __                 __               _______           ║\n"),
    printCor("║               .' ___  |[  |               [  |  _          |_   __ |          ║\n"),
    printCor("║             / .'   |_| | |  .--.    .--.  | | / ] __   _    | |__) |          ║\n"),
    printCor("║             | |        | |/ .'`| |/ .'`| || '' < [  | | |   |  ___/           ║\n"),
    printCor("║             | `.___.'| | || |__. || |__. || |`| | | |_/ |, _| |_              ║\n"),
    printCor("║              `.____ .'[___]'.__.'  '.__.'[__|  |_]'.__.'_/|_____|             ║\n"),
    printCor("║                                                                               ║\n"),
    printCor("║       Menu:                                                                   ║\n"),
    printCor("║          &r&b1. Login    &r&l                                                         ║\n"),
    printCor("║          &r&b2. Cadastro &r&l                                                         ║\n"),
    printCor("║          &r&b3. Sair     &r&l                                                         ║\n"),
    printCor("║                                                                               ║\n"),
    printCor("║                                                                               ║\n"),
    printCor("║       Digite a opção:                                                         ║\n"),
    printCor("╚═══════════════════════════════════════════════════════════════════════════════╝&r\n").

menuInicio :- 
    clearScreen,
    printBanner,
    readNumber(I), 
    (I == 1 -> menuLogin; I == 2 -> menuCadastro; I == 3 -> sair; writeln("Erro: Opção invalida!")),
    menuInicio.

sair:- writeln("Até mais!"), halt(0).