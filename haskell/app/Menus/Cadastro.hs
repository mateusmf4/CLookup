-- Menu onde pode ser feito o cadastro de usuarios
module Menus.Cadastro where

import Menus.Util (getLinePrompt, readLnPrompt, printMenuEscolhas, aguardeEnter)
import Menus.Logado (menuLogado)
import System.Console.ANSI (clearScreen)
import qualified Menus.Cores as Cores

import qualified Controllers.EstudanteController as EstudanteController
import qualified Controllers.ProfessorController as ProfessorController
import Models.Usuario (Usuario(Est, Prof))

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

-- Menu que apresenta as escolhas de cadastro
menuCadastro :: IO()
menuCadastro = do
    clearScreen
    putStrLn $ Cores.laranja ++ unlines cadastro ++ Cores.reseta
    putStrLn "Cadastrar como:\n"
    printMenuEscolhas [
        ("Estudante", cadastroEstudante),
        ("Professor", cadastroProfessor),
        ("Voltar", return ())
        ]

-- Menu que cadastra um estudante
cadastroEstudante :: IO()
cadastroEstudante = do
    nome <- getLinePrompt "Nome: "
    matricula <- readLnPrompt "Matricula: "

    valor <- EstudanteController.cadastro nome matricula False
    case valor of
        Left erro -> do
            putStrLn erro
            aguardeEnter
        Right user -> do
            putStrLn "Cadastro feito com succeso!"
            aguardeEnter
            menuLogado $ Est user

-- Menu que cadastra um professor
cadastroProfessor :: IO()
cadastroProfessor = do
    nome <- getLinePrompt "Nome: "
    matricula <- readLnPrompt "Matricula: "

    valor <- ProfessorController.cadastro nome matricula
    case valor of
        Left erro -> do
            putStrLn erro
            aguardeEnter
        Right user -> do
            putStrLn "Cadastro feito com succeso!"
            aguardeEnter
            menuLogado $ Prof user
