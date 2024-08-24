module Menus.Inicio where

import System.Exit (exitSuccess)
import Menus.Util (printBanner)
import Menus.Cadastro (menuCadastro)

menuInicio :: IO()
menuInicio = do
    printBanner
    putStrLn "Digite a opcao desejada:\n"
    putStrLn "1- Login"
    putStrLn "2- Cadastro"
    putStrLn "3- Sair\n"
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
    | opcao == "3" = sair
    | otherwise = putStrLn "Error: Opcao Invalida!\n"

sair :: IO()
sair = do
    putStrLn "Até Mais!"
    exitSuccess

main :: IO()
main = menuInicio