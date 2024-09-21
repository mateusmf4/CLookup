:- consult("Models/Sala.pl").

printSala(sala(Num, Nome)) :-
    format("Sala ~w - ~w\n", [Num, Nome]).
    
main :-
    writeln("Bem vindo ao sistema!"),
    writeln("Essas letras devem aparecer normalmente: á é í ó ú ç ã ê"),
    salasPadroes(Salas),
    maplist(printSala, Salas),
    halt.

:- initialization(main).

