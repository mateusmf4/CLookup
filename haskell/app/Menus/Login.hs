module Menus.Login where

import Menus.Util (readLnPrompt)
import Menus.Logado (menuLogado)
import Repository (fetchEstudante, fetchProfessor)
import Data.Maybe (isJust)
import System.Console.ANSI (clearScreen)
import qualified Menus.Cores as Cores

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
    estudante <- Repository.fetchEstudante matricula
    professor <- Repository.fetchProfessor matricula
    if isJust estudante then do
        menuLogado estudante
    else if isJust professor then do
        menuLogado professor
    else do
        putStrLn "Não existe usuário com essa matrícula!"
        return()
