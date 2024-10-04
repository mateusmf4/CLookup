:- use_module(models(usuario)).
:- module(usuario_controller, [listar_usuarios/1]).
:- module(repository, [fetchUsuario/1, fetchAllUsuarios/1]).

cadastraUsuario(Matricula, Nome, TipoUsuario, R) :- 
    repository:fetch_usuario(Matricula, usuarioCadastrado),
    (usuarioCadastrado = false -> 
        save_usuario(usuario(Matricula, Nome, TipoUsuario)),
        R = sucesso('Usuário cadastrado com sucesso');
        R = erro('Usuário com mesma matricula já existe!')).
       
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
        R = erro('Usuário não é estudante ou monitor!').
    );
        R = erro('Usuário não cadastrado!').
        
listar_usuarios(Usuarios) :-
    fetch_all_usuarios(Usuarios).
