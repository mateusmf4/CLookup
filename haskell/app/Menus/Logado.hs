module Menus.Logado where
import Menus.Util (printBanner, getLinePrompt)
import System.Exit (exitSuccess)

menuLogado :: a -> IO ()
menuLogado user = do
    printBanner
    putStrLn "Bem vindo ao menu logado"
    putStrLn ""
    putStrLn "1- Listar Salas"
    putStrLn "2- Ver Sala"
    putStrLn "3- Reservar Sala"
    putStrLn "4- Sair"
    putStrLn ""
    opcao <- getLinePrompt "Opcao: "
    escolher opcao
    menuLogado user

escolher :: String -> IO()
escolher opcao
    | opcao == "1" = return () -- listar salar
    | opcao == "2" = return () -- ver sala especifica
    | opcao == "3" = return () -- reservar sala especifica
    | opcao == "4" = exitSuccess
    | otherwise = putStrLn "Opção Inválida"
