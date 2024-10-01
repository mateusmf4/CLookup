:- module(cadastro, [menuCadastro/0]).
:- use_module('Menus/Utils.pl').
:- use_module('./Repository.pl').
:- use_module('./Models/Usuario.pl').

cadastro:-
    printCor("&l╔══════════════════════════════════════════════════════════╗\n"),
    printCor("║         ____          _           _                      ║\n"),
    printCor("║        / ___|__ _  __| | __ _ ___| |_ _ __ ___           ║\n"),
    printCor("║       | |   / _` |/ _` |/ _` / __| __| '__/ _ |          ║\n"),
    printCor("║       | |__| (_| | (_| | (_| |__ | |_| | | (_) |         ║\n"),
    printCor("║        |____|__,_||__,_||__,_|___/|__|_|  |___/          ║\n"),
    printCor("╚══════════════════════════════════════════════════════════╝&r\n").

menuCadastro:- 
    clearScreen,
    cadastro,
    writeln("Cadastrar como:\n"),
    writeln("1. Estudante"), writeln("2. Professor"), writeln("3. Voltar"),
    readNumber(I),
    (I == 1 -> cadastroEstudante; I == 2 -> cadastroProfessor; I == 3 -> menuInicio; writeln("Erro: Opção inválida!")),
    menuCadastro.

cadastroEstudante:-
    writeln("Nome: "), readStr(N),
    writeln("Matrícula: "), readNumber(M),
    atom_length(M, Length),
    (Length =\= 9 -> writeln("Matrícula inválida!"); 
    (fetchUsuario(M, U) -> 
        writeln("Usuário com mesma matricula já existe!");
        newUsuario(M, N, estudante, User),
        saveUsuario(User),
        writeln("Cadastro realizado com sucesso!"),
        aguarde_enter
    )),
    menuInicio.

cadastroProfessor:-
    writeln("Nome: "), readStr(N),
    writeln("Matrícula: "), readNumber(M),
    atom_length(M, Length),
    (Length =\= 9 -> writeln("Matrícula inválida!"); 
    (fetchUsuario(M, U) -> 
        writeln("Usuário com mesma matricula já existe!");
        newUsuario(M, N, professor, User),
        saveUsuario(User),
        writeln("Cadastro realizado com sucesso!"),
        aguarde_enter
    )),
    menuInicio.