:- module(modelSala, [salasPadroes/1]).

salasPadroes(R) :-
    Padrao = sala{numSala: 0, nomeSala: "", reservas: []},   
    R = _{
        '1': Padrao.put(_{numSala: 1, nomeSala: "Patos"}),
        '2': Padrao.put(_{numSala: 2, nomeSala: "Cuités"}),
        '3': Padrao.put(_{numSala: 3, nomeSala: "Sousa"}),
        '4': Padrao.put(_{numSala: 4, nomeSala: "LCC 1"}),
        '5': Padrao.put(_{numSala: 5, nomeSala: "LCC 2"}),
        '6': Padrao.put(_{numSala: 6, nomeSala: "LCC 3"}),
        '7': Padrao.put(_{numSala: 7, nomeSala: "CP-01"})
    }.