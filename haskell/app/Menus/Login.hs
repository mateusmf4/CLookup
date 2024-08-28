module Menus.Login where

import Menus.Util (printBanner, readLnPrompt)
import Menus.Logado (menuLogado)
import Repository (fetchEstudante, fetchProfessor)
import Data.Maybe (isJust)
import Models.Estudante (Estudante)
import Models.Professor (Professor)

menuLogin :: IO()
menuLogin = do
    printBanner
    matricula <- readLnPrompt "Digite sua matrícula: "
    estudante <- studentUser matricula
    professor <- professorUser matricula
    if isJust estudante then do
        menuLogado estudante
    else if isJust professor then do
        menuLogado professor
    else do
        putStrLn "Não existe usuário com essa matrícula!"
        return()

studentUser :: Int -> IO (Maybe Estudante)
studentUser matricula = Repository.fetchEstudante matricula

professorUser :: Int -> IO (Maybe Professor)
professorUser matricula = Repository.fetchProfessor matricula