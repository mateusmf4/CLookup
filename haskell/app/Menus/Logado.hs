
module Menus.Logado where

import Menus.Util (printMenuEscolhas, readLnPrompt, getLinePrompt, lerDataHora)
import System.Exit (exitSuccess)
import qualified Controllers.SalaController as SalaController
import Control.Monad (forM_)
import Utils (enumerate)
import Models.Sala (Sala(nomeSala), Reserva (Reserva))
import qualified Menus.Cores as Cores
import GHC.RTS.Flags (TraceFlags(user))
import System.Console.ANSI (clearScreen)
import Controllers.EstudanteController (atualizaMonitor)
import Models.Usuario (Usuario (Prof, Est), matriculaUsuario)

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

textoSala :: [String]
textoSala = [
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
    putStrLn "Bem vindo ao menu logado\n"
    case user of
        Est _ -> printMenuEscolhas [
            ("Ver Sala", menuVerSala),
            ("Reservar Sala", reservarSala user),
            ("Cancelar Reserva", cancelarReserva user),
            ("Sair", exitSuccess)
            ]
        Prof _ ->  printMenuEscolhas [
            ("Ver Sala", menuVerSala),
            ("Reservar Sala", reservarSala user),
            ("Tornar usuário monitor", menuMonitor),
            ("Cancelar Reserva", cancelarReserva user),
            ("Sair", exitSuccess)
            ]
    menuLogado user

menuVerSala :: IO ()
menuVerSala = do
    clearScreen
    putStrLn $ Cores.amarelo ++ unlines textoSala ++ Cores.reseta
    salas <- SalaController.listarSalas
    forM_ (enumerate salas) $ \(i, sala) -> do
        putStrLn $ show (i + 1) ++ ". " ++ nomeSala sala

reservarSala :: Usuario -> IO ()
reservarSala user = do
    clearScreen
    numeroSala <- readLnPrompt "Digite o número da sala: "
    horarioInicio <- lerDataHora "Digite o horário de início (DD/MM/AAAA HH:MM): "
    horarioFim <- lerDataHora "Digite o horário de fim (DD/MM/AAAA HH:MM): "

    resposta <- SalaController.reservarSala numeroSala user horarioInicio horarioFim
    case resposta of
        Left erro -> putStrLn erro
        Right _ -> do
            putStrLn "Reserva feita com sucesso!\n"

cancelarReserva :: Usuario -> IO()
cancelarReserva user = do
    numeroSala <- readLnPrompt "Digite o número da sala: "
    horarioInicio <- lerDataHora "Digite o horário de início (DD/MM/AAAA HH:MM): "
    horarioFim <- lerDataHora "Digite o horário de fim (DD/MM/AAAA HH:MM): "
    let reserva = Reserva (matriculaUsuario user) horarioInicio horarioFim
    resposta <- SalaController.cancelarReserva numeroSala reserva
    
    case resposta of
        Left erro -> putStrLn erro
        Right _ -> do
            putStrLn "Reserva cancelada com sucesso!\n"
            menuVerSala

menuMonitor :: IO()
menuMonitor = do
    clearScreen
    matricula <- getLinePrompt "Informe a matricula do aluno: "
    valor <- atualizaMonitor (read matricula) True
    case valor of
        Left erro -> putStrLn erro
        Right _ -> do
            putStrLn "Monitor adicionado!\n"
