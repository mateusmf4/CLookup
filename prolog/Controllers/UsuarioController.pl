:- module(usuario_controller, [listar_alunos/1, atualiza_monitor/1, cadastra_usuario/4]).
:- use_module('Models/Usuario.pl').
:- use_module('Repository.pl').

cadastra_usuario(Matricula, Nome, TipoUsuario, R) :- 
    (repository:fetch_usuario(Matricula, _) ->
        R = erro('Usuário com mesma matricula já existe!');
        (model_usuario:new_usuario(Matricula, Nome, TipoUsuario, U) ->
            repository:save_usuario(U),
            R = sucesso('Usuário cadastrado com sucesso');
        R = erro('Tipo de usuário invalido.'))
    ).

oposto(monitor, estudante).
oposto(estudante, monitor).

atualiza_monitor(Matricula) :-
    repository:fetch_usuario(Matricula, Usuario),
    member(Usuario.tipo, [monitor, estudante]),
    oposto(Usuario.tipo, NovoTipo),
    NovoUsuario = Usuario.put(_{tipo: NovoTipo}),
    repository:save_usuario(NovoUsuario).
        
listar_alunos(Usuarios) :-
    fetch_all_alunos(Usuarios).
