:- module(repository, [fetchUsuario/2, fetchAllUsuarios/2, saveUsuario/1, fetchSala/2, fetchAllSalas/1, saveSala/1]).

:- use_module(library(http/json)).
:- use_module(library(filesex)).
:- use_module('./Models/Sala.pl').

% Define o caminho padrão onde é guardado os dados.
databasePath("./database.json").

% Define o estado inicial do banco de dados, caso ainda não foi criado.
defaultDatabase(R) :-
    salasPadroes(Salas),
    R = _{usuarios: _{}, salas: Salas}.

% Lê o arquivo do banco de dados, lançando exceção quando o json é invalido,
% ou o arquivo não é presente.
readDatabaseFile(R) :-
    databasePath(Path),
    open(Path, read, Stream),
    json_read_dict(Stream, R),
    close(Stream).

% Retorna o banco de dados, ou o banco de dados inicial caso houve um erro.
loadDatabase(R) :-
    defaultDatabase(D),
    (catch(readDatabaseFile(Dados), _, false) ->
        R = D.put(Dados); R = D).

% Salva o banco de dados no arquivo json.
saveDatabase(Dados) :-
    databasePath(Path),
    file_directory_name(Path, PathParent),
    make_directory_path(PathParent),
    open(Path, write, Stream),
    json_write_dict(Stream, Dados),
    close(Stream).

% Garante que o tipo de um usuario é um atomo.
converteUsuario(Usuario, R) :-
    atom_string(TipoAtom, Usuario.tipo),
    R = Usuario.put(_{tipo: TipoAtom}).

% Procura um usuário no banco de dados pela matricula, se não for encontrado resulta em false.
fetchUsuario(Matricula, Usuario) :-
    loadDatabase(Dados),
    atom_number(Key, Matricula),
    converteUsuario(Dados.usuarios.get(Key), Usuario).

% Predicado que verifica se usuario é de um tipo, usado em fetchAllUsuarios
usuarioEhTipo(Tipo, Usuario) :-
    Usuario.tipo == Tipo.

% Retorna a lista de usuarios de tal tipo.
fetchAllUsuarios(Tipo, R) :-
    loadDatabase(Dados),
    atom_string(Tipo, TipoString),
    dict_pairs(Dados.usuarios, _, Pairs), pairs_values(Pairs, Usuarios),
    include(usuarioEhTipo(TipoString), Usuarios, Filtrado),
    maplist(converteUsuario, Filtrado, R).

% Adiciona um novo estudante no sistema, ou sobrescreve um existente dado que ambos tenham a mesma matricula.
saveUsuario(Usuario) :-
    loadDatabase(Dados),
    % chave deve ser um atom, não pode ser string ou number
    atom_number(Matricula, Usuario.matricula),
    NewDados = Dados.put(usuarios/Matricula, Usuario),
    saveDatabase(NewDados).

% Procura uma sala no banco de dados pelo número da sala, se não for encontrado resulta em false.
fetchSala(NumSala, Sala) :-
    loadDatabase(Dados),
    atom_number(Key, NumSala),
    Sala = Dados.salas.get(Key).

% Retorna todas as salas cadastradas no sistema.
fetchAllSalas(R) :-
    loadDatabase(Dados),
    dict_pairs(Dados.salas, _, Pairs), pairs_values(Pairs, R).

% Adiciona uma nova sala no sistema, ou sobrescreve uma existente dado que ambas tenham o mesmo número de sala.
saveSala(Sala) :-
    loadDatabase(Dados),
    atom_number(Key, Sala.numSala),
    NewDados = Dados.put(salas/Key, Sala),
    saveDatabase(NewDados).
