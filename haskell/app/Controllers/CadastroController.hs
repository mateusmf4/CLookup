module Controllers.CadastroController where

import Models.Utils.Cadastro

cadastrar :: IO()
cadastrar = do
    putStrLn ("\n--------------------" ++ " ClookuP " ++ "--------------------\n")
    putStrLn "Cadastrar como:\n"
    putStrLn "1- Estudante"
    putStrLn "2- Monitor"
    putStrLn "3- Professor"
    putStrLn "4- Voltar\n"
    putStrLn "Digite a opcao: "
    opcao <- getLine
    escolher opcao

escolher :: String -> IO()
escolher opcao
    | opcao == "1" = cadastroEstudanteController
    | opcao == "2" = cadastroMonitorController
    | opcao == "3" = cadastroProfessorController
    | opcao == "4" = return()
    | otherwise = putStrLn "Opção Inválida"

cadastroEstudanteController :: IO()
cadastroEstudanteController = do
    putStrLn "Nome do estudante:"
    nome <- getLine
    putStrLn "Matrícula do estudante:"
    matricula <- readLn
    cadastroValido <- Models.Utils.Cadastro.cadastroEstudante nome matricula
    if cadastroValido then do
        putStrLn "Cadastro realizado com sucesso!"
        -- Nessa linha vai ter o comando pra ir pro menu, onde vai ter as opões de reservas de sala, cancelamento de reserva, etc
        -- Provavelmente EstudanteController.menu
    else putStrLn "Já existe um cadastro com essa matrícula!"

cadastroMonitorController :: IO()
cadastroMonitorController = do
    putStrLn "Nome do monitor:"
    nome <- getLine
    putStrLn "Matrícula do monitor:"
    matricula <- readLn
    cadastroValido <- Models.Utils.Cadastro.cadastroMonitor nome matricula
    if cadastroValido then do
        putStrLn "Cadastro realizado com sucesso!"
        -- Nessa linha vai ter o comando pra ir pro menu, onde vai ter as opões de reservas de sala, cancelamento de reserva, etc
        -- Provavelmente MonitorController.menu
    else putStrLn "Nome ou matrícula incorreto!"

cadastroProfessorController :: IO()
cadastroProfessorController = do
    putStrLn "Nome do professor:"
    nome <- getLine
    putStrLn "Matrícula do professor:"
    matricula <- readLn
    cadastroValido <- Models.Utils.Cadastro.cadastroProfessor nome matricula
    if cadastroValido then do
        putStrLn "Cadastro realizado com sucesso!"
        -- Nessa linha vai ter o comando pra ir pro menu, onde vai ter as opões de reservas de sala, cancelamento de reserva, etc
        -- Provavelmente ProfessorController.menu
    else putStrLn "Nome ou matrícula incorreto!"