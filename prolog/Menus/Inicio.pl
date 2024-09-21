:- module(inicio, [menuInicio/0]).

:- use_module('Menus/Utils.pl').

menuInicio :-
    write("Digite algo: "),
    readStr(N),
    format("Digitou ~w\n", [N]).