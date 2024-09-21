:- use_module('Menus/Inicio.pl').

main :-
    writeln("Bem vindo ao sistema!"),
    writeln("Essas letras devem aparecer normalmente: á é í ó ú ç ã ê"),
    menuInicio,
    halt.

:- initialization(main).

