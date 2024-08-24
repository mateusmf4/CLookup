module Menus.Cadastro where

import Menus.Util (printBanner)

menuCadastro :: IO()
menuCadastro = do
    printBanner
    putStrLn "Cadastrar como:\n"
    putStrLn "1- Estudante"
    putStrLn "2- Monitor"
    putStrLn "3- Professor"
    putStrLn "4- Voltar\n"
    putStr "Digite a opcao: "
    opcao <- getLine
    escolher opcao

escolher :: String -> IO()
escolher opcao
    | opcao == "1" = return () -- cadastroEstudanteController
    | opcao == "2" = return () -- cadastroMonitorController
    | opcao == "3" = return () -- cadastroProfessorController
    | opcao == "4" = return ()
    | otherwise = putStrLn "Opção Inválida"
