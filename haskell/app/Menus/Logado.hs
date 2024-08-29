module Menus.Logado where
import Menus.Util (printMenuEscolhas)
import System.Exit (exitSuccess)

menuLogado :: a -> IO ()
menuLogado user = do
    putStrLn "Bem vindo ao menu logado\n"
    printMenuEscolhas [
        ("Listar Salas", return ()),
        ("Ver Sala", return ()),
        ("Reservar Sala", return ()),
        ("Sair", exitSuccess)
        ]
    menuLogado user
