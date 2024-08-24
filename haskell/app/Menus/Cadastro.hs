module Menus.Cadastro where

import Menus.Util (printBanner)
import Models.Estudante
import qualified Repository
import Data.Maybe (isJust)

menuCadastro :: IO()
menuCadastro = do
    printBanner
    putStrLn "Cadastrar como:\n"
    putStrLn "1- Estudante"
    putStrLn "2- Monitor"
    putStrLn "3- Professor"
    putStrLn "4- Voltar\n"
    putStr "Digite a opcao: "
    opcao <- getLine
    escolher opcao

escolher :: String -> IO()
escolher opcao
    | opcao == "1" = cadastroEstudante
    | opcao == "2" = return () -- cadastroMonitorController
    | opcao == "3" = return () -- cadastroProfessorController
    | opcao == "4" = return ()
    | otherwise = putStrLn "Opção Inválida"

cadastroEstudante :: IO()
cadastroEstudante = do
    putStr "Nome: "
    nome <- getLine
    putStr "Matricula: "
    matricula <- readLn
    existe <- isJust <$> Repository.fetchEstudante matricula
    if existe then do
        putStrLn "Estudante com mesma matricula ja existe!"
        return ()
    else do
        let estudante = Estudante { nome = nome, matricula = matricula, monitor = False }
        Repository.saveEstudante estudante
        putStrLn "Cadastro feito com sucesso!"
        return ()
