:- module(repository, [fetch_usuario/2, fetch_all_usuarios/2, fetch_all_usuarios/1, fetch_all_alunos/1, save_usuario/1, fetch_sala/2, fetch_all_salas/1, save_sala/1]).

:- use_module(library(http/json)).
:- use_module(library(filesex)).
:- use_module('./Models/Sala.pl').

% Define o caminho padrão onde é guardado os dados.
database_path("./database.json").

% Define o estado inicial do banco de dados, caso ainda não foi criado.
default_database(R) :-
    salasPadroes(Salas),
    R = _{usuarios: _{}, salas: Salas}.

% Lê o arquivo do banco de dados, lançando exceção quando o json é invalido,
% ou o arquivo não é presente.
read_database_file(R) :-
    database_path(Path),
    open(Path, read, Stream),
    json_read_dict(Stream, R),
    close(Stream).

% Retorna o banco de dados, ou o banco de dados inicial caso houve um erro.
load_database(R) :-
    default_database(D),
    (catch(read_database_file(Dados), _, false) ->
        R = D.put(Dados); R = D).

% Salva o banco de dados no arquivo json.
save_database(Dados) :-
    database_path(Path),
    file_directory_name(Path, PathParent),
    make_directory_path(PathParent),
    open(Path, write, Stream),
    json_write_dict(Stream, Dados),
    close(Stream).

% Garante que o tipo de um usuario é um atomo.
converte_usuario(Usuario, R) :-
    atom_string(TipoAtom, Usuario.tipo),
    R = Usuario.put(_{tipo: TipoAtom}).

% Procura um usuário no banco de dados pela matricula, se não for encontrado resulta em false.
fetch_usuario(Matricula, Usuario) :-
    load_database(Dados),
    atom_number(Key, Matricula),
    converte_usuario(Dados.usuarios.get(Key), Usuario).

% Predicado que verifica se usuario é de um tipo, usado em fetch_all_usuarios
usuario_eh_tipo(Tipo, Usuario) :-
    Usuario.tipo == Tipo.

% Retorna a lista de usuarios de tal tipo.
fetch_all_usuarios(Tipo, R) :-
    load_database(Dados),
    atom_string(Tipo, TipoString),
    dict_pairs(Dados.usuarios, _, Pairs), pairs_values(Pairs, Usuarios),
    include(usuario_eh_tipo(TipoString), Usuarios, Filtrado),
    maplist(converte_usuario, Filtrado, R).

% Retorna a lista de todos os usuarios.
fetch_all_usuarios(R) :-
    load_database(Dados),
    dict_pairs(Dados.usuarios, _, Pairs), pairs_values(Pairs, Usuarios),
    maplist(converte_usuario, Usuarios, R).

% Predicado auxiliar.
usuario_nao_eh_professor(Usuario) :-
    Usuario.tipo \= "professor".

% Retorna a lista de usuarios que não são professores.
fetch_all_alunos(R) :-
    load_database(Dados),
    dict_pairs(Dados.usuarios, _, Pairs), pairs_values(Pairs, Usuarios),
    include(usuario_nao_eh_professor, Usuarios, Filtrado),
    maplist(converte_usuario, Filtrado, R).

% Adiciona um novo estudante no sistema, ou sobrescreve um existente dado que ambos tenham a mesma matricula.
save_usuario(Usuario) :-
    load_database(Dados),
    % chave deve ser um atom, não pode ser string ou number
    atom_number(Matricula, Usuario.matricula),
    NewDados = Dados.put(usuarios/Matricula, Usuario),
    save_database(NewDados).

% Procura uma sala no banco de dados pelo número da sala, se não for encontrado resulta em false.
fetch_sala(NumSala, Sala) :-
    load_database(Dados),
    atom_number(Key, NumSala),
    Sala = Dados.salas.get(Key).

% Retorna todas as salas cadastradas no sistema.
fetch_all_salas(R) :-
    load_database(Dados),
    dict_pairs(Dados.salas, _, Pairs), pairs_values(Pairs, R).

% Adiciona uma nova sala no sistema, ou sobrescreve uma existente dado que ambas tenham o mesmo número de sala.
save_sala(Sala) :-
    load_database(Dados),
    atom_number(Key, Sala.numSala),
    NewDados = Dados.put(salas/Key, Sala),
    save_database(NewDados).
