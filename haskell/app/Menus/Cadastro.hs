module Menus.Cadastro where

import Menus.Util (getLinePrompt, readLnPrompt, printMenuEscolhas)
import Menus.Logado (menuLogado)
import System.Console.ANSI (clearScreen)
import qualified Menus.Cores as Cores

import qualified Controllers.EstudanteController as EstudanteController
import qualified Controllers.ProfessorController as ProfessorController

cadastro :: [String] 
cadastro = [
   "╔══════════════════════════════════════════════════════════╗",                       
   "║         ____          _           _                      ║",
   "║        / ___|__ _  __| | __ _ ___| |_ _ __ ___           ║",
   "║       | |   / _` |/ _` |/ _` / __| __| '__/ _ |          ║",
   "║       | |__| (_| | (_| | (_| |__ | |_| | | (_) |         ║",
   "║        |____|__,_||__,_||__,_|___/|__|_|  |___/          ║",
   "╚══════════════════════════════════════════════════════════╝"
 ]

menuCadastro :: IO()
menuCadastro = do
    clearScreen
    putStrLn $ Cores.amarelo ++ unlines cadastro ++ Cores.reseta
    putStrLn "Cadastrar como:\n"
    printMenuEscolhas [
        ("Estudante", cadastroEstudante),
        ("Professor", cadastroProfessor),
        ("Voltar", return ())
        ]

cadastroEstudante :: IO()
cadastroEstudante = do
    nome <- getLinePrompt "Nome: "
    matricula <- readLnPrompt "Matricula: "

    valor <- EstudanteController.cadastro nome matricula False
    case valor of
        Left erro -> putStrLn erro
        Right user -> do
            putStrLn "Cadastro feito com succeso!"
            menuLogado user

cadastroProfessor :: IO()
cadastroProfessor = do
    nome <- getLinePrompt "Nome: "
    matricula <- readLnPrompt "Matricula: "

    valor <- ProfessorController.cadastro nome matricula
    case valor of
        Left erro -> putStrLn erro
        Right user -> do
            putStrLn "Cadastro feito com succeso!"
            menuLogado user
