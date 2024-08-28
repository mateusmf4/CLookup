module Menus.Logado where
import Menus.Util (printBanner, printMenuEscolhas)
import System.Exit (exitSuccess)

menuLogado :: a -> IO ()
menuLogado user = do
    printBanner
    putStrLn "Bem vindo ao menu logado\n"
    printMenuEscolhas [
        ("Listar Salas", return ()),
        ("Ver Sala", return ()),
        ("Reservar Sala", return ()),
        ("Sair", exitSuccess)
        ]
    menuLogado user
