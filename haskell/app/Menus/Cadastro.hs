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
   "║                       CADASTRO                           ║",
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
