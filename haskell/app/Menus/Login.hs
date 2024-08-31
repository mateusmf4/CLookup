-- O módulo Login enquadra funções que irão se utilizadas para login, no menu do sistema.
module Menus.Login where
-- Importações necessárias para o funcionamento do código.
import Menus.Util (readLnPrompt, aguardeEnter)
import Menus.Logado (menuLogado)
import System.Console.ANSI (clearScreen)
import qualified Menus.Cores as Cores
import qualified Repository

-- Formata um cabeçalho para dar início ao login no sistema.
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

-- Apresenta propriamente a página Login, do sistema.
menuLogin :: IO()
menuLogin = do
    clearScreen
    putStrLn $ Cores.laranja ++ unlines login ++ Cores.reseta
    matricula <- readLnPrompt "Digite sua matrícula: "
    maybeUser <- Repository.fetchUsuario matricula
    case maybeUser of
        Just usuario -> menuLogado usuario
        Nothing -> do
            putStrLn "Não existe usuário com essa matrícula!"
            aguardeEnter
