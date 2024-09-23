:- module(inicio, [menuInicio/0]).

:- use_module('Utils.pl').
:- use_module('Login.pl').
:- use_module('Cadastro.pl').

menu:- 
    writeln("╔═══════════════════════════════════════════════════════════════════════════════╗"),
    writeln("║                                                                               ║"),
    writeln("║                 ______  __                 __               _______           ║"),
    writeln("║               .' ___  |[  |               [  |  _          |_   __ |          ║"),
    writeln("║             / .'   |_| | |  .--.    .--.  | | / ] __   _    | |__) |          ║"),
    writeln("║             | |        | |/ .'`| |/ .'`| || '' < [  | | |   |  ___/           ║"),
    writeln("║             | `.___.'| | || |__. || |__. || |`| | | |_/ |, _| |_              ║"),
    writeln("║              `.____ .'[___]'.__.'  '.__.'[__|  |_]'.__.'_/|_____|             ║"),
    writeln("║                                                                               ║"),
    writeln("║       Menu:                                                                   ║"),
    writeln("║          1. Login                                                             ║"),
    writeln("║          2. Cadastro                                                          ║"),
    writeln("║          3. Sair                                                              ║"),
    writeln("║                                                                               ║"),
    writeln("║                                                                               ║"),
    writeln("║       Digite a opção:                                                         ║"),
    writeln("╚═══════════════════════════════════════════════════════════════════════════════╝").

menuInicio :- 
    menu,
    readNumber(I), 
    (I == 1 -> menuLogin; I == 2 -> cadastro; I == 3 -> sair; writeln("Erro: Opção invalida!")),
    menuInicio.

sair:- writeln("Até mais!"), halt(0).