:- use_module(models(usuario)).
:- module(usuario_controller, [listar_usuarios/1]).
:- module(repository, [fetchUsuario/1, fetchAllUsuarios/1]).

cadastraUsuario(Matricula, Nome, TipoUsuario, R) :- 
    repository:fetchUsuario(Matricula, usuarioCadastrado),
    (usuarioCadastrado = false -> 
        saveUsuario(usuario(Matricula, Nome, TipoUsuario)),
        R = sucesso('Usuário cadastrado com sucesso');
        R = erro('Usuário com mesma matricula já existe!')).
       
atualizaMonitor(Matricula, R) :-
    repository:fetchUsuario(Matricula, UsuarioCadastrado) -> (
        UsuarioCadastrado.tipo = 'monitor', 
            monitorAtualizado = UsuarioCadastrado.(_{tipo:'estudante'}),
            saveUsuario(monitorAtualizado),
            R = sucesso('Usuário atualizado com sucesso');
        UsuarioCadastrado.tipo = 'estudante', 
            estudanteAtualizado = UsuarioCadastrado.(_{tipo:'monitor'}),
            saveUsuario(estudanteAtualizado),
            R = sucesso('Usuário atualizado com sucesso');
        R = erro('Usuário não é estudante ou monitor!').
    );
        R = erro('Usuário não cadastrado!').
        
listar_usuarios(Usuarios) :-
    fetchAllUsuarios(Usuarios).
