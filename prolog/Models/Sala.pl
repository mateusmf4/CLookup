% sala(NumSala, NomeSala)

getNumSala(sala(X, _), X).
getNomeSala(sala(_, X), X).

salasPadroes([
    sala(1, "Patos"),
    sala(2, "Cuités"),
    sala(3, "Sousa"),
    sala(4, "LCC 1"),
    sala(5, "LCC 2"),
    sala(6, "LCC 3"),
    sala(7, "CP-01")
]).