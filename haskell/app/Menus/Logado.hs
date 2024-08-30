module Menus.Logado where

import Menus.Util (printMenuEscolhas, getLinePrompt)
import System.Exit (exitSuccess)

import qualified Controllers.SalaController as SalaController
import Control.Monad (forM_)
import Utils (enumerate)
import Models.Sala
import Models.Usuario
import Controllers.EstudanteController (atualizaMonitor)

menuLogado :: Usuario -> IO ()
menuLogado user = do
    putStrLn "Bem vindo ao menu logado\n"
    case user of
        Est _ -> printMenuEscolhas [
            ("Ver Sala", menuVerSala),
            ("Reservar Sala", return()),
            ("Sair", exitSuccess)
            ]
        Prof _ ->  printMenuEscolhas [
            ("Ver Sala", menuVerSala),
            ("Reservar Sala", return()),
            ("Tornar usuário monitor", menuMonitor),
            ("Sair", exitSuccess)
            ]
    menuLogado user

menuVerSala :: IO ()
menuVerSala = do
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