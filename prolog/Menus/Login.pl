:- module(login, [menuLogin/0]).
:- use_module('Utils.pl').

login:- 
    writeln("╔══════════════════════════════════════════════════════════╗"), 
    writeln("║                _                _                        ║"),
    writeln("║               | |    ___   __ _(_)_ __                   ║"),
    writeln("║               | |   / _ | / _` | | '_ |                  ║"),
    writeln("║               | |__| (_) | (_| | | | | |                 ║"),
    writeln("║               |_____║___/ ║__, |_|_| |_|                 ║"),
    writeln("║                           |___/                          ║"),
    writeln("╚══════════════════════════════════════════════════════════╝").

menuLogin:-
    login,
    writeln("Digite sua matrícula: "),
    readStr(M),
    writeln(M).