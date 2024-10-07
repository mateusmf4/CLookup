:- module(usuario_controller, []).
:- use_module('Controllers/UsuarioController.pl').
:- use_module('Repository.pl').

% cadastra um usuário 
cadastraUsuario(Matricula, Nome, TipoUsuario, R) :- 
    (repository:fetch_usuario(Matricula, _) ->
        save_usuario(usuario(Matricula, Nome, TipoUsuario)),
        R = sucesso('Usuário cadastrado com sucesso');
        R = erro('Usuário com mesma matricula já existe!')).
       
% transforma um estudante em monitor, ou retira o cargo de monitor de um estudante
atualizaMonitor(Matricula, R) :-
    repository:fetch_usuario(Matricula, UsuarioCadastrado) -> (
        UsuarioCadastrado.tipo = 'monitor', 
            monitorAtualizado = UsuarioCadastrado.(_{tipo:'estudante'}),
            save_usuario(monitorAtualizado),
            R = sucesso('Usuário atualizado com sucesso');
        UsuarioCadastrado.tipo = 'estudante', 
            estudanteAtualizado = UsuarioCadastrado.(_{tipo:'monitor'}),
            save_usuario(estudanteAtualizado),
            R = sucesso('Usuário atualizado com sucesso');
        R = erro('Usuário não é estudante ou monitor!')
    );
        R = erro('Usuário não cadastrado!').
        
listar_usuarios(Usuarios) :-
    fetch_all_usuarios(Usuarios).
