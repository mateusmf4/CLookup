module Modules.MenuPrincipal where
import System.Exit (exitSuccess)

printar :: IO()
printar = do
    putStrLn ("\n--------------------" ++ " CPBooking " ++ "--------------------\n")
    putStrLn "Digite a opção desejada:\n"
    putStrLn "1- Login"
    putStrLn "2- Cadastro"
    putStrLn "3- Sair\n"
    putStrLn "Digite a opção: "
    opcao <- getLine
    opcaoSelecionada opcao
    printar

opcaoSelecionada :: String -> IO()
opcaoSelecionada opcao
--    | opcao == "1" = Modules.Controllers.LoginController.logar
--    | opcao == "2" = Modules.Controllers.CadastroController.cadastrar
    | opcao == "3" = sair
    | otherwise = putStrLn "Error: Opção Inválida!\n"

sair :: IO()
sair = do
    putStrLn "Até Mais!"
    exitSuccess