salasPadroes(R) :-
    Padrao = sala{numSala: 0, nomeSala: "", reservas: []},   
    R = [
        Padrao.put(_{numSala: 1, nomeSala: "Patos"}),
        Padrao.put(_{numSala: 2, nomeSala: "Cuités"}),
        Padrao.put(_{numSala: 3, nomeSala: "Sousa"}),
        Padrao.put(_{numSala: 4, nomeSala: "LCC 1"}),
        Padrao.put(_{numSala: 5, nomeSala: "LCC 2"}),
        Padrao.put(_{numSala: 6, nomeSala: "LCC 3"}),
        Padrao.put(_{numSala: 7, nomeSala: "CP-01"})
    ].