module Menus.Inicio where

import System.Exit (exitSuccess)
import Menus.Util (printBanner)
import Menus.Cadastro (menuCadastro)
import Menus.Calendario (showToday)

menuInicio :: IO()
menuInicio = do
    printBanner
    putStrLn "Digite a opcao desejada:"
    putStrLn ""
    putStrLn "1- Login"
    putStrLn "2- Cadastro"
    putStrLn "3- Calendario"
    putStrLn "4- Sair"
    putStrLn ""
    putStr "Digite a opcao: "
    opcao <- getLine
    escolher opcao
    -- loop infinito, já que o unico jeito de sair é utilizando
    -- a opção 3
    menuInicio

escolher :: String -> IO()
escolher opcao
    | opcao == "1" = return() -- Controllers.LoginController.logar
    | opcao == "2" = menuCadastro
    | opcao == "3" = showToday
    | opcao == "4" = sair
    | otherwise = putStrLn "Error: Opcao Invalida!\n"

sair :: IO()
sair = do
    putStrLn "Até Mais!"
    exitSuccess