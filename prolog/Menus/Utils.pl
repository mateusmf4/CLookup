:- module(utils, [readStr/1, readNumber/1]).

readStr(R) :- read_line_to_string(user_input, R).
readNumber(R) :- readStr(S), number_string(R, S).
