:- module(utils, [readStr/1, readNumber/1, printCor/1, printCor/2]).

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