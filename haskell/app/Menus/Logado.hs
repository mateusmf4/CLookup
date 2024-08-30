module Menus.Logado where
import Menus.Util (printMenuEscolhas)
import System.Exit (exitSuccess)

import qualified Controllers.SalaController as SalaController
import Control.Monad (forM_)
import Utils (enumerate)
import Models.Sala (Sala(nomeSala))
import System.Console.ANSI (clearScreen)
import qualified Menus.Cores as Cores


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

menuLogado :: usuarioLogado -> IO ()
menuLogado user = do
    putStrLn $ Cores.amarelo ++ unlines bemVindo ++ Cores.reseta
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

