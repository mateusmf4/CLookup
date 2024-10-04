:- module(cadastro, [menuCadastro/0]).
:- use_module('Menus/Utils.pl').
:- use_module('./Repository.pl').
:- use_module('./Models/Usuario.pl').

cadastro:-
    print_cor("&l╔══════════════════════════════════════════════════════════╗\n"),
    print_cor("║         ____          _           _                      ║\n"),
    print_cor("║        / ___|__ _  __| | __ _ ___| |_ _ __ ___           ║\n"),
    print_cor("║       | |   / _` |/ _` |/ _` / __| __| '__/ _ |          ║\n"),
    print_cor("║       | |__| (_| | (_| | (_| |__ | |_| | | (_) |         ║\n"),
    print_cor("║        |____|__,_||__,_||__,_|___/|__|_|  |___/          ║\n"),
    print_cor("╚══════════════════════════════════════════════════════════╝&r\n").

menuCadastro:- 
    clear_screen,
    cadastro,
    writeln("Cadastrar como:\n"),
    writeln("1. Estudante"), writeln("2. Professor"), writeln("3. Voltar"),
    read_number(I),
    (I == 1 -> cadastroEstudante; I == 2 -> cadastroProfessor; I == 3 -> menuInicio; writeln("Erro: Opção inválida!")),
    menuCadastro.

cadastroEstudante:-
    writeln("Nome: "), read_str(N),
    writeln("Matrícula: "), read_number(M),
    atom_length(M, Length),
    (Length =\= 9 -> writeln("Matrícula inválida!"); 
    (fetch_usuario(M, U) -> 
        writeln("Usuário com mesma matricula já existe!");
        newUsuario(M, N, estudante, User),
        save_usuario(User),
        writeln("Cadastro realizado com sucesso!"),
        aguarde_enter
    )),
    menuInicio.

cadastroProfessor:-
    writeln("Nome: "), read_str(N),
    writeln("Matrícula: "), read_number(M),
    atom_length(M, Length),
    (Length =\= 9 -> writeln("Matrícula inválida!"); 
    (fetch_usuario(M, U) -> 
        writeln("Usuário com mesma matricula já existe!");
        newUsuario(M, N, professor, User),
        save_usuario(User),
        writeln("Cadastro realizado com sucesso!"),
        aguarde_enter
    )),
    menuInicio.