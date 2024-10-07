:- module(cadastro, [menuCadastro/0]).
:- use_module('Menus/Utils.pl').
:- use_module('Menus/Logado.pl', [menu_logado/1]).
:- use_module('Menus/Inicio.pl', [menuInicio/0]).
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
    (I == 1 -> realizarCadastro(estudante); I == 2 -> realizarCadastro(professor); I == 3 -> menuInicio; writeln("Erro: Opção inválida!")),
    menuCadastro.

realizarCadastro(Tipo) :-
    writeln("Nome: "), read_str(N),
    writeln("Matrícula: "), read_number(M),
    (fetch_usuario(M, _) -> 
        (writeln("Usuário com mesma matricula já existe!"), aguarde_enter, menuInicio);
        newUsuario(M, N, Tipo, User),
        save_usuario(User),
        writeln("Cadastro realizado com sucesso!"),
        aguarde_enter,
        menu_logado(User)
    ).