module Controllers.LoginController where

import Models.Utils.Login

logar :: IO()
logar = do
    putStrLn ("\n--------------------" ++ " ClookuP " ++ "--------------------\n")
    putStrLn "Logar como:\n"
    putStrLn "1- Estudante"
    putStrLn "2- Monitor"
    putStrLn "3- Professor"
    putStrLn "4- Voltar\n"
    putStrLn "Digite a opcao: "
    opcao <- getLine
    escolher opcao

escolher :: String -> IO()
escolher opcao
    | opcao == "1" = loginEstudanteController
    | opcao == "2" = loginMonitorController
    | opcao == "3" = loginProfessorController
    | opcao == "4" = return()
    | otherwise = putStrLn "Opção Inválida"

loginEstudanteController :: IO()
loginEstudanteController = do
    putStrLn "Matrícula do estudante:"
    matricula <- readLn
    loginValido <- Models.Utils.Login.loginEstudante matricula
    if loginValido then do
        putStrLn "Login realizado com sucesso!"
        --Nessa linha vai ter o comando pra ir pro menu, onde vai ter as opões de reservas de sala, cancelamento de reserva, etc
    else putStrLn "Nome ou matrícula incorreto!"

loginMonitorController :: IO()
loginMonitorController = do
    putStrLn "Matrícula do monitor:"
    matricula <- readLn
    loginValido <- Models.Utils.Login.loginEstudante matricula
    if loginValido then do
        putStrLn "Login realizado com sucesso!"
        --Nessa linha vai ter o comando pra ir pro menu, onde vai ter as opões de reservas de sala, cancelamento de reserva, etc
    else putStrLn "Nome ou matrícula incorreto!"

loginProfessorController :: IO()
loginProfessorController = do
    putStrLn "Matrícula do professor:"
    matricula <- readLn
    loginValido <- Models.Utils.Login.loginProfessor matricula
    if loginValido then do
        putStrLn "Login realizado com sucesso!"
        --Nessa linha vai ter o comando pra ir pro menu, onde vai ter as opões de reservas de sala, cancelamento de reserva, etc
    else putStrLn "Nome ou matrícula incorreto!"