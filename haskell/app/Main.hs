module Main where

import System.Exit
import Controllers.LoginController
import Controllers.CadastroController

printar :: IO()
printar = do
    putStrLn ("\n--------------------" ++ " CLookup " ++ "--------------------\n")
    putStrLn "Digite a opcao desejada:\n"
    putStrLn "1- Login"
    putStrLn "2- Cadastro"
    putStrLn "3- Sair\n"
    putStrLn "Digite a opcao: "
    opcao <- getLine
    opcaoSelecionada opcao
    printar

opcaoSelecionada :: String -> IO()
opcaoSelecionada opcao
    | opcao == "1" = Controllers.LoginController.logar
    -- | opcao == "2" = Controllers.CadastroController.cadastrar
    | opcao == "3" = sair
    | otherwise = putStrLn "Error: Opcao Invalida!\n"

sair :: IO()
sair = do
    putStrLn "Até Mais!"
    exitSuccess

main :: IO()
main = printar