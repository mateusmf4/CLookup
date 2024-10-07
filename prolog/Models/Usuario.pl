:- module(model_usuario, [new_usuario/4, prioridade_usuario/2]).

% define os tipos e prioridades validas.
tipo_prioridade(estudante, 1).
tipo_prioridade(monitor, 2).
tipo_prioridade(professor, 3).

new_usuario(Matricula, Nome, TipoUsuario, R) :-
    % verifica que o tipo de usuario é valido
    tipo_prioridade(TipoUsuario, _),
    R = usuario{matricula: Matricula, nome: Nome, tipo: TipoUsuario}.

% Retorna a prioridade do dado usuario.
prioridade_usuario(Usuario, R) :-
    tipo_prioridade(Usuario.tipo, R).