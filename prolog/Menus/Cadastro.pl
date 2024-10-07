:- module(cadastro, [menuCadastro/0]).
:- use_module('Menus/Utils.pl').
:- use_module('Menus/Logado.pl', [menu_logado/1]).
:- use_module('Menus/Inicio.pl', [menuInicio/0]).
:- use_module('Models/Usuario.pl').
:- use_module('Controllers/UsuarioController.pl').

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
    usuario_controller:cadastra_usuario(M, N, Tipo, Resultado),
    (Resultado = erro(erro) -> writeln(erro);
    Resultado = sucesso(Usuario) -> (
        writeln('Cadastro feito com sucesso!'),
        aguarde_enter,
        menu_logado(Usuario)
    )).