:- module(utils, [read_str/1, read_number/1, print_cor/1, print_cor/2, clear_screen/0, aguarde_enter/0, print_menu_escolhas/1, ler_numero_escolhas/3]).

read_str(R) :- read_line_to_string(user_input, R).
read_number(R) :- read_str(S), number_string(R, S).

% Faz um print da string passada pela função colorir,
% aplicando as tags de cor.
% Hello &vWorld&r ira imprimir world em cor verde.
print_cor(String) :-
    colorir(String, R),
    write(R).

% Mesmo do acima, mas permite formatação via format/2.
print_cor(FormatString, Args) :-
    colorir(FormatString, S),
    format(S, Args).

% resetar
codigo_cor(r, "\e[0m").
% negrito (bold)
codigo_cor(b, "\e[1m").
% laranja
codigo_cor(l, "\e[1;33m").
% verde
codigo_cor(v, "\e[32m").
% azul
codigo_cor(a, "\e[36m").
% ciano
codigo_cor(c, "\e[0;36m").

colorir(String, R) :-
    string_chars(String, Chars),
    colorir_chars(Chars, CharsCor),
    string_chars(R, CharsCor).

colorir_chars(['&', X | T], R) :-
    codigo_cor(X, Codigo),
    string_chars(Codigo, Chars),
    colorir_chars(T, T1),
    append(Chars, T1, R),
    !.
colorir_chars([H | T], [H | T1]) :- colorir_chars(T, T1).
colorir_chars([], []).

% Limpa a tela do terminal
clear_screen :-
    (current_prolog_flag(windows, true) ->
        process_create(path(cmd), ['/c', 'cls'], []);
        shell('clear')).

aguarde_enter :-
    print_cor('\n&aPressione enter para continuar...&r\n'),
    get_single_char(_),
    nl.

% Exibe o menu de escolhas e executa a opção escolhida.
% Escolhas é uma lista de tuplas, do tipo ("Descricao", predicado).
print_menu_escolhas(Escolhas) :-
    imprimir_opcoes(Escolhas, 1),
    nl,
    length(Escolhas, MaxIndex),
    ler_numero_escolhas('Escolha uma opção: ', MaxIndex, Index),
    nth1(Index, Escolhas, (_, Predicado)),
    call(Predicado).

% Garante que o número lido é uma opção válida, ou seja, entre 1 e MaxIndex
ler_numero_escolhas(Prompt, MaxIndex, R) :-
    write(Prompt),
    (read_number(R), between(1, MaxIndex, R), !)
    ; (writeln('Opção inválida!'), ler_numero_escolhas(Prompt, MaxIndex, R)).

% Imprime as opções do menu.
imprimir_opcoes([], _).
imprimir_opcoes([(Opcao, _)|Resto], N) :-
    write(N), write('. '), write(Opcao), nl,
    N1 is N + 1,
    imprimir_opcoes(Resto, N1).