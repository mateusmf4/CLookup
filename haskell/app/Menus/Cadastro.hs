module Menus.Cadastro where

import Menus.Util (printBanner, getLinePrompt, readLnPrompt)
import Menus.Logado (menuLogado)

import qualified Controllers.EstudanteController as EstudanteController

menuCadastro :: IO()
menuCadastro = do
    printBanner
    putStrLn "Cadastrar como:"
    putStrLn ""
    putStrLn "1- Estudante"
    putStrLn "2- Professor"
    putStrLn "3- Voltar"
    putStrLn ""
    opcao <- getLinePrompt "Digite a opcao: "
    escolher opcao

escolher :: String -> IO()
escolher opcao
    | opcao == "1" = cadastroEstudante
    | opcao == "2" = return () -- cadastroProfessorController
    | opcao == "3" = return ()
    | otherwise = putStrLn "Opção Inválida"

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
