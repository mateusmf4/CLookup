-- Menu que inicializa o sistema
module Menus.Inicio where

-- Importações necessárias para o funcionamento adequado
import System.Exit (exitSuccess)
import Menus.Util (escolherOpcoes)
import Menus.Cadastro (menuCadastro)
import Menus.Login (menuLogin)
import qualified Menus.Cores as Cores
import System.Console.ANSI (clearScreen)

-- Tela inicial, menu que mostra as funcionalidades para o usuário
menu :: [String]
menu = [
        "╔═══════════════════════════════════════════════════════════════════════════════╗",
        "║                                                                               ║",
        "║                 ______  __                 __               _______           ║",
        "║               .' ___  |[  |               [  |  _          |_   __ |          ║",
        "║             / .'   |_| | |  .--.    .--.  | | / ] __   _    | |__) |          ║",
        "║             | |        | |/ .'`| |/ .'`| || '' < [  | | |   |  ___/           ║",
        "║             | `.___.'| | || |__. || |__. || |`| | | |_/ |, _| |_              ║",
        "║              `.____ .'[___]'.__.'  '.__.'[__|  |_]'.__.'_/|_____|             ║",
        "║                                                                               ║",
        "║       Menu:                                                                   ║",
        "║          " ++ Cores.reseta ++ Cores.negrito ++ "1. Login      " ++ Cores.laranja ++ "                                                       ║",
        "║          " ++ Cores.reseta ++ Cores.negrito ++ "2. Cadastro   " ++ Cores.laranja ++ "                                                       ║",
        "║          " ++ Cores.reseta ++ Cores.negrito ++ "3. Sair       " ++ Cores.laranja ++ "                                                       ║",
        "║                                                                               ║",
        "║                                                                               ║",
        "║       Digite a opção:                                                         ║",
        "╚═══════════════════════════════════════════════════════════════════════════════╝"
    ]

-- Carrega o menu inicial para que o usuário consiga acessar uma determinada funcionalidade 
menuInicio :: IO()
menuInicio = do
    clearScreen
    putStrLn $ Cores.laranja ++ unlines menu ++ Cores.reseta
    escolherOpcoes [
        menuLogin,
        menuCadastro,
        sair
     ]
    -- loop infinito, já que o unico jeito de sair é utilizando a opção de sair
    menuInicio

-- Função que interrompe o loop inicializado e finaliza a execução do menu principal
sair :: IO()
sair = do
    putStrLn "Até Mais!"
    exitSuccess