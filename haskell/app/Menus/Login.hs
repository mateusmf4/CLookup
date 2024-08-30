module Menus.Login where

import Menus.Util (readLnPrompt)
import Menus.Logado (menuLogado)
import System.Console.ANSI (clearScreen)
import qualified Menus.Cores as Cores
import qualified Repository

login :: [String] 
login = [
   "╔══════════════════════════════════════════════════════════╗", 
   "║                _                _                        ║",
   "║               | |    ___   __ _(_)_ __                   ║",
   "║               | |   / _ | / _` | | '_ |                  ║",
   "║               | |__| (_) | (_| | | | | |                 ║",
   "║               |_____║___/ ║__, |_|_| |_|                 ║",
   "║                           |___/                          ║",
   "╚══════════════════════════════════════════════════════════╝"
 ]

menuLogin :: IO()
menuLogin = do
    clearScreen
    putStrLn $ Cores.amarelo ++ unlines login ++ Cores.reseta
    matricula <- readLnPrompt "Digite sua matrícula: "
    maybeUser <- Repository.fetchUsuario matricula
    case maybeUser of
        Just usuario -> menuLogado usuario
        Nothing -> do
            putStrLn "Não existe usuário com essa matrícula!"
            return()
