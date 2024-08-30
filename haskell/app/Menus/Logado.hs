module Menus.Logado where
import Menus.Util (printMenuEscolhas)
import System.Exit (exitSuccess)

import qualified Controllers.SalaController as SalaController
import Control.Monad (forM_)
import Utils (enumerate)
import Models.Sala (Sala(nomeSala))
import Models.Usuario

menuLogado :: Usuario -> IO ()
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
    clearScreen
    putStrLn $ Cores.amarelo ++ unlines sala ++ Cores.reseta
    salas <- SalaController.listarSalas
    forM_ (enumerate salas) $ \(i, sala) -> do
        putStrLn $ (show (i + 1)) ++ ". " ++ (nomeSala sala)


menuMonitor :: IO()
menuMonitor = do
    matricula <- getLinePrompt "Informe a matricula do aluno: "
    valor <- atualizaMonitor (read matricula) True
    case valor of
        Left erro -> putStrLn erro
        Right _ -> do
            putStrLn "Monitor adicionado!\n"