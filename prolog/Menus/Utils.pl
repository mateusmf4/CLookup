:- module(utils, [readStr/1, readNumber/1, printCor/1, printCor/2, clearScreen/0, aguarde_enter/0, print_menu_escolhas/1]).

readStr(R) :- read_line_to_string(user_input, R).
readNumber(R) :- readStr(S), number_string(R, S).

% Faz um print da string passada pela função colorir,
% aplicando as tags de cor.
% Hello &vWorld&r ira imprimir world em cor verde.
printCor(String) :-
    colorir(String, R),
    write(R).

% Mesmo do acima, mas permite formatação via format/2.
printCor(FormatString, Args) :-
    colorir(FormatString, S),
    format(S, Args).

% resetar
codigoCor(r, "\e[0m").
% negrito (bold)
codigoCor(b, "\e[1m").
% laranja
codigoCor(l, "\e[1;33m").
% verde
codigoCor(v, "\e[32m").
% azul
codigoCor(a, "\e[36m").

colorir(String, R) :-
    string_chars(String, Chars),
    colorirChars(Chars, CharsCor),
    string_chars(R, CharsCor).

colorirChars(['&', X | T], R) :-
    codigoCor(X, Codigo),
    string_chars(Codigo, Chars),
    colorirChars(T, T1),
    append(Chars, T1, R),
    !.
colorirChars([H | T], [H | T1]) :- colorirChars(T, T1).
colorirChars([], []).

% Limpa a tela do terminal
clearScreen :-
    (current_prolog_flag(windows, true) ->
        process_create(path(cmd), ['/c', 'cls'], []);
        shell('clear')).

aguarde_enter :-
    printCor('\n&aPressione enter para continuar...&r\n'),
    get_single_char(_),
    nl.

% Exibe o menu de escolhas e executa a opção escolhida.
% Escolhas é uma lista de tuplas, do tipo ("Descricao", predicado).
print_menu_escolhas(Escolhas) :-
    imprimir_opcoes(Escolhas, 1),
    write('Escolha uma opção: '),
    readNumber(Index),
    nth1(Index, Escolhas, (_, Predicado)),
    call(Predicado).

% Imprime as opções do menu.
imprimir_opcoes([], _).
imprimir_opcoes([(Opcao, _)|Resto], N) :-
    write(N), write('. '), write(Opcao), nl,
    N1 is N + 1,
    imprimir_opcoes(Resto, N1).