:- module(repository, []).

:- use_module(library(http/json)).
:- use_module(library(filesex)).
:- use_module('./Models/Sala.pl').

databasePath("./Database/dados.json").

defaultDatabase(R) :-
    salasPadroes(Salas),
    R = _{usuarios: _{}, salas: Salas}.

readDatabaseFile(R) :-
    databasePath(Path),
    open(Path, read, Stream),
    json_read_dict(Stream, R),
    close(Stream).

loadDatabase(R) :-
    defaultDatabase(D),
    (catch(readDatabaseFile(Dados), _, false) ->
        R = D.put(Dados); R = D).

saveDatabase(Dados) :-
    databasePath(Path),
    file_directory_name(Path, PathParent),
    make_directory_path(PathParent),
    open(Path, write, Stream),
    json_write_dict(Stream, Dados),
    close(Stream).

fetchUsuario(Matricula, Usuario) :-
    loadDatabase(Dados),
    Usuario = Dados.usuarios.get(Matricula).

saveUsuario(Usuario) :-
    loadDatabase(Dados),
    % chave deve ser um atom, não pode ser string ou number
    atom_number(Matricula, Usuario.matricula),
    NewDados = Dados.put(usuarios/Matricula, Usuario),
    saveDatabase(NewDados).
