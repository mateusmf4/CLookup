module Menus.Logado where
import Menus.Util (printMenuEscolhas)
import System.Exit (exitSuccess)

import qualified Controllers.SalaController as SalaController
import Control.Monad (forM_)
import Utils (enumerate)
import Models.Sala (Sala(nomeSala))

-- TODO: trocar esse `a` por um tipo UsuarioLogado sla

menuLogado :: a -> IO ()
menuLogado user = do
    putStrLn "Bem vindo ao menu logado\n"
    printMenuEscolhas [
        ("Ver Sala", menuVerSala),
        ("Reservar Sala", return ()),
        ("Sair", exitSuccess)
        ]
    menuLogado user

menuVerSala :: IO ()
menuVerSala = do
    salas <- SalaController.listarSalas
    forM_ (enumerate salas) $ \(i, sala) -> do
        putStrLn $ (show (i + 1)) ++ ". " ++ (nomeSala sala)
