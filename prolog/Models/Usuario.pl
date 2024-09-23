:- module(modelUsuario, [newUsuario/4, prioridadeUsuario/2]).

% define os tipos e prioridades validas.
tipoPrioridade(estudante, 1).
tipoPrioridade(monitor, 2).
tipoPrioridade(professor, 3).

newUsuario(Matricula, Nome, TipoUsuario, R) :-
    % verifica que o tipo de usuario é valido
    tipoPrioridade(TipoUsuario, _),
    R = usuario{matricula: Matricula, nome: Nome, tipo: TipoUsuario}.

% Retorna a prioridade do dado usuario.
prioridadeUsuario(Usuario, R) :-
    tipoPrioridade(Usuario.tipo, R).