
module Menus.Logado where

import Menus.Util (printMenuEscolhas, readLnPrompt)
import System.Exit (exitSuccess)

import qualified Controllers.SalaController as SalaController
import Control.Monad (forM_)
import Utils (enumerate)
import Models.Sala (Sala(nomeSala))
import Models.Usuario
import System.Console.ANSI (clearScreen)
import qualified Menus.Cores as Cores
import GHC.RTS.Flags (TraceFlags(user))

import Control.Monad.IO.Class (liftIO)

bemVindo :: [String] 
bemVindo = [
   "╔══════════════════════════════════════════════════════════╗",    
   "║    ____                  __     ___           _          ║",
   "║   | __ )  ___ _ __ ___   | |   / (_)_ __   __| | ___     ║",
   "║   |  _ | / _ | '_ ` _ |   | | / /| | '_ | / _` |/ _ |    ║",
   "║   | |_) |  __/ | | | | |   | V / | | | | | (_| | (_) |   ║",
   "║   |____/ |___|_| |_| |_|    |_/  |_|_| |_||__,_||___/    ║",
   "╚══════════════════════════════════════════════════════════╝"
 ]

sala :: [String] 
sala = [
   "╔══════════════════════════════════════════════════════════╗",    
   "║                ____        _                             ║",
   "║               / ___|  __ _| | __ _                       ║",
   "║               |___ | / _` | |/ _` |                      ║",
   "║                ___) | (_| | | (_| |                      ║",
   "║               |____/ |__,_|_||__,_|                      ║",
   "╚══════════════════════════════════════════════════════════╝"
 ]

menuLogado :: Usuario -> IO ()
menuLogado user = do
    putStrLn $ Cores.amarelo ++ unlines bemVindo ++ Cores.reseta
    printMenuEscolhas [
        ("Ver Sala", menuVerSala),
        ("Reservar Sala", reservarSala user),
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

reservarSala :: Usuario -> IO ()
reservarSala user = do
    clearScreen
    numeroSala <- readLnPrompt "Digite o número da sala: "
    horarioInicio <- readLnPrompt "Digite o horário de início (HH:MM): "
    horarioFim <- readLnPrompt "Digite o horário de fim (HH:MM): "

    resposta <- SalaController.reservarSala numeroSala user horarioInicio horarioFim 
    case resposta of
        Left erro -> putStrLn erro
        Right _ -> do
            putStrLn "Reserva feita com sucesso!"
            menuVerSala